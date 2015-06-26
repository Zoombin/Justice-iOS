//
//  JSLawViewController.m
//  Justice
//
//  Created by zhangbin on 6/23/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSLawViewController.h"
#import "Header.h"
#import "JSService.h"
#import "JSServiceCategory.h"

@interface JSLawViewController () <UITableViewDataSource, UITableViewDelegate>

@property (readwrite) UITableView *tableView;
@property (readwrite) NSArray *serviceCategories;

@end

@implementation JSLawViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.title = @"法律服务";
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	[self.view addSubview:_tableView];
	
	[self displayHUD:@"加载中..."];
	[[JSAPIManager shared] servicesInCategories:^(NSArray *multiAttributes, NSError *error, NSString *message) {
		[self hideHUD:YES];
		if (!error) {
			_serviceCategories = [JSServiceCategory multiWithAttributesArray:multiAttributes];
			[_tableView reloadData];
		}
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	JSServiceCategory *serviceCategory = _serviceCategories[section];
	return serviceCategory.services.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return _serviceCategories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *identifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	JSServiceCategory *serviceCategory = _serviceCategories[indexPath.section];
	JSService *service = serviceCategory.services[indexPath.row];
	cell.textLabel.text = service.name;
	return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	//UIView *view = [[UIView alloc] init];
	JSServiceCategory *serviceCategory = _serviceCategories[section];
	UILabel *label = [[UILabel alloc] init];
	label.text = serviceCategory.title;
	//[view addSubview:label];
	return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 1;
}

@end

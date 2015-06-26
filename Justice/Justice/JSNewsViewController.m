//
//  JSNewsViewController.m
//  Justice
//
//  Created by zhangbin on 6/23/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSNewsViewController.h"
#import "Header.h"
#import "JSNews.h"

@interface JSNewsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (readwrite) UITableView *tableView;
@property (readwrite) NSArray *multiNews;

@end

@implementation JSNewsViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.title = @"普法宣传";
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
	[[JSAPIManager shared] newsInPage:@(0) withBlock:^(NSArray *multiAttributes, NSError *error, NSString *message) {
		[self hideHUD:YES];
		if (!error) {
			_multiNews = [JSNews multiWithAttributesArray:multiAttributes];
			[_tableView reloadData];
		}
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _multiNews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell identifier]];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[UITableViewCell identifier]];
	}
	JSNews *news = _multiNews[indexPath.row];
	cell.textLabel.text = news.title;
	NSMutableString *detailsString = [NSMutableString string];
	[detailsString appendString:[news.content substringToIndex:40]];
	[detailsString appendString:@"\n"];
	[detailsString appendString:@"2015-07-10"];//hard code
	cell.detailTextLabel.text = detailsString;
	cell.detailTextLabel.numberOfLines = 0;
	
	CGFloat const widthOfImage = 80;
	CGRect rect = cell.imageView.frame;

	rect.size.width = widthOfImage;
	rect.size.height = widthOfImage;
	cell.imageView.frame = rect;
//	NSLog(@"rect: %@", NSStringFromCGRect(rect));
	
	if (news.imagePath.length) {
		[cell.imageView setImageWithURL:[NSURL URLWithString:news.imagePath] placeholderImage:[UIImage imageNamed:@"NewsPlaceholder"]];
	}
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 100;
}

@end

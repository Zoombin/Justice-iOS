//
//  JSLawyersViewController.m
//  Justice
//
//  Created by zhangbin on 6/23/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSLawyersViewController.h"
#import "JSLawerInfo.h"
#import "Header.h"
#import "ChatViewController.h"
#import "JSSigninViewController.h"

@interface JSLawyersViewController ()

@end

@implementation JSLawyersViewController {
    NSArray *resultArray;
    UITableView *resultTableView;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.title = @"律师在线";
		UIImage *normalImage = [UIImage imageNamed:@"Lawyer"];
		UIImage *selectedImage = [UIImage imageNamed:@"LawyerHighlighted"];
		self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:normalImage selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	}
	return self;
}

- (void)getLawers {
    [[JSAPIManager shared] getLawerList:^(NSArray *multiAttributes, NSError *error, NSString *message) {
        if (!error) {
            NSLog(@"%@", multiAttributes);
            resultArray = [JSLawerInfo multiWithAttributesArray:multiAttributes];
            [resultTableView reloadData];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
    resultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) style:UITableViewStyleGrouped];
    resultTableView.dataSource = self;
    resultTableView.delegate = self;
    [_scrollView addSubview:resultTableView];
    [self getLawers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    JSLawerInfo *lawerInfo = resultArray[section];
    return lawerInfo.lawyers.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell identifier]];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UITableViewCell identifier]];
    }
    JSLawerInfo *lawerInfo = resultArray[indexPath.section];
    NSDictionary *lawer = lawerInfo.lawyers[indexPath.row];
    cell.textLabel.text = lawer[@"nickname"];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //UIView *view = [[UIView alloc] init];
    JSLawerInfo *lawerInfo = resultArray[section];
    UILabel *label = [[UILabel alloc] init];
    label.text = lawerInfo.name;
    //[view addSubview:label];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([JSAPIManager sessionValid]) {
        JSLawerInfo *info = resultArray[indexPath.section];
        NSDictionary *dict = info.lawyers[indexPath.row];
        ChatViewController *chatViewController = [[ChatViewController alloc] initWithChatter:dict[@"nickname"] isGroup:NO];
        chatViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chatViewController animated:YES];
    } else {
        JSSigninViewController *signViewController = [JSSigninViewController new];
        signViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:signViewController animated:YES];
    }
}
@end

//
//  JSSigninViewController.m
//  Justice
//
//  Created by zhangbin on 6/23/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSSigninViewController.h"
#import "Header.h"

@interface JSSigninViewController ()

@end

@implementation JSSigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	self.title = @"登录";
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backOrClose)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

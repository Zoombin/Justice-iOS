//
//  JSLawyersViewController.m
//  Justice
//
//  Created by zhangbin on 6/23/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSLawyersViewController.h"

@interface JSLawyersViewController ()

@end

@implementation JSLawyersViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
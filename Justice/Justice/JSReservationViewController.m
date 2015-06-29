//
//  JSReservationViewController.m
//  Justice
//
//  Created by zhangbin on 6/29/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSReservationViewController.h"

@implementation JSReservationViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	if (_myReservation) {
		self.title = @"预约信息";

		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(reserve)];
	} else {
		self.title = @"我的预约";
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"预约" style:UIBarButtonItemStylePlain target:self action:@selector(reserve)];
	}

}

@end

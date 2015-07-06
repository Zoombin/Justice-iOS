//
//  JSSignupViewController.m
//  Justice
//
//  Created by zhangbin on 6/23/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSSignupViewController.h"
#import "Header.h"

@interface JSSignupViewController ()

@end

@implementation JSSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	self.title = @"注册";
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backOrClose)];
}

- (void)signUp {
    [[JSAPIManager shared] signUp:@"ycabc1989" andPassword:@"159874" withBlock:^(NSDictionary *attributes, NSError *error, NSString *message) {
        NSLog(@"%@", attributes);
        if (!error) {
            [self displayHUDTitle:nil message:attributes[@"msg"]];
            if ([attributes[@"error"] boolValue]) {
                NSLog(@"%@", attributes[@"data"]);
            }
        } else {
            [self displayHUDTitle:nil message:@"网络异常"];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

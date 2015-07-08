//
//  JSOrderedViewController.m
//  Justice
//
//  Created by 颜超 on 15/7/6.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import "JSOrderedViewController.h"
#import "JSAPIManager.h"
#import "UIViewController+HUD.h"

@interface JSOrderedViewController ()

@end

@implementation JSOrderedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的预约";
    [self getMyOrder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getMyOrder {
    [self displayHUD:@"加载中..."];
    [[JSAPIManager shared] getMyReservation:[JSAPIManager userID] withBlock:^(NSDictionary *attributes, NSError *error, NSString *message) {
        [self hideHUD:YES];
        if (!error) {
            NSLog(@"%@", attributes);
            _myOrderLabel.text = [NSString stringWithFormat:@"姓名:%@\n身份证:%@\n预约时间:%@\n手机号码:%@\n", attributes[@"name"], attributes[@"identity_number"], attributes[@"phone"], attributes[@"reserve_date"]];
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

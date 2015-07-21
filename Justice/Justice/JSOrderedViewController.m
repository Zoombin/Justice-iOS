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
        if (!error) {
            if ([attributes[@"error"] boolValue] == NO) {
                if (![attributes[@"data"] isKindOfClass:[NSNull class]]) {
                    [self hideHUD:YES];
                    NSArray *arr = attributes[@"data"];
                    for (int i = 0; i < [arr count]; i++) {
                        NSDictionary *dict = arr[i];
                        _myOrderLabel.text = [NSString stringWithFormat:@"%@\n姓名:%@\n身份证:%@\n预约时间:%@\n预约类型:%@\n手机号码:%@\n", _myOrderLabel.text,dict[@"name"], dict[@"identity_number"], dict[@"reserve_date"], dict[@"type"],dict[@"phone"]];
                    }
                    
                } else {
                    [self displayHUDTitle:nil message:attributes[@"msg"]];
                }
            } else {
                [self displayHUDTitle:nil message:attributes[@"msg"]];
            }
        } else {
            [self displayHUDTitle:nil message:NETWORK_ERROR];
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

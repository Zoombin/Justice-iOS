//
//  JSFeedBackViewController.m
//  Justice
//
//  Created by yc on 15-7-9.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import "JSFeedBackViewController.h"

@interface JSFeedBackViewController ()

@end

@implementation JSFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"意见反馈";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)submitButtonClicked:(id)sender {
    if ([_contentView.text length] == 0) {
        [self displayHUDTitle:nil message:@"请输入内容!"];
        return;
    }
    if ([_contentView.text length] > 200) {
        [self displayHUDTitle:nil message:@"字数不能超过200字!"];
        return;
    }
    if ([JSAPIManager sessionValid]) {
        [self displayHUD:@"提交中..."];
        [[JSAPIManager shared] advice:_contentView.text userID:[JSAPIManager userID] withBlock:^(NSDictionary *attributes, NSError *error, NSString *message) {
            if (!error) {
                if ([attributes[@"error"] boolValue] == NO) {
                    [self displayHUDTitle:nil message:@"提交成功"];
                    [self performSelector:@selector(back) withObject:nil afterDelay:DELAY_TIMES];
                } else {
                    [self displayHUDTitle:nil message:attributes[@"msg"]];
                }
            } else {
                [self displayHUDTitle:nil message:NETWORK_ERROR];
            }
        }];
    }
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
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

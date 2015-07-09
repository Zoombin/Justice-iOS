//
//  JSUserInfoViewController.m
//  Justice
//
//  Created by yc on 15-7-9.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import "JSUserInfoViewController.h"
#import "JSFeedBackViewController.h"
#import "JSUserInfo.h"

@interface JSUserInfoViewController ()

@end

@implementation JSUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人中心";
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"意见反馈" style:UIBarButtonItemStyleBordered target:self action:@selector(feedBack)];
    [self getUserInfo];
}

- (void)feedBack {
    JSFeedBackViewController *feedBackViewController = [JSFeedBackViewController new];
    [self.navigationController pushViewController:feedBackViewController animated:YES];
}

- (void)getUserInfo {
    if (![JSAPIManager sessionValid]) {
        return;
    }
    [self displayHUD:@"加载中..."];
    [[JSAPIManager shared] getUserInfo:[JSAPIManager userID] withBlock:^(NSDictionary *attributes, NSError *error, NSString *message) {
        [self hideHUD:YES];
        if (!error) {
            JSUserInfo *userInfo = [[JSUserInfo alloc] initWithAttributes:attributes[@"data"]];
            NSLog(@"%@", userInfo.score);
            _userNameLabel.text = [NSString stringWithFormat:@"登录账号:%@", userInfo.account];
        }
    }];
}

- (IBAction)logoutButtonClicked:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"是否登出?"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.cancelButtonIndex  != buttonIndex) {
        [self logout];
    }
}

- (void)logout {
    [self displayHUD:@"注销中..."];
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
        if (!error) {
            [JSAPIManager removeUserID];
            [self displayHUDTitle:nil message:@"登出成功"];
            [self performSelector:@selector(back) withObject:nil afterDelay:2.0];
        } else {
            [self displayHUDTitle:nil message:error.description];
        }
    } onQueue:nil];;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//
//  JSSigninViewController.m
//  Justice
//
//  Created by zhangbin on 6/23/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSSigninViewController.h"
#import "UIViewController+HUD.h"
#import "EaseMob.h"
#import "JSUserInfo.h"
#import "Header.h"

@interface JSSigninViewController ()

@end

@implementation JSSigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	self.title = @"登录";
}

- (BOOL)checkEmpty {
    if ([_accountTextField.text isEqualToString:@""] || [_accountTextField.text length] == 0) {
        return YES;
    }
    if ([_passwordTextField.text isEqualToString:@""] || [_passwordTextField.text length] == 0) {
        return YES;
    }
    return NO;
}

- (IBAction)signInButtonClicked:(id)sender {
    if ([self checkEmpty]) {
        [self displayHUDTitle:nil message:@"用户名或密码不能为空！"];
        return;
    }
    [self displayHUD:@"登录中..."];
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:_accountTextField.text password:_passwordTextField.text completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error && loginInfo) {
            [self hideHUD:YES];
            NSLog(@"登录成功");
            [JSAPIManager saveUserID:_accountTextField.text];
            [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
            [self.navigationController popViewControllerAnimated:NO];
//            [self signIn];
        } else {
            [self displayHUDTitle:nil message:error.description];
        }
    } onQueue:nil];
}

- (IBAction)signUpButtonClicked:(id)sender {
    if ([self checkEmpty]) {
        [self displayHUDTitle:nil message:@"用户名或密码不能为空！"];
        return;
    }
    [self displayHUD:@"注册中..."];
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:_accountTextField.text password:_passwordTextField.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
        if (!error) {
            [self hideHUD:YES];
            NSLog(@"注册成功");
            [JSAPIManager saveUserID:_accountTextField.text];
            [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
            [self.navigationController popViewControllerAnimated:NO];
//            [self signUp];
        } else {
            [self displayHUDTitle:nil message:error.description];
        }
    } onQueue:nil];
}

- (void)signIn {
    [[JSAPIManager shared] signIn:_accountTextField.text andPassword:_passwordTextField.text withBlock:^(NSDictionary *attributes, NSError *error, NSString *message) {
        if (!error) {
            [self displayHUDTitle:nil message:attributes[@"msg"]];
            if (![attributes[@"error"] boolValue]) {
                NSLog(@"%@", attributes[@"data"]);
                JSUserInfo *userInfo = [[JSUserInfo alloc] initWithAttributes:attributes[@"data"]];
                [JSAPIManager saveUserID:userInfo.ID];
                [self.navigationController popViewControllerAnimated:NO];
            }
        } else {
            [self displayHUDTitle:nil message:@"网络异常"];
        }
    }];
}

- (void)signUp {
    [[JSAPIManager shared] signUp:_accountTextField.text andPassword:_passwordTextField.text withBlock:^(NSDictionary *attributes, NSError *error, NSString *message) {
        NSLog(@"%@", attributes);
        if (!error) {
            [self displayHUDTitle:nil message:attributes[@"msg"]];
            if (![attributes[@"error"] boolValue]) {
                NSLog(@"%@", attributes[@"data"]);
                JSUserInfo *userInfo = [[JSUserInfo alloc] initWithAttributes:attributes[@"data"]];
                [JSAPIManager saveUserID:userInfo.ID];
                [self.navigationController popViewControllerAnimated:NO];
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

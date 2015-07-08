//
//  JSOrderViewController.m
//  Justice
//
//  Created by 颜超 on 15/7/6.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import "JSOrderViewController.h"
#import "UIViewController+HUD.h"
#import "JSAPIManager.h"

@interface JSOrderViewController ()

@end

@implementation JSOrderViewController {
    NSMutableArray *reserveTimes;
    NSString *reserveTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要预约";
    // Do any additional setup after loading the view from its nib.
    reserveTimes = [[NSMutableArray alloc] init];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleBordered target:self action:@selector(submit)];
    
    [_selectTimeBtn addTarget:self action:@selector(showSelectTimeActionSheet) forControlEvents:UIControlEventTouchUpInside];
    
    [self getReserveTime];
}

- (void)showSelectTimeActionSheet {
    if ([reserveTimes count] == 0) {
        [self displayHUDTitle:nil message:@"尚未获取到预约时间!"];
        return;
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    actionSheet.title = @"选择预约时间";
    for (int i = 0; i < [reserveTimes count]; i++) {
        NSString *time = reserveTimes[i];
        [actionSheet addButtonWithTitle:time];
    }
    [actionSheet addButtonWithTitle:@"取消"];
    [actionSheet setCancelButtonIndex:[reserveTimes count]];
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.cancelButtonIndex == buttonIndex) {
        return;
    }
    reserveTime = reserveTimes[buttonIndex];
    [_selectTimeBtn setTitle:reserveTime forState:UIControlStateNormal];
}

- (void)submit {
    if ([_nameTextField.text isEqualToString:@""]) {
        [self displayHUDTitle:nil message:@"姓名不能为空!"];
        return;
    }
    if ([_phoneTextField.text isEqualToString:@""]) {
        [self displayHUDTitle:nil message:@"手机号不能为空!"];
        return;
    }
    if ([_idTextField.text isEqualToString:@""]) {
        [self displayHUDTitle:nil message:@"身份证不能为空!"];
        return;
    }
    if (reserveTime == nil) {
        [self displayHUDTitle:nil message:@"预约时间不能为空!"];
        return;
    }
    [[JSAPIManager shared] addServe:[JSAPIManager userID] phone:_phoneTextField.text idCard:_idTextField.text name:_nameTextField.text time:reserveTime withBlock:^(NSDictionary *attributes, NSError *error, NSString *message) {
        if (!error) {
            NSLog(@"%@", attributes);
            [self displayHUDTitle:nil message:attributes[@"msg"]];
            if ([attributes[@"error"] boolValue] == NO) {
                [self performSelector:@selector(back) withObject:nil afterDelay:2.0];
            }
        }
    }];
}

- (void)back {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)getReserveTime {
    [[JSAPIManager shared] getReserveTime:^(NSArray *multiAttributes, NSError *error, NSString *message) {
        if (!error) {
            NSLog(@"%@", multiAttributes);
            if ([multiAttributes count] > 0) {
                [reserveTimes addObjectsFromArray:multiAttributes];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

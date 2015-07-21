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

#define TIME_ACTIONSHEET_TAG 1001
#define TYPE_ACTIONSHEET_TAG 1002

@interface JSOrderViewController ()

@end

@implementation JSOrderViewController {
    NSMutableArray *reserveTimes;
    NSArray *types;
    NSString *reserveTime;
    NSString *reserveType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要预约";
    types = @[@"委托公证", @"遗嘱公证", @"继承公证", @"赠与合同", @"保证证据公证", @"现场监督公证", @"房屋买卖合同/组贷合同公证", @"抵押合同/质押合同", @"提存", @"涉外"];
    // Do any additional setup after loading the view from its nib.
    reserveTimes = [[NSMutableArray alloc] init];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleBordered target:self action:@selector(submit)];
    
    [_selectTimeBtn addTarget:self action:@selector(showSelectTimeActionSheet) forControlEvents:UIControlEventTouchUpInside];
    [_selectOrderType addTarget:self action:@selector(showOrderTypeActionSheet) forControlEvents:UIControlEventTouchUpInside];
    
    [self getReserveTime];
}

- (void)showOrderTypeActionSheet {
    if ([reserveTimes count] == 0) {
        [self displayHUDTitle:nil message:@"尚未获取到预约时间!"];
        return;
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    actionSheet.title = @"选择预约时间";
    for (int i = 0; i < [types count]; i++) {
        NSString *type = types[i];
        [actionSheet addButtonWithTitle:type];
    }
    [actionSheet addButtonWithTitle:@"取消"];
    [actionSheet setCancelButtonIndex:[types count]];
    actionSheet.tag = TYPE_ACTIONSHEET_TAG;
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
}

- (void)showSelectTimeActionSheet {
    if ([reserveTimes count] == 0) {
        [self displayHUDTitle:nil message:@"尚未获取到预约时间!"];
        return;
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    actionSheet.title = @"选择预约时间";
    for (int i = 0; i < [reserveTimes count]; i++) {
        NSDictionary *time = reserveTimes[i];
        [actionSheet addButtonWithTitle:[NSString stringWithFormat:@"%@ 剩%@名", time[@"date"], time[@"left"]]];
    }
    [actionSheet addButtonWithTitle:@"取消"];
    [actionSheet setCancelButtonIndex:[reserveTimes count]];
    actionSheet.tag = TIME_ACTIONSHEET_TAG;
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.cancelButtonIndex == buttonIndex) {
        return;
    }
    if (actionSheet.tag == TIME_ACTIONSHEET_TAG) {
        NSDictionary *timeInfo = reserveTimes[buttonIndex];
        if ([timeInfo[@"left"] integerValue] == 0) {
            [self displayHUDTitle:nil message:@"该时段已预约满了!"];
            return;
        }
        reserveTime = timeInfo[@"date"];
        [_selectTimeBtn setTitle:reserveTime forState:UIControlStateNormal];
    } else {
        reserveType = types[buttonIndex];
        [_selectOrderType setTitle:reserveType forState:UIControlStateNormal];
    }
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
    if (reserveType == nil) {
        [self displayHUDTitle:nil message:@"预约类型不能为空!"];
        return;
    }
    if (![self isMobileNumber:_phoneTextField.text]) {
        [self displayHUDTitle:nil message:@"请输入正确的手机号!"];
        return;
    }
    if (![self checkIdCard:_idTextField.text]) {
        [self displayHUDTitle:nil message:@"请输入正确的身份证!"];
        return;
    }
    [self displayHUD:@"预约中..."];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [[JSAPIManager shared] addServe:[JSAPIManager userID]
                              phone:_phoneTextField.text
                             idCard:_idTextField.text
                               name:_nameTextField.text
                               time:reserveTime
                               type:reserveType
                          withBlock:^(NSDictionary *attributes, NSError *error, NSString *message) {
        if (!error) {
            NSLog(@"%@", attributes);
            [self displayHUDTitle:nil message:attributes[@"msg"]];
            if ([attributes[@"error"] boolValue] == NO) {
                [self performSelector:@selector(back) withObject:nil afterDelay:DELAY_TIMES];
            } else {
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }
        } else {
            self.navigationItem.rightBarButtonItem.enabled = YES;
            [self displayHUDTitle:nil message:NETWORK_ERROR];
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

- (BOOL)checkIdCard:(NSString *)card {
    NSString *regex = @"\\d{15}(\\d\\d[0-9xX])";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![pred evaluateWithObject:card]) {
        return NO;
    }
    return YES;
}

- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end

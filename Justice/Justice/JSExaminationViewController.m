//
//  JSExaminationViewController.m
//  Justice
//
//  Created by zhangbin on 6/23/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSExaminationViewController.h"
#import "JSSigninViewController.h"
#import "UIViewController+HUD.h"
#import "JSAPIManager.h"
#import "JSExamDetailViewController.h"
#import "JSUserInfo.h"

@interface JSExaminationViewController ()

@end

@implementation JSExaminationViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.title = @"在线考试";
		UIImage *normalImage = [UIImage imageNamed:@"Examination"];
		UIImage *selectedImage = [UIImage imageNamed:@"ExaminationHighlighted"];
		self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:normalImage selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect rect = CGRectZero;
    rect.size.width = 180;
    rect.size.height = 44;
    rect.origin.x = (self.view.bounds.size.width - rect.size.width) / 2;
    rect.origin.y = 100;
    
    UIButton *onlineExamButton = [UIButton buttonWithType:UIButtonTypeCustom];
    onlineExamButton.frame = rect;
    [onlineExamButton setBackgroundColor:[UIColor colorWithRed:23/255.0f green:125/255.0f blue:251/255.0f alpha:1.0f]];
    onlineExamButton.layer.cornerRadius = 10;
    [onlineExamButton setTitle:@"在线考试" forState:UIControlStateNormal];
    [onlineExamButton addTarget:self action:@selector(onlineButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:onlineExamButton];
    
    rect.origin.y = CGRectGetMaxY(onlineExamButton.frame) + 30;
    UIButton *scoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scoreButton.frame = rect;
    [scoreButton setBackgroundColor:[UIColor colorWithRed:223/255.0f green:135/255.0f blue:34/255.0f alpha:1.0f]];
    scoreButton.layer.cornerRadius = onlineExamButton.layer.cornerRadius;
    [scoreButton setTitle:@"积分兑换" forState:UIControlStateNormal];
    [scoreButton addTarget:self action:@selector(scoreButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scoreButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getUserInfo];
}

- (void)getUserInfo {
    if (![JSAPIManager sessionValid]) {
        return;
    }
    [self displayHUD:@"加载中..."];
    [[JSAPIManager shared] getUserInfo:[JSAPIManager userID] withBlock:^(NSDictionary *attributes, NSError *error, NSString *message) {
        [self hideHUD:YES];
        if (!error) {
            if ([attributes[@"data"] isKindOfClass:[NSDictionary class]]) {
                JSUserInfo *userInfo = [[JSUserInfo alloc] initWithAttributes:attributes[@"data"]];
                NSLog(@"%@", userInfo.score);
                self.navigationItem.title = [NSString stringWithFormat:@"我的积分:%@", userInfo.score];
            }
        }
    }];
}

- (void)onlineButtonClick {
    if (![JSAPIManager sessionValid]) {
        JSSigninViewController *signinViewController = [JSSigninViewController new];
        signinViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:signinViewController animated:YES];
    } else {
        JSExamDetailViewController *examDetailViewController = [JSExamDetailViewController new];
        examDetailViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:examDetailViewController animated:YES];
    }
}

- (void)scoreButtonClick {
//    if (![JSAPIManager sessionValid]) {
//        JSSigninViewController *signinViewController = [JSSigninViewController new];
//        signinViewController.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:signinViewController animated:YES];
//    }
    [self displayHUDTitle:nil message:@"积分兑换功能还未上线，敬请期待..."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

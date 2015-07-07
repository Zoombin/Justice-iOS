//
//  JSExamDetailViewController.m
//  Justice
//
//  Created by 颜超 on 15/7/8.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import "JSExamDetailViewController.h"
#import "JSAPIManager.h"
#import "JSQuestion.h"
#import "UIViewController+HUD.h"
#import "JSQuestionView.h"

@interface JSExamDetailViewController ()

@end

@implementation JSExamDetailViewController {
    NSArray *questions;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getQuestions];
    _scrollView.pagingEnabled = YES;
}

- (void)getQuestions {
    [self displayHUD:@"加载中..."];
    [[JSAPIManager shared] getQuestions:^(NSArray *multiAttributes, NSError *error, NSString *message) {
        [self hideHUD:YES];
        if (!error) {
            NSLog(@"%@", multiAttributes);
            questions = [JSQuestion multiWithAttributesArray:multiAttributes];
            [self showQustionView];
        }
    }];
}

- (void)showQustionView {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    _scrollView.contentSize = CGSizeMake(screenWidth * [questions count], 0);
    for (int i = 0; i < [questions count]; i++) {
        JSQuestion *question = questions[i];
        JSQuestionView *questionView = [[JSQuestionView alloc] initWithFrame:CGRectMake(screenWidth * i, 0, screenWidth, _scrollView.frame.size.height)];
        [questionView showQuestion:question index:i];
        [_scrollView addSubview:questionView];
    }
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

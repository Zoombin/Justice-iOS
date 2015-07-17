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

@interface JSExamDetailViewController ()

@end

@implementation JSExamDetailViewController {
    NSArray *questions;
    NSInteger score;
    NSMutableArray *correctArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleBordered target:self action:@selector(submit)];
    
    correctArray = [[NSMutableArray alloc] init];
    [self getQuestions];
    _scrollView.pagingEnabled = YES;
}

- (void)submit {
    if ([questions count] == 0) {
        [self displayHUDTitle:nil message:@"尚未获取到试卷信息"];
        return;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"是否交卷?"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.cancelButtonIndex != buttonIndex) {
        [self displayHUD:@"提交中..."];
        JSQuestion *question = questions[0];
        [[JSAPIManager shared] addScore:[JSAPIManager userID] score:score eid:question.eid withBlock:^(NSDictionary *attributes, NSError *error, NSString *message) {
            if (!error) {
                [self displayHUDTitle:nil message:attributes[@"msg"]];
                NSLog(@"%@", attributes);
                if ([attributes[@"error"] boolValue] == NO) {
                    NSLog(@"提交成功");
                    [self performSelector:@selector(back) withObject:nil afterDelay:DELAY_TIMES];
                }
            }
        }];
    }
}

- (void)back {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
        questionView.delegate = self;
        [questionView showQuestion:question index:i];
        [_scrollView addSubview:questionView];
    }
}

- (void)answerIsCorrect:(BOOL)isCorrect index:(NSInteger)index {
    if (isCorrect) {
        if (![correctArray containsObject:@(index)]) {
            [correctArray addObject:@(index)];
        }
    } else {
        if ([correctArray containsObject:@(index)]) {
            [correctArray removeObject:@(index)];
        }
    }
    NSLog(@"count => %ld", [correctArray count]);
    score = 10 * [correctArray count];
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

//
//  JSJusticeNoticeViewController.m
//  Justice
//
//  Created by 颜超 on 15/7/3.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import "JSJusticeNoticeViewController.h"
#import "UIViewController+HUD.h"

@interface JSJusticeNoticeViewController ()

@end

@implementation JSJusticeNoticeViewController {
    UIWebView *stepView1;
    UIWebView *stepView2;
    UIWebView *stepView3;
    UIWebView *stepView4;
    UIWebView *stepView5;
    UIWebView *stepView6;
    UIWebView *stepView7;
    UIWebView *stepView8;
    UIWebView *stepView9;
    UIWebView *stepView10;
    UIWebView *stepView11;
    
    NoticeView *view1;
    NoticeView *view2;
    NoticeView *view3;
    NoticeView *view4;
    NoticeView *view5;
    NoticeView *view6;
    NoticeView *view7;
    NoticeView *view8;
    NoticeView *view9;
    NoticeView *view10;
    NoticeView *view11;
    int count;
    
    NSArray *noticeViews;
    NSArray *webViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"公证须知";
    count = 0;
    [self displayHUD:@"加载中..."];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = 100;
    
    view1 = [[NoticeView alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    stepView1 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    view2 = [[NoticeView alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    stepView2 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    view3 = [[NoticeView alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    stepView3 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    view4 = [[NoticeView alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    stepView4 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    view5 = [[NoticeView alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    stepView5 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    view6 = [[NoticeView alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    stepView6 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    view7 = [[NoticeView alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    stepView7 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    view8 = [[NoticeView alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    stepView8 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    view9 = [[NoticeView alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    stepView9 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    view10 = [[NoticeView alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    stepView10 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    view11 = [[NoticeView alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    stepView11 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    
    NSArray *titles = @[@"委托公证", @"遗嘱公证", @"继承公证", @"赠与合同", @"保证证据公证", @"现场监督公证", @"房屋买卖合同/租贷合同公证", @"抵押合同/质押合同公证", @"提存", @"涉外(一)", @"涉外(二)"];
    
    noticeViews = @[view1,
                       view2,
                       view3,
                       view4,
                       view5,
                       view6,
                       view7,
                       view8,
                       view9,
                       view10,
                       view11
                       ];
    webViews = @[stepView1,
                          stepView2,
                          stepView3,
                          stepView4,
                          stepView5,
                          stepView6,
                          stepView7,
                          stepView8,
                          stepView9,
                          stepView10,
                          stepView11
                          ];
    for (int i = 0; i < [webViews count]; i++) {
        
        UIWebView *webView = webViews[i];
        NSString *filePath1 = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"step%d", i+1] ofType:@"html"];
        NSString *htmlString1 = [NSString stringWithContentsOfFile:filePath1 encoding:NSUTF8StringEncoding error:nil];
        
        webView.delegate = self;
        webView.hidden = YES;
        [webView loadHTMLString:htmlString1 baseURL:[NSURL URLWithString:filePath1]];
        [_scrollView addSubview:webView];
        
        
        NoticeView *view = noticeViews[i];
        view.delegate = self;
        view.hidden = YES;
        view.tag = i;
        view.titleLabel.text = [NSString stringWithFormat:@"\t%@", titles[i]];
        [_scrollView addSubview:view];
    }
    
}

- (void)noticeButtonClicked:(UIView *)view {
    UIWebView *webView = webViews[view.tag];
    webView.hidden = !webView.hidden;
    [self reSize];
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
    count++;
    CGRect frame = aWebView.frame;
    frame.size.height = 1;
    aWebView.frame = frame;
    CGSize fittingSize = [aWebView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    aWebView.frame = frame;

    if (count == 11) {
        [self hideHUD:YES];
        [self reSize];
    }
}

- (void)allShow {
    for (UIView *view in noticeViews) {
        view.hidden = NO;
    }
}

- (void)reSize {
    CGFloat contentSizeHeight = 0;
  
    view1.frame = CGRectMake(0, 0, view1.frame.size.width, view1.frame.size.height);
    contentSizeHeight+= view1.frame.size.height;
    
    if (!stepView1.hidden) {
        stepView1.frame = CGRectMake(0, contentSizeHeight, stepView1.frame.size.width, stepView1.frame.size.height);
        contentSizeHeight+= stepView1.frame.size.height;
    }
    
    view2.frame = CGRectMake(0, contentSizeHeight, view2.frame.size.width, view2.frame.size.height);
    contentSizeHeight+= view2.frame.size.height;
    
    if (!stepView2.hidden) {
        stepView2.frame = CGRectMake(0, contentSizeHeight, stepView2.frame.size.width, stepView2.frame.size.height);
        contentSizeHeight+= stepView2.frame.size.height;
    }
    
    view3.frame = CGRectMake(0, contentSizeHeight, view3.frame.size.width, view3.frame.size.height);
    contentSizeHeight+= view3.frame.size.height;
    
    if (!stepView3.hidden) {
        stepView3.frame = CGRectMake(0, contentSizeHeight, stepView3.frame.size.width, stepView3.frame.size.height);
        contentSizeHeight+= stepView3.frame.size.height;
    }
    
    
    view4.frame = CGRectMake(0, contentSizeHeight, view4.frame.size.width, view4.frame.size.height);
    contentSizeHeight+= view4.frame.size.height;
    
    if (!stepView4.hidden) {
        stepView4.frame = CGRectMake(0, contentSizeHeight, stepView4.frame.size.width, stepView4.frame.size.height);
        contentSizeHeight+= stepView4.frame.size.height;
    }
    
    
    view5.frame = CGRectMake(0, contentSizeHeight, view5.frame.size.width, view5.frame.size.height);
    contentSizeHeight+= view5.frame.size.height;
    
    if (!stepView5.hidden) {
        stepView5.frame = CGRectMake(0, contentSizeHeight, stepView5.frame.size.width, stepView5.frame.size.height);
        contentSizeHeight+= stepView5.frame.size.height;
    }
    
    view6.frame = CGRectMake(0, contentSizeHeight, view6.frame.size.width, view6.frame.size.height);
    contentSizeHeight+= view6.frame.size.height;
    
    if (!stepView6.hidden) {
        stepView6.frame = CGRectMake(0, contentSizeHeight, stepView6.frame.size.width, stepView6.frame.size.height);
        contentSizeHeight+= stepView6.frame.size.height;
    }
    
    view7.frame = CGRectMake(0, contentSizeHeight, view7.frame.size.width, view7.frame.size.height);
    contentSizeHeight+= view7.frame.size.height;
    
    if (!stepView7.hidden) {
        stepView7.frame = CGRectMake(0, CGRectGetMaxY(view7.frame), stepView7.frame.size.width, stepView7.frame.size.height);
        contentSizeHeight+= stepView7.frame.size.height;
    }
    
    view8.frame = CGRectMake(0, contentSizeHeight, view8.frame.size.width, view8.frame.size.height);
    contentSizeHeight+= view8.frame.size.height;
    
    if (!stepView8.hidden) {
        stepView8.frame = CGRectMake(0, contentSizeHeight, stepView8.frame.size.width, stepView8.frame.size.height);
        contentSizeHeight+= stepView8.frame.size.height;
    }
   
    view9.frame = CGRectMake(0, contentSizeHeight, view9.frame.size.width, view9.frame.size.height);
    contentSizeHeight+= view9.frame.size.height;
    
    if (!stepView9.hidden) {
        stepView9.frame = CGRectMake(0, contentSizeHeight, stepView9.frame.size.width, stepView9.frame.size.height);
        contentSizeHeight+= stepView9.frame.size.height;
    }
    
    
    view10.frame = CGRectMake(0, contentSizeHeight, view10.frame.size.width, view10.frame.size.height);
    contentSizeHeight+= view10.frame.size.height;
    
    if (!stepView10.hidden) {
        stepView10.frame = CGRectMake(0, contentSizeHeight, stepView10.frame.size.width, stepView10.frame.size.height);
        contentSizeHeight+= stepView10.frame.size.height;
    }
    
    view11.frame = CGRectMake(0, contentSizeHeight, view11.frame.size.width, view11.frame.size.height);
    contentSizeHeight+= view11.frame.size.height;
    
    if (!stepView11.hidden) {
        stepView11.frame = CGRectMake(0, contentSizeHeight, stepView11.frame.size.width, stepView11.frame.size.height);
        contentSizeHeight+= stepView11.frame.size.height;
    }
    
    _scrollView.contentSize = CGSizeMake(0, contentSizeHeight);
    [self allShow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

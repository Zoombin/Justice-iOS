//
//  JSJusticeNoticeViewController.h
//  Justice
//
//  Created by 颜超 on 15/7/3.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoticeView.h"

@interface JSJusticeNoticeViewController : UIViewController<UIWebViewDelegate, NoticeViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@end

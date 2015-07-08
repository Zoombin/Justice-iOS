//
//  JSExamDetailViewController.h
//  Justice
//
//  Created by 颜超 on 15/7/8.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSQuestionView.h"

@interface JSExamDetailViewController : UIViewController <JSQuestionViewDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@end

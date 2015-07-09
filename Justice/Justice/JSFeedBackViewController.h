//
//  JSFeedBackViewController.h
//  Justice
//
//  Created by yc on 15-7-9.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSFeedBackViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextView *contentView;
- (IBAction)submitButtonClicked:(id)sender;
@end

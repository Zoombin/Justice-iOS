//
//  JSUserInfoViewController.h
//  Justice
//
//  Created by yc on 15-7-9.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSUserInfoViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;

- (IBAction)logoutButtonClicked:(id)sender;

@end

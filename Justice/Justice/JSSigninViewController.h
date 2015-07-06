//
//  JSSigninViewController.h
//  Justice
//
//  Created by zhangbin on 6/23/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSSigninViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *accountTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
- (IBAction)signInButtonClicked:(id)sender;
- (IBAction)signUpButtonClicked:(id)sender;
@end

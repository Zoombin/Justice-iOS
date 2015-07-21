//
//  JSOrderViewController.h
//  Justice
//
//  Created by 颜超 on 15/7/6.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSOrderViewController : UIViewController<UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UITextField *phoneTextField;
@property (nonatomic, weak) IBOutlet UITextField *idTextField;
@property (nonatomic, weak) IBOutlet UIButton *selectTimeBtn;
@property (nonatomic, weak) IBOutlet UIButton *selectOrderType;
@end

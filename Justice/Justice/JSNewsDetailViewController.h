//
//  JSNewsDetailViewController.h
//  Justice
//
//  Created by yc on 15-7-1.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSNews.h"

@interface JSNewsDetailViewController : UIViewController

@property (nonatomic, strong) JSNews *news;
@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UITextView *contentLabel;
@end

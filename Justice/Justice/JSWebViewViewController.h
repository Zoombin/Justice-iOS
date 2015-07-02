//
//  JSWebViewViewController.h
//  Justice
//
//  Created by yc on 15-7-2.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSWebViewViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *url;
@end

//
//  AppDelegate+JS.m
//  Justice
//
//  Created by zhangbin on 6/23/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "AppDelegate+JS.h"

@implementation AppDelegate (JS)

- (void)customizeAppearance {
	//NavigationBar
	UIColor *color = [UIColor colorWithRed:25/255.0f green:148/255.0 blue:252/255.0f alpha:1.0f];
	id appearance = [UINavigationBar appearance];
	[appearance setBarTintColor:color];
	[appearance setTintColor:color];
	[appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [appearance setTintColor:[UIColor whiteColor]];
}

@end

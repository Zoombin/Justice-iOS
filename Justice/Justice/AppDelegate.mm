//
//  AppDelegate.m
//  Justice
//
//  Created by zhangbin on 6/23/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+JS.h"
#import "JSNewsViewController.h"
#import "JSExaminationViewController.h"
#import "JSLawyersViewController.h"
#import "JSJusticeViewController.h"
#import "JSServicesViewController.h"
#import "JSLawHelpViewController.h"
#import "EaseMob.h"

@interface AppDelegate ()

@end

@implementation AppDelegate {
    BMKMapManager* _mapManager;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self customizeAppearance];
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    BOOL ret = [_mapManager start:@"F9rypUZMz2ZwrcKhGUZwMMOw" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"zoombin#justice" apnsCertName:@"istore_dev"];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    
	NSMutableArray *controllers = [NSMutableArray array];
	
	JSNewsViewController *newsViewController = [[JSNewsViewController alloc] initWithNibName:nil bundle:nil];
	[controllers addObject:[[UINavigationController alloc] initWithRootViewController:newsViewController]];
	
	JSExaminationViewController *examViewController = [[JSExaminationViewController alloc] initWithNibName:nil bundle:nil];
	[controllers addObject:[[UINavigationController alloc] initWithRootViewController:examViewController]];
	
	JSLawyersViewController *chatViewController = [[JSLawyersViewController alloc] initWithNibName:nil bundle:nil];
	[controllers addObject:[[UINavigationController alloc] initWithRootViewController:chatViewController]];
	
	JSJusticeViewController *justiceViewController = [[JSJusticeViewController alloc] initWithNibName:nil bundle:nil];
	[controllers addObject:[[UINavigationController alloc] initWithRootViewController:justiceViewController]];
	
	JSServicesViewController *lawViewController = [[JSServicesViewController alloc] initWithNibName:nil bundle:nil];
	[controllers addObject:[[UINavigationController alloc] initWithRootViewController:lawViewController]];
    
    JSLawHelpViewController *lawHelpViewController = [JSLawHelpViewController new];
    [controllers addObject:[[UINavigationController alloc] initWithRootViewController:lawHelpViewController]];
	
	UITabBarController *tabBarController = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
	tabBarController.viewControllers = controllers;
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.rootViewController = tabBarController;
	[self.window makeKeyAndVisible];
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

@end

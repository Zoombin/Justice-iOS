//
//  JSJusticeViewController.m
//  Justice
//
//  Created by zhangbin on 6/23/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSJusticeViewController.h"
#import "Header.h"
#import "JSSigninViewController.h"
#import "JSReservationViewController.h"
#import "JSJusticeNoticeViewController.h"
#import "JSOrderedViewController.h"
#import "JSOrderViewController.h"

@interface JSJusticeViewController ()

@end

@implementation JSJusticeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.title = @"公证服务";
		UIImage *normalImage = [UIImage imageNamed:@"Justice"];
		UIImage *selectedImage = [UIImage imageNamed:@"JusticeHighlighted"];
		self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:normalImage selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1.0f];
	
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:scrollView];
	
	CGRect rect = CGRectZero;
	UIImage *image = [UIImage imageNamed:@"JusticeOfficial"];
	rect.origin.x = (self.view.bounds.size.width - image.size.width) / 2;
	rect.origin.y = 50;
	rect.size = image.size;
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
	imageView.image = image;
	[scrollView addSubview:imageView];
	
	rect.size.width = 180;
	rect.size.height = 44;
	rect.origin.x = (self.view.bounds.size.width - rect.size.width) / 2;
	rect.origin.y = CGRectGetMaxY(imageView.frame) + 20;
    
    UIButton *justiceNoticeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    justiceNoticeButton.frame = rect;
    [justiceNoticeButton setBackgroundColor:[UIColor colorWithRed:42/255.0f green:125/255.0f blue:23/255.0f alpha:1.0f]];
    justiceNoticeButton.layer.cornerRadius = 10;
    [justiceNoticeButton setTitle:@"公证须知" forState:UIControlStateNormal];
    [justiceNoticeButton addTarget:self action:@selector(notice) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:justiceNoticeButton];
    
    rect.origin.y = CGRectGetMaxY(justiceNoticeButton.frame) + 30;
	UIButton *reserveButton = [UIButton buttonWithType:UIButtonTypeCustom];
	reserveButton.frame = rect;
	[reserveButton setBackgroundColor:[UIColor colorWithRed:23/255.0f green:125/255.0f blue:251/255.0f alpha:1.0f]];
	reserveButton.layer.cornerRadius = 10;
	[reserveButton setTitle:@"我要预约" forState:UIControlStateNormal];
	[reserveButton addTarget:self action:@selector(reserve) forControlEvents:UIControlEventTouchUpInside];
	[scrollView addSubview:reserveButton];
	
	rect.origin.y = CGRectGetMaxY(reserveButton.frame) + 30;
	UIButton *myReservationButton = [UIButton buttonWithType:UIButtonTypeCustom];
	myReservationButton.frame = rect;
	[myReservationButton setBackgroundColor:[UIColor colorWithRed:223/255.0f green:135/255.0f blue:34/255.0f alpha:1.0f]];
	myReservationButton.layer.cornerRadius = reserveButton.layer.cornerRadius;
	[myReservationButton setTitle:@"我的预约" forState:UIControlStateNormal];
	[myReservationButton addTarget:self action:@selector(myReservation) forControlEvents:UIControlEventTouchUpInside];
	[scrollView addSubview:myReservationButton];
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(rect) + 50);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)notice {
    JSJusticeNoticeViewController *justiceNoticeViewController = [JSJusticeNoticeViewController new];
    justiceNoticeViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:justiceNoticeViewController animated:YES];
}

- (void)reserve {
	[self goReservation:NO];
}

- (void)myReservation {
	[self goReservation:YES];
}

- (void)goReservation:(BOOL)myReservation {
	if (![JSAPIManager sessionValid]) {
        JSSigninViewController *signinViewController = [JSSigninViewController new];
        signinViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:signinViewController animated:YES];
	} else {
        if (myReservation) {
            JSOrderedViewController *orderedViewController = [JSOrderedViewController new];
            [self.navigationController pushViewController:orderedViewController animated:YES];
        } else {
            JSOrderViewController *orderViewController = [JSOrderViewController new];
            [self.navigationController pushViewController:orderViewController animated:YES];
        }
    }
}

@end

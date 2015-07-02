//
//  JSServiceDetailsViewController.m
//  Justice
//
//  Created by zhangbin on 6/26/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSServiceDetailsViewController.h"
#import "JSRouteSearchViewController.h"
#import "Header.h"

@implementation JSServiceDetailsViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"地址" style:UIBarButtonItemStyleBordered target:self action:@selector(showLocation)];
    
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:scrollView];
	
	CGRect rect = CGRectMake(0, 0, self.view.bounds.size.width, 200);
	
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
	[scrollView addSubview:imageView];
	if (_service.imagePath.length) {
		[imageView setImageWithURL:[NSURL URLWithString:_service.imagePath]];
	}
	
	rect.origin.x = 20;
	rect.origin.y = CGRectGetMaxY(imageView.frame) + 10;
	rect.size.width = self.view.bounds.size.width - 2 * rect.origin.x;
	rect.size.height = 40;
	UILabel *nameLabel = [[UILabel alloc] initWithFrame:rect];
	nameLabel.font = [UIFont systemFontOfSize:16];
	[scrollView addSubview:nameLabel];
	nameLabel.text = _service.name;
	
	rect.origin.y = CGRectGetMaxY(nameLabel.frame);
	rect.size.height = 30;
	UILabel *addressLabel = [[UILabel alloc] initWithFrame:rect];
	addressLabel.font = [UIFont systemFontOfSize:13];
	[scrollView addSubview:addressLabel];
	addressLabel.text = _service.address;
	
	rect.origin.y = CGRectGetMaxY(addressLabel.frame);
	UILabel *phoneLabel = [[UILabel alloc] initWithFrame:rect];
	phoneLabel.font = addressLabel.font;
	[scrollView addSubview:phoneLabel];
	phoneLabel.text = _service.phone;
}

- (void)showLocation {
    JSRouteSearchViewController *routeSearchViewContrller = [JSRouteSearchViewController new];
    [self.navigationController pushViewController:routeSearchViewContrller animated:YES];
}

@end

//
//  JSGalleryDetailsViewController.m
//  Justice
//
//  Created by zhangbin on 6/26/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSGalleryDetailsViewController.h"
#import "Header.h"
#import "JSGalleryPhoto.h"

@implementation JSGalleryDetailsViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor blackColor];
	
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	scrollView.pagingEnabled = YES;
	[self.view addSubview:scrollView];
	
	CGRect rect = self.view.bounds;
	for (int i = 0; i < _gallery.photos.count; i++) {
		rect.origin.x = self.view.bounds.size.width * i;
		JSGalleryPhoto *photo = _gallery.photos[i];
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
		[imageView setImageWithURL:[NSURL URLWithString:photo.imagePath] placeholderImage:[UIImage new]];
		imageView.contentMode = UIViewContentModeScaleAspectFit;
		[scrollView addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * rect.size.width, CGRectGetMaxY(imageView.frame) - 30, rect.size.width, 30)];
        titleLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.text = [NSString stringWithFormat:@"\t%@", photo.content];
        titleLabel.font = [UIFont systemFontOfSize:14];
        [scrollView addSubview:titleLabel];
	}
	
	scrollView.contentSize = CGSizeMake(_gallery.photos.count * self.view.bounds.size.width, scrollView.bounds.size.height);
}

@end

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
	
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
	for (int i = 0; i < _gallery.photos.count; i++) {
		JSGalleryPhoto *photo = _gallery.photos[i];
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height - 64)];
		[imageView setImageWithURL:[NSURL URLWithString:photo.imagePath] placeholderImage:[UIImage new]];
		imageView.contentMode = UIViewContentModeScaleAspectFit;
		[_scrollView addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * width, CGRectGetMaxY(imageView.frame) - 30, width, 30)];
        titleLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.text = [NSString stringWithFormat:@"\t%@", photo.content == nil? @"23333333" : photo.content];
        titleLabel.font = [UIFont systemFontOfSize:14];
        [_scrollView addSubview:titleLabel];
	}
	_scrollView.contentSize = CGSizeMake(_gallery.photos.count * _scrollView.frame.size.width, 0);
}

@end

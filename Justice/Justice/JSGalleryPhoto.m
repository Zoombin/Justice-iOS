//
//  JSGalleryPhoto.m
//  Justice
//
//  Created by zhangbin on 6/26/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSGalleryPhoto.h"

@implementation JSGalleryPhoto

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
	self = [super initWithAttributes:attributes];
	if (self) {
		_ID = [attributes[@"id"] notNull];
		_imagePath = [attributes[@"image"] notNull];
	}
	return self;
}

@end

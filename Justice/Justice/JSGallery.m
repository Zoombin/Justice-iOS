//
//  JSGallery.m
//  Justice
//
//  Created by zhangbin on 6/26/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSGallery.h"
#import "JSGalleryPhoto.h"

@implementation JSGallery

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
	self = [super initWithAttributes:attributes];
	if (self) {
		_ID = [attributes[@"id"] notNull];
		_title = [attributes[@"title"] notNull];
		_createdDate = [attributes[@"created_date"] notNull];
		if ([attributes[@"photos"] notNull]) {
			_photos = [JSGalleryPhoto multiWithAttributesArray:attributes[@"photos"]];
		}
	}
	return self;
}

@end

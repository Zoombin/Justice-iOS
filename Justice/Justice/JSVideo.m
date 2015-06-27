//
//  JSVideo.m
//  Justice
//
//  Created by zhangbin on 6/27/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSVideo.h"

@implementation JSVideo

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
	self = [super initWithAttributes:attributes];
	if (self) {
		_ID = [attributes[@"id"] notNull];
		_title = [attributes[@"title"] notNull];
		_content = [attributes[@"content"] notNull];
		_imagePath = [attributes[@"image"] notNull];
		_streamPath = [attributes[@"stream"] notNull];
		_createdDate = [attributes[@"created_date"] notNull];
	}
	return self;
}

@end

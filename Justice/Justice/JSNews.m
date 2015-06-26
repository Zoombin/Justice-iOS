//
//  JSNews.m
//  Justice
//
//  Created by zhangbin on 6/26/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSNews.h"

@implementation JSNews

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
	self = [super initWithAttributes:attributes];
	if (self) {
		_ID = [attributes[@"id"] notNull];
		_title = [attributes[@"title"] notNull];
		_imagePath = [attributes[@"image"] notNull];
		_content = [attributes[@"content"] notNull];
		_createdDate = [attributes[@"created_date"] notNull];
	}
	return self;
}

@end

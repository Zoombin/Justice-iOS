//
//  JSService.m
//  Justice
//
//  Created by zhangbin on 6/26/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSService.h"

@implementation JSService

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
	self = [super initWithAttributes:attributes];
	if (self) {
		_ID = [attributes[@"id"] notNull];
		_name = [attributes[@"name"] notNull];
		_imagePath = [attributes[@"image"] notNull];
		_address = [attributes[@"address"] notNull];
		_phone = attributes[@"phone"];
		_categoryID = [attributes[@"category_id"] notNull];
	}
	return self;
}

@end

//
//  JSServiceCategory.m
//  Justice
//
//  Created by zhangbin on 6/26/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSServiceCategory.h"

@implementation JSServiceCategory

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
	self = [super initWithAttributes:attributes];
	if (self) {
		_ID = [attributes[@"id"] notNull];
		_title = [attributes[@"title"] notNull];
		_sortOrder = [attributes[@"sort_order"] notNull];
		if ([attributes[@"services"] notNull]) {
			_services = [JSService multiWithAttributesArray:attributes[@"services"]];
		}
	}
	return self;
}

@end

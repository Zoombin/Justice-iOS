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
		_phone = [attributes[@"phone"] notNull];
		//@property (nonatomic, strong) CLLocation *location;
        _latitude = [attributes[@"latitude"] notNull];
        _longtitude = [attributes[@"longitude"] notNull];
		_createdDate = [attributes[@"created_date"] notNull];
	}
	return self;
}

@end

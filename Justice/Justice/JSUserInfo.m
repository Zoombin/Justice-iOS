//
//  JSUserInfo.m
//  Justice
//
//  Created by yc on 15-7-8.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import "JSUserInfo.h"

@implementation JSUserInfo

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super initWithAttributes:attributes];
    if (self) {
        _ID = [attributes[@"id"] notNull];
        _account = [attributes[@"account"] notNull];
        _is_lawyer = [attributes[@"is_lawyer"] notNull];
        _score = [attributes[@"score"] notNull];
    }
    return self;
}
@end

//
//  JSLawerInfo.m
//  Justice
//
//  Created by 颜超 on 15/7/9.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import "JSLawerInfo.h"

@implementation JSLawerInfo

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super initWithAttributes:attributes];
    if (self) {
        _ID = [attributes[@"id"] notNull];
        _lawyers = [attributes[@"lawyers"] notNull];
        _name = [attributes[@"name"] notNull];
        _sortOrder = [attributes[@"sort_order"] notNull];
    }
    return self;
}
@end

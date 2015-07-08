//
//  JSQuestion.m
//  Justice
//
//  Created by 颜超 on 15/7/8.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import "JSQuestion.h"

@implementation JSQuestion

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super initWithAttributes:attributes];
    if (self) {
        _ID = [attributes[@"id"] notNull];
        _eid = [attributes[@"examination_id"] notNull];
        _a = [attributes[@"a"] notNull];
        _b = [attributes[@"b"] notNull];
        _c = [attributes[@"c"] notNull];
        _d = [attributes[@"d"] notNull];
        _e = [attributes[@"e"] notNull];
        _f = [attributes[@"f"] notNull];
        _question = [attributes[@"question"] notNull];
        _type = [attributes[@"type"] notNull];
        _yesOrNo = [attributes[@"yes_or_no"] notNull];
        _answer = [attributes[@"answer"] notNull];
    }
    return self;
}
@end

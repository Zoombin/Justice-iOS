//
//  JSQuestion.h
//  Justice
//
//  Created by 颜超 on 15/7/8.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import "ZBModel.h"

@interface JSQuestion : ZBModel

@property (nonatomic, strong) NSString *a;
@property (nonatomic, strong) NSString *b;
@property (nonatomic, strong) NSString *c;
@property (nonatomic, strong) NSString *d;
@property (nonatomic, strong) NSString *e;
@property (nonatomic, strong) NSString *f;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *eid;
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSNumber *yesOrNo;
@property (nonatomic, strong) NSString *answer;
@end

//
//  JSLawerInfo.h
//  Justice
//
//  Created by 颜超 on 15/7/9.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import "ZBModel.h"

@interface JSLawerInfo : ZBModel

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSArray *lawyers;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *sortOrder;
@end

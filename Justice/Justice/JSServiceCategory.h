//
//  JSServiceCategory.h
//  Justice
//
//  Created by zhangbin on 6/26/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "ZBModel.h"
#import "JSService.h"

@interface JSServiceCategory : ZBModel

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *sortOrder;
@property (nonatomic, strong) NSArray *services;

@end

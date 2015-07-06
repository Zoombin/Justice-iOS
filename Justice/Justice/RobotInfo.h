//
//  RobotInfo.h
//  PocketTools
//
//  Created by yc on 15-3-3.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface RobotInfo : ZBModel

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, assign) BOOL isLeft;
@end

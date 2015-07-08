//
//  JSUserInfo.h
//  Justice
//
//  Created by yc on 15-7-8.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import "ZBModel.h"

@interface JSUserInfo : ZBModel

@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *is_lawyer;
@property (nonatomic, strong) NSString *score;
@end

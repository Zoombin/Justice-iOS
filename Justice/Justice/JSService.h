//
//  JSService.h
//  Justice
//
//  Created by zhangbin on 6/26/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "ZBModel.h"
#import <CoreLocation/CoreLocation.h>

@interface JSService : ZBModel

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *phone;
//@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longtitude;
@property (nonatomic, strong) NSDate *createdDate;

@end

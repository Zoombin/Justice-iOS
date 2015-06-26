//
//  JSAPIManager.h
//  Justice
//
//  Created by zhangbin on 6/26/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface JSAPIManager : AFHTTPRequestOperationManager

+ (instancetype)shared;
- (void)servicesInCategories:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block;

@end

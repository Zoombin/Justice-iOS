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
+ (BOOL)sessionValid;
+ (NSNumber *)userID;
- (void)getUserInfo:(NSNumber *)userId withBlock:(void (^)(NSDictionary *attributes, NSError *error, NSString *message))block;
- (void)signIn:(NSString *)userName andPassword:(NSString *)password withBlock:(void (^)(NSDictionary *attributes, NSError *error, NSString *message))block;
- (void)signUp:(NSString *)userName andPassword:(NSString *)password withBlock:(void (^)(NSDictionary *attributes, NSError *error, NSString *message))block;

- (void)servicesInCategories:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block;
- (void)newsInPage:(NSNumber *)page withBlock:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block;
- (void)galleriesInPage:(NSNumber *)page withBlock:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block;
- (void)videosInPage:(NSNumber *)page withBlock:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block;
- (void)getBanner:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block;


@end

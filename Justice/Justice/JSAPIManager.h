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

//获取个人信息
- (void)getUserInfo:(NSNumber *)userId withBlock:(void (^)(NSDictionary *attributes, NSError *error, NSString *message))block;

//登录
- (void)signIn:(NSString *)userName andPassword:(NSString *)password withBlock:(void (^)(NSDictionary *attributes, NSError *error, NSString *message))block;

//注册
- (void)signUp:(NSString *)userName andPassword:(NSString *)password withBlock:(void (^)(NSDictionary *attributes, NSError *error, NSString *message))block;

//服务类别
- (void)servicesInCategories:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block;

//新闻列表
- (void)newsInPage:(NSNumber *)page withBlock:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block;

//图片列表
- (void)galleriesInPage:(NSNumber *)page withBlock:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block;

//视频列表
- (void)videosInPage:(NSNumber *)page withBlock:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block;

//获取banner新闻
- (void)getBanner:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block;

//获取律师列表
- (void)getLawerList:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block;

//获取预约时间
- (void)getReserveTime:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block;

//新建预约
- (void)addServe:(NSString *)userId
           phone:(NSString *)phone
          idCard:(NSString *)idCard
            name:(NSString *)name
            time:(NSString *)time
       withBlock:(void (^)(NSDictionary *attributes, NSError *error, NSString *message))block;

@end

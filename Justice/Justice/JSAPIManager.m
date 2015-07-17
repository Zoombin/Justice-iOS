//
//  JSAPIManager.m
//  Justice
//
//  Created by zhangbin on 6/26/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSAPIManager.h"


//NSString * const JS_HOST = @"http://127.0.0.1/dushuhu-web/";
NSString * const JS_HOST = @"http://www.ufocapital.com:8000/";
//NSString * const JS_HOST = @"http://112.124.98.9/dushuhu-web/";
NSString * const JS_API_PREFIX = @"index.php?";
NSString * const JS_ACTION = @"action";
NSString * const JS_DATA = @"data";
NSString * const JS_USER_ID_KEY = @"JS_USER_ID_KEY";

@implementation JSAPIManager

+ (instancetype)shared {
	static JSAPIManager *_shared = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSURL *url = [NSURL URLWithString:JS_HOST];
		_shared = [[JSAPIManager alloc] initWithBaseURL:url];
		NSMutableSet *set = [_shared.responseSerializer.acceptableContentTypes mutableCopy];
		[set addObject:@"text/html"];
		_shared.responseSerializer.acceptableContentTypes = set;
		_shared.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
	});
	return _shared;
}

+ (BOOL)sessionValid {
	return [self userID] && [[EaseMob sharedInstance].chatManager isLoggedIn] ? YES : NO;
}

+ (NSString *)userID {
	NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:JS_USER_ID_KEY];
	return userID;
}

+ (void)saveUserID:(NSString *)userID {
	if (userID) {
		[[NSUserDefaults standardUserDefaults] setObject:userID forKey:JS_USER_ID_KEY];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}

+ (void)removeUserID {
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:JS_USER_ID_KEY];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)pathWithActionName:(NSString *)actionName {
	NSMutableString *path = [NSMutableString stringWithFormat:@"%@%@=%@", JS_API_PREFIX, JS_ACTION, actionName];
	return path;
}

- (void)getUserInfo:(NSString *)userId withBlock:(void (^)(NSDictionary *attributes, NSError *error, NSString *message))block {
    [self GET:[self pathWithActionName:@"getUserInfo"] parameters:@{@"account" : userId} success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *attributes = [responseObject valueForKeyPath:JS_DATA];
        if (block) block(responseObject, nil, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) block(nil, error, nil);
    }];
}

- (void)signIn:(NSString *)userName andPassword:(NSString *)password withBlock:(void (^)(NSDictionary *attributes, NSError *error, NSString *message))block {
    [self GET:[self pathWithActionName:@"signin"] parameters:@{@"account" : userName, @"password" : password} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) block(responseObject, nil, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) block(nil, error, nil);
    }];
}

- (void)signUp:(NSString *)userName andPassword:(NSString *)password withBlock:(void (^)(NSDictionary *attributes, NSError *error, NSString *message))block {
    [self GET:[self pathWithActionName:@"signup"] parameters:@{@"account" : userName, @"password" : password} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) block(responseObject, nil, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) block(nil, error, nil);
    }];
}

- (void)servicesInCategories:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block {
	[self GET:[self pathWithActionName:@"getServices"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSArray *multiAttributes = [responseObject valueForKeyPath:JS_DATA];
		if (block) block([NSArray arrayWithArray:multiAttributes], nil, nil);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (block) block(nil, error, nil);
	}];
}

- (void)newsInPage:(NSNumber *)page withBlock:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block {
	[self GET:[self pathWithActionName:@"getNews"] parameters:@{@"page" : page} success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSArray *multiAttributes = [responseObject valueForKeyPath:JS_DATA];
		if (block) block([NSArray arrayWithArray:multiAttributes], nil, nil);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (block) block(nil, error, nil);
	}];
}

- (void)galleriesInPage:(NSNumber *)page withBlock:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block {
	[self GET:[self pathWithActionName:@"getGalleries"] parameters:@{@"page" : page} success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSArray *multiAttributes = [responseObject valueForKeyPath:JS_DATA];
		if (block) block([NSArray arrayWithArray:multiAttributes], nil, nil);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (block) block(nil, error, nil);
	}];
}

- (void)videosInPage:(NSNumber *)page withBlock:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block {
	[self GET:[self pathWithActionName:@"getVideos"] parameters:@{@"page" : page} success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSArray *multiAttributes = [responseObject valueForKeyPath:JS_DATA];
		if (block) block([NSArray arrayWithArray:multiAttributes], nil, nil);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (block) block(nil, error, nil);
	}];
}

- (void)getBanner:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block {
    [self GET:[self pathWithActionName:@"getBannerNews"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *multiAttributes = [responseObject valueForKeyPath:JS_DATA];
        if (block) block([NSArray arrayWithArray:multiAttributes], nil, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) block(nil, error, nil);
    }];
}

- (void)getLawerList:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block {
    [self GET:[self pathWithActionName:@"getLawyers"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *multiAttributes = [responseObject valueForKeyPath:JS_DATA];
        if (block) block([NSArray arrayWithArray:multiAttributes], nil, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) block(nil, error, nil);
    }];
}

- (void)getReserveTime:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block {
    [self GET:[self pathWithActionName:@"getReserveDate"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *multiAttributes = [responseObject valueForKeyPath:JS_DATA];
        if (block) block([NSArray arrayWithArray:multiAttributes], nil, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) block(nil, error, nil);
    }];
}

- (void)getMyReservation:(NSString *)uid withBlock:(void (^)(NSDictionary *attributes, NSError *error, NSString *message))block {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"account"] = uid;
    NSLog(@"%@", dict);
    [self GET:[self pathWithActionName:@"getMyReservation"] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) block(responseObject, nil, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) block(nil, error, nil);
    }];
}

- (void)addServe:(NSString *)userId
           phone:(NSString *)phone
          idCard:(NSString *)idCard
            name:(NSString *)name
            time:(NSString *)time
       withBlock:(void (^)(NSDictionary *attributes, NSError *error, NSString *message))block {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"name"] = name;
    dict[@"identity_number"] = idCard;
    dict[@"account"] = userId;
    dict[@"phone"] = phone;
    dict[@"reserve_date"] = time;
    NSLog(@"%@", dict);
    [self GET:[self pathWithActionName:@"reserve"] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) block(responseObject, nil, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) block(nil, error, nil);
    }];
}

- (void)getQuestions:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block {
    [self GET:[self pathWithActionName:@"getQuestions"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *multiAttributes = [responseObject valueForKeyPath:JS_DATA];
        if (block) block([NSArray arrayWithArray:multiAttributes], nil, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) block(nil, error, nil);
    }];
}

- (void)addScore:(NSString *)uid
           score:(NSInteger)score
             eid:(NSString *)eid
       withBlock:(void (^)(NSDictionary *attributes, NSError *error, NSString *message))block {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"account"] = uid;
    dict[@"score"] = @(score);
    dict[@"examination_id"] = eid;
    NSLog(@"%@", dict);
    [self GET:[self pathWithActionName:@"addMyScore"] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) block(responseObject, nil, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) block(nil, error, nil);
    }];
}

- (void)advice:(NSString *)content
        userID:(NSString *)uid
     withBlock:(void (^)(NSDictionary *attributes, NSError *error, NSString *message))block {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"account"] = uid;
    dict[@"content"] = content;
    NSLog(@"%@", dict);
    [self GET:[self pathWithActionName:@"advice"] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) block(responseObject, nil, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) block(nil, error, nil);
    }];
}


@end

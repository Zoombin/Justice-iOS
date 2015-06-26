//
//  JSAPIManager.m
//  Justice
//
//  Created by zhangbin on 6/26/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSAPIManager.h"


NSString * const JS_HOST = @"http://127.0.0.1/dushuhu-web/";
NSString * const JS_API_PREFIX = @"index.php?";
NSString * const JS_ACTION = @"action";

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

- (NSString *)APIPathWithActionName:(NSString *)actionName {
	return [NSString stringWithFormat:@"%@%@=%@", JS_API_PREFIX, JS_ACTION, actionName];
}

- (void)servicesInCategories:(void (^)(NSArray *multiAttributes, NSError *error, NSString *message))block {
	[self GET:[self APIPathWithActionName:@"getServices"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSArray *multiAttributes = [responseObject valueForKeyPath:@"data"];
		if (block) block([NSArray arrayWithArray:multiAttributes], nil, nil);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (block) block(nil, error, nil);
	}];
}

@end

//
//  JSVideo.h
//  Justice
//
//  Created by zhangbin on 6/27/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "ZBModel.h"

@interface JSVideo : ZBModel

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *streamPath;
@property (nonatomic, strong) NSDate *createdDate;

@end

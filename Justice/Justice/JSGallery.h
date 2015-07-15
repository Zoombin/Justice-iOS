//
//  JSGallery.h
//  Justice
//
//  Created by zhangbin on 6/26/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "ZBModel.h"

@interface JSGallery : ZBModel

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDate *createdDate;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) NSString *coverImagePath;

@end

//
//  NoticeView.h
//  Justice
//
//  Created by 颜超 on 15/7/3.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoticeViewDelegate <NSObject>
- (void)noticeButtonClicked:(UIView *)view;
@end
@interface NoticeView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, weak) id<NoticeViewDelegate> delegate;
@end

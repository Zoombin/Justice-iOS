//
//  NoticeView.m
//  Justice
//
//  Created by 颜超 on 15/7/3.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import "NoticeView.h"

@implementation NoticeView {
    UIButton *arrowButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *bkgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bkgButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [bkgButton addTarget:self action:@selector(bkgButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bkgButton];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_titleLabel];
        
        arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [arrowButton setBackgroundImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
        [arrowButton setBackgroundImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateSelected];
        arrowButton.frame = CGRectMake(bkgButton.frame.size.width - 30, 9.5, 21, 21);
        [self addSubview:arrowButton];
        
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = .5;
    }
    return self;
}

- (void)bkgButtonClicked {
    arrowButton.selected = !arrowButton.selected;
    if ([self.delegate respondsToSelector:@selector(noticeButtonClicked:)]) {
        [self.delegate noticeButtonClicked:self];
    }
}
@end

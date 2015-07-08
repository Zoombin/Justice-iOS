//
//  JSQuestionView.h
//  Justice
//
//  Created by 颜超 on 15/7/8.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSQuestion.h"

@protocol JSQuestionViewDelegate <NSObject>
- (void)answerIsCorrect:(BOOL)isCorrect
                  index:(NSInteger)index;
@end

@interface JSQuestionView : UIView

@property (nonatomic, weak) id<JSQuestionViewDelegate> delegate;
- (void)showQuestion:(JSQuestion *)question
               index:(NSInteger)index;
@end

//
//  JSQuestionView.m
//  Justice
//
//  Created by 颜超 on 15/7/8.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import "JSQuestionView.h"

@implementation JSQuestionView {
    UILabel *questionLabel;
    NSMutableArray *btns;
    UIButton *yes;
    UIButton *no;
    UIButton *a;
    UIButton *b;
    UIButton *c;
    UIButton *d;
    UIButton *e;
    UIButton *f;
    JSQuestion *qustionInfo;
    NSInteger _index;
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
        questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 100)];
        questionLabel.numberOfLines = 0;
        questionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:questionLabel];
        
        btns = [[NSMutableArray alloc] init];
        for (int i = 0; i < 8; i++) {
           UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, CGRectGetMaxY(questionLabel.frame), frame.size.width, 50);
            [btn setImage:[UIImage imageNamed:@"Chose"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"ChoseHighlighted"] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.hidden = YES;
            [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTag:i];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [self addSubview:btn];
            [btns addObject:btn];
        }
        yes = btns[0];
        no = btns[1];
        a = btns[2];
        b = btns[3];
        c = btns[4];
        d = btns[5];
        e = btns[6];
        f = btns[7];
    }
    return self;
}

- (void)buttonClicked:(id)sender {
    if ([qustionInfo.type integerValue] != 2) {
        [self allUpSelected];
    }
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    [self changeAnswer];
}

- (void)allUpSelected {
    for (UIButton *btn in btns) {
        btn.selected = NO;
    }
}

- (void)changeAnswer {
    BOOL correct = NO;
    NSString *answer = @"";
    if ([qustionInfo.type integerValue] == 0) {
        if (yes.selected) {
            answer = @"1";
        }
        if (no.selected) {
            answer = @"0";
        }
        if ([qustionInfo.yesOrNo integerValue] == [answer integerValue]) {
            correct = YES;
        }
        NSLog(@"%@", qustionInfo.yesOrNo);
    } else if ([qustionInfo.type integerValue] == 1) {
        NSArray *answers = @[@"a", @"b", @"c", @"d", @"e", @"f"];
        for (int i = 0; i < [btns count]; i++) {
            if (i > 1) {
                UIButton *btn = btns[i];
                if (btn.selected) {
                    answer = [NSString stringWithFormat:@"%@", answers[i-2]];
                }
            }
        }
        NSLog(@"%@", qustionInfo.answer);
        if ([answer isEqualToString:qustionInfo.answer]) {
            correct = YES;
        }
    } else {
        NSMutableArray *strs = [[NSMutableArray alloc] init];
        NSArray *answers = @[@"a", @"b", @"c", @"d", @"e", @"f"];
        for (int i = 0; i < [btns count]; i++) {
            if (i > 1) {
                UIButton *btn = btns[i];
                if (btn.selected) {
                    [strs addObject:answers[i - 2]];
                }
            }
        }
        for (int i = 0; i < [strs count]; i++) {
           answer = [answer stringByAppendingFormat:@"%@%@", strs[i], (i + 1) != [strs count] ? @"," : @""];
        }
        NSLog(@"%@", qustionInfo.answer);
        if ([answer isEqualToString:qustionInfo.answer]) {
            correct = YES;
        }
    }
    if (correct) {
        NSLog(@"答案正确");
    } else {
        NSLog(@"答案错误");
    }
    if ([self.delegate respondsToSelector:@selector(answerIsCorrect:index:)]) {
        [self.delegate answerIsCorrect:correct index:_index];
    }
}

- (void)showQuestion:(JSQuestion *)question index:(NSInteger)index {
    _index = index;
    qustionInfo = question;
    questionLabel.text = [NSString stringWithFormat:@"%ld.%@", index + 1, question.question];
    if ([question.type integerValue] == 0) {
        NSLog(@"判断题");
        [questionLabel sizeToFit];
        yes.frame = CGRectMake(0, CGRectGetMaxY(questionLabel.frame), yes.frame.size.width, yes.frame.size.height);
        yes.hidden = NO;
        [yes setTitle:@"是" forState:UIControlStateNormal];
        
        no.frame = CGRectMake(0, CGRectGetMaxY(yes.frame), no.frame.size.width, no.frame.size.height);
        no.hidden = NO;
        [no setTitle:@"否" forState:UIControlStateNormal];
    } else {
        if ([question.type integerValue] == 1) {
           NSLog(@"单选");
        } else {
           NSLog(@"多选");
        }
        
        [questionLabel sizeToFit];
        if ([question.a length] > 0) {
            a.frame = CGRectMake(0, CGRectGetMaxY(questionLabel.frame), a.frame.size.width, yes.frame.size.height);
            a.hidden = NO;
            [a setTitle:question.a forState:UIControlStateNormal];
        }
        if ([question.b length] > 0) {
            b.frame = CGRectMake(0, CGRectGetMaxY(a.frame), b.frame.size.width, b.frame.size.height);
            b.hidden = NO;
            [b setTitle:question.b forState:UIControlStateNormal];
        }
        if ([question.c length] > 0) {
            c.frame = CGRectMake(0, CGRectGetMaxY(b.frame), c.frame.size.width, c.frame.size.height);
            c.hidden = NO;
            [c setTitle:question.c forState:UIControlStateNormal];
        }
        if ([question.d length] > 0) {
            d.frame = CGRectMake(0, CGRectGetMaxY(c.frame), d.frame.size.width, d.frame.size.height);
            d.hidden = NO;
            [d setTitle:question.d forState:UIControlStateNormal];
        }
        if ([question.e length] > 0) {
            e.frame = CGRectMake(0, CGRectGetMaxY(d.frame), e.frame.size.width, e.frame.size.height);
            e.hidden = NO;
            [e setTitle:question.e forState:UIControlStateNormal];
        }
        if ([question.f length] > 0) {
            f.frame = CGRectMake(0, CGRectGetMaxY(e.frame), f.frame.size.width, f.frame.size.height);
            f.hidden = NO;
            [f setTitle:question.f forState:UIControlStateNormal];
        }
    }
}

@end

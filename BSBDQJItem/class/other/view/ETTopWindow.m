//
//  ETTopWindow.m
//  BSBDQJItem
//
//  Created by etund on 15/8/11.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETTopWindow.h"

@implementation ETTopWindow

static UIWindow * window_;

+ (void)initialize{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, ETScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+ (void)windowClick{
    [self searchScrollViewInView:ETKeyWindow];
  
}

+ (void)searchScrollViewInView:(UIView *)superView{
    for (UIScrollView *scroView in superView.subviews) {
        if ([scroView isKindOfClass:[UIScrollView class]]&&scroView.isShowingOnCurrentWindow) {
            CGPoint offSet = scroView.contentOffset;
            offSet.y = -scroView.contentInset.top;
            [scroView setContentOffset:offSet animated:YES];
        }
        [self searchScrollViewInView:scroView];
    }
}

+ (void)show{
    window_.hidden = NO;
}

+ (void)hide{
    window_.hidden = YES;
}
@end


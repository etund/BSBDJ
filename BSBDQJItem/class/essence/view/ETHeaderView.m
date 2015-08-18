//
//  ETHeaderView.m
//  BSBDQJItem
//
//  Created by etund on 15/8/11.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETHeaderView.h"


@interface ETHeaderView ()
@property (nonatomic, weak) UILabel * headerTitle;
@end

@implementation ETHeaderView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ETGlobalBackColorAlpha(0.4);
        [self setUp];
    }
    return self;
}

- (void)setUp{
    UILabel *headerTitle = [[UILabel alloc] init];
    headerTitle.x =  TopicCellMargin;
    headerTitle.height = 20;
    headerTitle.y = 5;
    //    最起码又一个
    headerTitle.width = ETScreenW - 2 * TopicCellMargin;
    headerTitle.layer.cornerRadius = 5;
    headerTitle.font = [UIFont systemFontOfSize:15];
    [self addSubview:headerTitle];
    self.headerTitle = headerTitle;
}

- (void)setTitle:(NSString *)title{
    _title = [title copy];
    self.headerTitle.text = title;
}

- (void)setAlpha:(CGFloat)alpha{
    alpha = 0.5;
    [super setAlpha:alpha];
}

@end

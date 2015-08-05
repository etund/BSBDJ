//
//  ETIndecatorView.m
//  BSBDQJItem
//
//  Created by etund on 15/7/28.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETIndecatorView.h"
#define ETTitleBtnWith [UIScreen mainScreen].bounds.size.width/5.0

@implementation ETIndecatorView

- (void)setScale:(CGFloat)scale{
    _scale = scale;
    self.center = CGPointMake(scale * ETTitleBtnWith + ETTitleBtnWith / 2.0, self.center.y);//位移
}

@end

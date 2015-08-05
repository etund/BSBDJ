//
//  ETButton.m
//  BSBDQJItem
//
//  Created by etund on 15/7/27.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETButton.h"

@implementation ETButton

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, self.imageView.width, self.imageView.width);
    self.titleLabel.frame = CGRectMake(0, self.imageView.width + 2, self.imageView.width,  self.height - self.imageView.width);
}

@end

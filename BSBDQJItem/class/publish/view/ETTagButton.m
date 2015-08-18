//
//  ETTagButton.m
//  BSBDQJItem
//
//  Created by etund on 15/8/8.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETTagButton.h"

@implementation ETTagButton

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.x = TagMargin;
    self.imageView.x = TagMargin * 2 + self.titleLabel.width;
}



@end

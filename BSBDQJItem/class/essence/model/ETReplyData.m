//
//  ETReplyData.m
//  BSBDQJItem
//
//  Created by etund on 15/8/10.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETReplyData.h"

@implementation ETReplyData{
    CGFloat _cellHeght;
}

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID":@"id"
             };
}


- (CGFloat)cellHeght{
    if (!_cellHeght) {
        _cellHeght += 2 * TopicCellMargin + 33;
        CGSize maxSSize = CGSizeMake(ETScreenW - 4 * TopicCellMargin, MAXFLOAT);
        CGFloat textHeght = [self.content boundingRectWithSize:maxSSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        _cellHeght += (textHeght + TopicCellMargin);
    }
    return _cellHeght;
}

@end

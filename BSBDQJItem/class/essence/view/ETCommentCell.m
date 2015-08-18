//
//  ETCommentCell.m
//  BSBDQJItem
//
//  Created by etund on 15/8/11.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETCommentCell.h"
#import "UIImageView+WebCache.h"

@interface ETCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *sex;
@property (weak, nonatomic) IBOutlet UILabel *nick;

@property (weak, nonatomic) IBOutlet UILabel *dingCount;
@property (weak, nonatomic) IBOutlet UILabel *contentText;


@end

@implementation ETCommentCell

- (void)awakeFromNib {
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
}

- (void)setData:(ETReplyData *)data{
    _data = data;
    [self.icon setHeader:data.user.profile_image];
    self.sex.image = [data.user.sex isEqualToString:@"m"]?[UIImage imageNamed:@"Profile_manIcon"]:[UIImage imageNamed:@"Profile_womanIcon"];
    self.nick.text = data.user.username;
    self.contentText.numberOfLines = 0;
    self.dingCount.text = [NSString stringWithFormat:@"%zd",data.like_count];
    self.contentText.text = data.content;
    
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += TopicCellMargin;
    frame.size.width -= 2 * frame.origin.x;
    [super setFrame:frame];
}

@end

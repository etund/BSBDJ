//
//  ETUserCell.m
//  BSBDQJItem
//
//  Created by etund on 15/7/24.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETUserCell.h"
#import "UIImageView+WebCache.h"

@interface ETUserCell()
@property (weak, nonatomic) IBOutlet UILabel *screen_name;
@property (weak, nonatomic) IBOutlet UILabel *fans_count;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end

@implementation ETUserCell

- (void)setData:(ETRecomentUserData *)data{
    _data = data;
    self.screen_name.text = data.screen_name;
    self.fans_count.text = data.fans_count;
//    [self.icon sd_setImageWithURL:[NSURL URLWithString:data.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [self.icon setHeader:data.header];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 2;
    frame.size.width = frame.size.width - 2 * frame.origin.x - 5;
    frame.size.height = frame.size.height - 9;
    [super setFrame:frame];
}

- (void)setAlpha:(CGFloat)alpha{
    [super setAlpha:0.6];
}
@end

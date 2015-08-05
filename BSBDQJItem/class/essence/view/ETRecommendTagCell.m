//
//  ETRecommendTagCell.m
//  BSBDQJItem
//
//  Created by etund on 15/7/27.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETRecommendTagCell.h"
#import "UIImageView+WebCache.h"

@interface ETRecommendTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *tagName;
@property (weak, nonatomic) IBOutlet UILabel *sub_count;

@end

@implementation ETRecommendTagCell

- (void)setData:(ETRecommendTagData *)data{
    _data = data;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:data.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.tagName.text = data.theme_name;
    self.sub_count.text = [NSString stringWithFormat:@"%zd",data.sub_number];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    CGRect rect = self.frame;
    rect.origin.x = 10;
    rect.size.width -= 2* rect.origin.x;
    rect.origin.y -= 2;
    rect.size.height  -= 4;
    [super setFrame:rect];
    
}

- (void)setAlpha:(CGFloat)alpha{
    [super setAlpha:0.6];
}
@end

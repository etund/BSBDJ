//
//  ETCategoryCell.m
//  BSBDQJItem
//
//  Created by etund on 15/7/24.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETCategoryCell.h"
@interface ETCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *flagView;
@end

@implementation ETCategoryCell

//选中当前的cell的时候调用
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.flagView.hidden = !selected;
    self.textLabel.textColor = selected?self.flagView.backgroundColor:ETColor(78, 78, 78);
    
}

- (void)setData:(ETCategoryData *)data{
    _data = data;
    self.textLabel.text = data.name;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.y = 8;
    self.textLabel.height = self.height - 2 * self.textLabel.y;
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 5;
    frame.size.width = frame.size.width - 2 * frame.origin.x;
    frame.size.height = frame.size.height - 4;
    [super setFrame:frame];
}

- (void)setAlpha:(CGFloat)alpha{
    [super setAlpha:0.6];
}

@end

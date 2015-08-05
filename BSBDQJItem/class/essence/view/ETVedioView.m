//
//  ETVedioView.m
//  BSBDQJItem
//
//  Created by etund on 15/8/4.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETVedioView.h"
#import "UIImageView+WebCache.h"

@interface ETVedioView()
@property (weak, nonatomic) IBOutlet UIImageView *blackImage;
@property (weak, nonatomic) IBOutlet UILabel *viewTimes;
@property (weak, nonatomic) IBOutlet UILabel *timeLength;

@end
@implementation ETVedioView

- (void)setData:(ETTopicData *)data{
    _data = data;
    self.frame = _data.videoPicF;
    [_blackImage sd_setImageWithURL:[NSURL URLWithString:_data.large_image]];
    _timeLength.textColor = [UIColor whiteColor];
    _viewTimes.textColor = [UIColor whiteColor];
    _timeLength.font = [UIFont systemFontOfSize:13];
    _viewTimes.font = [UIFont systemFontOfSize:13];
    _timeLength.text = [NSString stringWithFormat:@"%02zd:%02zd",_data.videotime / 60,_data.videotime % 60];
    _viewTimes.text = [NSString stringWithFormat:@"%zd播放",_data.playcount];
}
@end

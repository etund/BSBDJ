//
//  ETVoiceView.m
//  BSBDQJItem
//
//  Created by etund on 15/8/4.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETVoiceView.h"
#import "UIImageView+WebCache.h"

@interface ETVoiceView()
@property (weak, nonatomic) IBOutlet UILabel *viewTime;
@property (weak, nonatomic) IBOutlet UILabel *timeLength;
@property (weak, nonatomic) IBOutlet UIImageView *blackImage;

@end

@implementation ETVoiceView

- (void)setData:(ETTopicData *)data{
    _data = data;
    self.frame = _data.voicePicF;
    [_blackImage sd_setImageWithURL:[NSURL URLWithString:_data.large_image]];
    _timeLength.textColor = [UIColor whiteColor];
    _viewTime.textColor = [UIColor whiteColor];
    _timeLength.font = [UIFont systemFontOfSize:13];
    _viewTime.font = [UIFont systemFontOfSize:13];
    _timeLength.text = [NSString stringWithFormat:@"%02zd:%02zd",_data.voicetime/60,_data.voicetime % 60];
    _viewTime.text = [NSString stringWithFormat:@"%zd播放",_data.playcount];
}

@end

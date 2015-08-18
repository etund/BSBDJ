//
//  ETTopicCell.m
//  BSBDQJItem
//
//  Created by etund on 15/7/27.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETTopicCell.h"

#import "UIImageView+WebCache.h"

#import "ETProgressView.h"

#import "ETShowDetailsController.h"

#import "ETVoiceView.h"

#import "ETVedioView.h"



@interface ETTopicCell()//<NSCopying,NSMutableCopying>
@property (weak, nonatomic) IBOutlet UIImageView * icon;
@property (weak, nonatomic) IBOutlet UILabel * name;
@property (weak, nonatomic) IBOutlet UILabel * postTime;

@property (weak, nonatomic) IBOutlet UILabel * contentText;
@property (nonatomic, weak) UIImageView * contentPic;
@property (nonatomic, weak) UIImageView * gifFlag;
@property (nonatomic, weak) UIImageView * fullLookView;

@property (nonatomic, strong) ETVoiceView * voiceView;
@property (nonatomic, strong) ETVedioView * vedioView;

@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *commendBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *repost;


@end

@implementation ETTopicCell

- (void)setData:(ETTopicData *)data{
    _data = data;
    
//      顶部内容
//    [self.icon sd_setImageWithURL:[NSURL URLWithString:data.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [self.icon setHeader:data.profile_image];
    self.name.text = data.name;
    self.postTime.text = data.created_at;
    self.contentText.text = self.data.text;
//  中部内容
//    图片
    if (data.type == ETTopicControllerTypePic) {//图片模块
//        图片
        self.voiceView.hidden = YES;
        self.vedioView.hidden = YES;
        self.contentPic.hidden = NO;
        [self setPicContent];
    }else if(data.type == ETTopicControllerTypeVoice){//音频模块
//        声音
        self.contentPic.hidden = YES;
        self.vedioView.hidden = YES;
        self.voiceView.hidden = NO;
        [self setVoiceContent];
    }else if (data.type == ETTopicControllerTypeVideo){//视频模块
        self.contentPic.hidden = YES;
        self.voiceView.hidden = YES;
        self.vedioView.hidden = NO;
        [self setUpVedioView];
    }else if (data.type == ETTopicControllerTypeWord){//文字模块
        self.contentPic.hidden = YES;
        self.voiceView.hidden = YES;
        self.vedioView.hidden = YES;
    }
    [self setDataOfBtn:self.caiBtn WithData:data.cai];
    [self setDataOfBtn:self.dingBtn WithData:data.ding];
    [self setDataOfBtn:self.repost WithData:data.repost];
    [self setDataOfBtn:self.commendBtn WithData:data.comment];
}

#pragma mark - 初始化设置
- (void)awakeFromNib {
    self.layer.cornerRadius = 10;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - 让cell有空格
- (void)setFrame:(CGRect)frame{
    frame.origin.x += TopicCellMargin;
    frame.size.width -= 2 * frame.origin.x;
//    frame.size.height -= TopicCellMargin;
//    frame.origin.y += TopicCellMargin;
    [super setFrame:frame];
}

#pragma mark - 处理工具条数据
- (void)setDataOfBtn:(UIButton *)btn WithData:(NSString *)data{
    NSInteger count = [data integerValue];
//    1 大于一万，显示几万几
    if(count > 10000){
        [btn setTitle:[NSString stringWithFormat:@"%.1f万",count/10000.0] forState:UIControlStateNormal];
    }else{
//    2 小于一万，显示确切数字
        [btn setTitle:[NSString stringWithFormat:@"%zd",count] forState:UIControlStateNormal];
    }
}



- (void)setPicContent{
    //      中部内容
    self.contentPic.hidden = YES;
        [self.contentPic removeFromSuperview];
        UIImageView *contentPic = [[UIImageView alloc] initWithFrame:self.data.pictureF];
        self.contentPic = contentPic;
        self.contentPic.hidden = NO;
        
        [self.contentPic addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDetails)]];
        //        进度条
        ETProgressView *progressView = [[ETProgressView alloc] init];
        progressView.center = self.contentPic.center;
        progressView.bounds = CGRectMake(0, 0, 50, 50);
        progressView.hidden = YES;
        [self.contentPic sd_setImageWithURL:[NSURL URLWithString:self.data.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            progressView.hidden = NO;
            CGFloat progress = 1.0 * receivedSize/expectedSize;
            [progressView setProgress:progress animated:NO];
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            判断是否是长图
            if (_data.isLongPic) {
                UIImage *currentImage = self.contentPic.image;
                CGFloat picH = _data.pictureF.size.width * _data.height / _data.width;
                UIGraphicsBeginImageContextWithOptions(_data.pictureF.size, YES, 0.0);
                [currentImage drawInRect:CGRectMake(0, 0, _data.pictureF.size.width,picH)];
                currentImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                self.contentPic.image = currentImage;
            }
            progressView.hidden = YES;
        }];
        [self addSubview:self.contentPic];
        
        ////        添加gif标志
        UIImageView *gifFlag = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 31, 31)];
        gifFlag.image = [UIImage imageNamed:@"common-gif"];
        gifFlag.hidden = YES;
        self.gifFlag = gifFlag;
        [self.contentPic addSubview:self.gifFlag];
        //        获取后缀名
        NSString *extension = self.data.large_image.pathExtension;
        if ([extension isEqualToString:@"gif"]) self.gifFlag.hidden = NO;
        
        //        是否是长图
        UIImageView *fullLookView = [[UIImageView alloc] init];
        fullLookView.image = [UIImage imageNamed:@"see-big-picture-background"];
        
        UIButton *showPicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [showPicBtn setTitle:@"点击显示图片" forState:UIControlStateNormal];
        [showPicBtn setImage:[[UIImage imageNamed:@"see-big-picture"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [showPicBtn setImage:[[UIImage imageNamed:@"see-big-picture"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
        CGFloat lookViewH = 30;
        CGFloat lookViewW = self.contentPic.width;
        CGFloat lookViewY = self.contentPic.height - lookViewH;
        fullLookView.frame = CGRectMake(0, lookViewY, lookViewW, lookViewH);
        fullLookView.hidden = YES;
        [self.contentPic addSubview:fullLookView];
        self.fullLookView = fullLookView;
        if (self.data.isLongPic) self.fullLookView.hidden = NO;
        
        CGFloat showBtnH = 25;
        CGFloat showBtnW = self.fullLookView.width/2;
        CGFloat cententX = self.fullLookView.width/2.0;
        CGFloat cententY = self.fullLookView.height/2.0;
        showPicBtn.frame = CGRectMake(cententX, cententY, showBtnW, showBtnH);
        showPicBtn.layer.anchorPoint = CGPointMake(1, 1);
        showPicBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [showPicBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [showPicBtn addTarget:self action:@selector(showDetails) forControlEvents:UIControlEventTouchUpInside];
        
        self.contentPic.userInteractionEnabled = YES;
        self.fullLookView.userInteractionEnabled = YES;
        
        [self.fullLookView addSubview:showPicBtn];
        [self.contentPic addSubview:progressView];
}


//图片展示细节
- (void)showDetails{
    ETShowDetailsController *vc = [[ETShowDetailsController alloc] init];
    vc.data = _data;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

//声音
- (void)setVoiceContent{
    [self.voiceView removeFromSuperview];
    ETVoiceView *voiceView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ETVoiceView class]) owner:nil options:nil] lastObject];
    voiceView.data = _data;
    self.voiceView = voiceView;
    [self addSubview:voiceView];
}

//视频
- (void)setUpVedioView{
    [self.vedioView removeFromSuperview];
    ETVedioView *vedioView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ETVedioView class]) owner:nil options:nil] lastObject];
    vedioView.data = _data;
    self.vedioView = vedioView;
    [self addSubview:vedioView];
}

//+ (instancetype)newCell:(ETTopicCell *)topicCell{
//    ETTopicCell *cell = [[ETTopicCell alloc] init];
//    
//}
@end

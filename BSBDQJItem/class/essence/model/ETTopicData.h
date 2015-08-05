//
//  ETTopicData.h
//  BSBDQJItem
//
//  Created by etund on 15/7/27.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETTopicController.h"

@interface ETTopicData : NSObject
/** 内容属性*/
//上部内容
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * profile_image;
@property (nonatomic, strong) NSString * created_at;

//中部内容
@property (nonatomic, strong) NSString * text;

/* 图片url */

//图片
@property (nonatomic, strong) NSString * small_image;
@property (nonatomic, strong) NSString * middle_image;
@property (nonatomic, strong) NSString * large_image;
@property (nonatomic, assign,getter=isLongPic) BOOL  longPic;

//声音
//时长
@property (nonatomic, assign) NSInteger  voicetime;
//播放次数
@property (nonatomic, assign) NSInteger  playcount;

//视频
@property (nonatomic, assign) NSInteger  videotime;



//下部工具条内容
@property (nonatomic, strong) NSString * cai;
@property (nonatomic, strong) NSString * comment;
@property (nonatomic, strong) NSString * repost;
@property (nonatomic, strong) NSString * ding;

/** 辅助属性 **/
//服务器返回属性
@property (nonatomic, assign) ETTopicControllerType  type;
@property (nonatomic, assign) CGFloat  width;
@property (nonatomic, assign) CGFloat  height;

//自定义属性
@property (nonatomic, assign,readonly) CGFloat  nomalCellHeight;
@property (nonatomic, assign,readonly) CGRect  pictureF;
@property (nonatomic, assign,readonly) CGRect  voicePicF;
@property (nonatomic, assign,readonly) CGRect  videoPicF;

@end

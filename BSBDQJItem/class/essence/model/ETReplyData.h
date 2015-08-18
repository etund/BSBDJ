//
//  ETReplyData.h
//  BSBDQJItem
//
//  Created by etund on 15/8/10.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETCommentUserData.h"

@interface ETReplyData : NSObject
/**  评论ID */
@property (nonatomic, assign) NSInteger  ID;

/**  音频评论URL */
@property (nonatomic, strong) NSString * voiceuri;
/**  音频评论时长 */
@property (nonatomic, strong) NSString * voicetime;

/**  文字评论内容 */
@property (nonatomic, strong) NSString * content;
/**  评论赞数 */
@property (nonatomic, assign) NSInteger like_count;
/**  用户模型数据 */
@property (nonatomic, strong) ETCommentUserData * user;

@property (nonatomic, assign,readonly) CGFloat  cellHeght;
@end

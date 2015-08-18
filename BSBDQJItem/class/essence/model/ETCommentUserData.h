//
//  ETCommentUserData.h
//  BSBDQJItem
//
//  Created by etund on 15/8/10.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface ETCommentUserData : NSObject
/**  ID */
@property (nonatomic, assign) NSInteger  ID;
/**  头像 */
@property (nonatomic, strong) NSString * profile_image;
/**  昵称 */
@property (nonatomic, strong) NSString * username;
/**  性别 */
@property (nonatomic, strong) NSString * sex;
@end

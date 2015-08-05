//
//  ETTopicController.h
//  BSBDQJItem
//
//  Created by etund on 15/7/27.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const tagCellId = @"tagCell";

typedef NS_ENUM(NSInteger,ETTopicControllerType){
    ETTopicControllerTypeAll = 1,
    ETTopicControllerTypePic = 10,
    ETTopicControllerTypeWord = 29,
    ETTopicControllerTypeVoice = 31,
    ETTopicControllerTypeVideo = 41
};

@interface ETTopicController : UITableViewController
@property (nonatomic, assign) ETTopicControllerType type;
@end

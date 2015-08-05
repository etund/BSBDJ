//
//  ETTopicCell.h
//  BSBDQJItem
//
//  Created by etund on 15/7/27.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETTopicData.h"

@protocol ETTopicCellDelegate <NSObject>

@optional
- (void)shoImageDeatails:(ETTopicData *)data;

@end
@interface ETTopicCell : UITableViewCell

@property (nonatomic, strong) ETTopicData * data;

@property (nonatomic, assign) id<ETTopicCellDelegate>  delegate;
@end

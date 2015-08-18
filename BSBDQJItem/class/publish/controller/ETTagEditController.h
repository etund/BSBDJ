//
//  ETTagEditController.h
//  BSBDQJItem
//
//  Created by etund on 15/8/7.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ETTagsBlock)(NSMutableArray *);

@interface ETTagEditController : UIViewController

@property (nonatomic, copy) ETTagsBlock tagsBlock;

@property (nonatomic, strong) NSMutableArray * tags;

@end

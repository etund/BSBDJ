//
//  ETCategoryData.h
//  BSBDQJItem
//
//  Created by etund on 15/7/24.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETCategoryData : NSObject
//左边视图的总数
@property (nonatomic, assign) NSInteger  count;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger  id;
@property (nonatomic, strong) NSMutableArray *userDatas;
@property (nonatomic, assign) NSInteger  total;

@property (nonatomic, assign) NSInteger  currentPage;

@end

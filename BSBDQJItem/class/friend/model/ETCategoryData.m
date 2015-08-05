//
//  ETCategoryData.m
//  BSBDQJItem
//
//  Created by etund on 15/7/24.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETCategoryData.h"

@implementation ETCategoryData

- (NSMutableArray *)userDatas{
    if (!_userDatas) {
        _userDatas = [NSMutableArray array];
    }
    return _userDatas;
}

@end

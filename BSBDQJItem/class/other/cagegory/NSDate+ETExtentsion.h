//
//  NSDate+ETExtentsion.h
//  BSBDQJItem
//
//  Created by etund on 15/7/28.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ETExtentsion)

/**
 * 获取时间差值
 */
- (NSDateComponents *)getShortDateComponents;

/**
 *  是否是今年
 */
- (BOOL)isThisYear;

/**
 *  是否是今天
 */
- (BOOL)isTody;

/**
 *  是否是昨天
 */
- (BOOL)isYesterday;

/**
 *  是否是一小时内
 */
- (BOOL)isThisHour;

/**
 *  是否是一分钟内
 */
- (BOOL)isThisMin;
@end

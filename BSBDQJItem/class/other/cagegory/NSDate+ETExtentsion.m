//
//  NSDate+ETExtentsion.m
//  BSBDQJItem
//
//  Created by etund on 15/7/28.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "NSDate+ETExtentsion.h"

@implementation NSDate (ETExtentsion)

//判断是否是今年
- (BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear == selfYear;
}

//判断是否是今天
- (BOOL)isTody{
    NSDateFormatter *dfm = [[NSDateFormatter alloc] init];
    dfm.dateFormat = @"yyyy-MM-dd";
    NSString *selfDate = [dfm stringFromDate:self];
    NSString *nowDate = [dfm stringFromDate:[NSDate date]];
    return [selfDate isEqualToString:nowDate];
}

- (BOOL)isYesterday{
    NSDateFormatter *dfm = [[NSDateFormatter alloc] init];
    dfm.dateFormat = @"yyyy-MM-dd";
    NSDate *selfDate = [dfm dateFromString:[dfm stringFromDate:self]];
    NSDate *nowDate = [dfm dateFromString:[dfm stringFromDate:[NSDate date]]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *contents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return contents.year==0&&contents.month==0&&contents.day==1;
}

- (BOOL)isThisHour{
    NSDateFormatter *dfm = [[NSDateFormatter alloc] init];
    dfm.dateFormat = @"yyyy-MM-dd HH";
    NSString *selfDate = [dfm stringFromDate:self];
    NSString *nowDate = [dfm stringFromDate:[NSDate date]];
    return [selfDate isEqualToString:nowDate];
    
}

- (BOOL)isThisMin{
    NSDateFormatter *dfm = [[NSDateFormatter alloc] init];
    dfm.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *selfDate = [dfm stringFromDate:self];
    NSString *nowDate = [dfm stringFromDate:[NSDate date]];
    return [selfDate isEqualToString:nowDate];
}

- (NSDateComponents *)getShortDateComponents{
    NSDateFormatter *dfm = [[NSDateFormatter alloc] init];
    dfm.dateFormat = @"yyyy-MM-dd HH:mm";
    dfm.timeZone = [NSTimeZone timeZoneWithName:@"Etc/GMT+8"];
    NSDate *nowDate = [dfm dateFromString:[dfm stringFromDate:[NSDate date]]];
    NSDate *selfDate  = [dfm dateFromString:[dfm stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:selfDate toDate:nowDate options:0];
    return [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:selfDate toDate:nowDate options:0];
}

@end

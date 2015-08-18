//
//  ETTopicData.m
//  BSBDQJItem
//
//  Created by etund on 15/7/27.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETTopicData.h"
#import "MJExtension.h"

@implementation ETTopicData{
    CGFloat  _nomalCellHeight;
}

//字典转换
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID":@"id",
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2"
             };
}


//时间处理
- (NSString *)created_at{
//    create	__NSTaggedDate *	2015-07-30 00:18:32 UTC	0xe41bb69a4d800000
//    1 判断是否是今年
//    2 判断是否是今天
//    3 判断是否是昨天
//    4 判断是否是一个小时内
//    5 判断是否是一分钟内
    NSDateFormatter *dfm = [[NSDateFormatter alloc] init];
    dfm.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    dfm.timeZone = [NSTimeZone timeZoneWithName:@"Etc/GMT+8"];
    NSDate *create = [dfm dateFromString:_created_at];
    NSDateComponents *comps = [create getShortDateComponents];
    if ([create isThisYear]) {
        if([create isTody]){
            if ([create isThisHour]) {//一小时内
                if ([create isThisMin]) {//当前分钟内
                    return @"刚刚";
                }else{//几分钟前
                    return [NSString stringWithFormat:@"%zd分钟前",comps.minute];
                }
            }else{
//                几小时前
                return [NSString stringWithFormat:@"%zd小时前",comps.hour];
            }
        }else if ([create isYesterday]){//昨天某时某分
            return [NSString stringWithFormat:@"昨天%zd:%zd",comps.hour,comps.minute];
        }else{ //某月某日某时某分
            dfm.dateFormat = @"MM月dd日 HH:mm";
            return [dfm stringFromDate:[dfm dateFromString:_created_at]];
        }
    }else{//某某年 某月 某日 某时 某分
        return _created_at;
    }
}


#pragma mark - 懒加载
- (CGFloat)nomalCellHeight{
    if(!_nomalCellHeight){
//    cell高度
        CGFloat cellHeight = 0;
//        头部高度
        cellHeight += TopicCellTopHeight;
//    文字高度
        CGSize maxSize = CGSizeMake(ETScreenW - 4 * TopicCellMargin, MAXFLOAT);
        cellHeight += ([self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height + TopicCellMargin);
        _nomalCellHeight = cellHeight;
        CGFloat picX = TopicCellMargin;
        if (self.type == ETTopicControllerTypePic) {
            CGFloat picY = _nomalCellHeight;
            CGFloat picW = maxSize.width;
            CGFloat picH = picW * self.height/self.width;
            self.longPic = NO;
            if (picH >1000) {
                picH = 300;
                self.longPic = YES;
            }
            _pictureF = CGRectMake(picX, picY, picW, picH);
//            由于高度减去可一个间隙，所以这里要加上一个间隙
            _nomalCellHeight += (picH +  TopicCellMargin);
        }else if (self.type == ETTopicControllerTypeVoice){
//            计算声音高度
            _voicePicF = CGRectMake(picX, _nomalCellHeight, maxSize.width , maxSize.width);
            _nomalCellHeight += (maxSize.width + TopicCellMargin);
        }else if (self.type == ETTopicControllerTypeVideo){
            CGFloat picY = _nomalCellHeight;
            CGFloat picW = maxSize.width;
            CGFloat picH = picW * self.height/self.width;
            _videoPicF = CGRectMake(picX, picY, picW, picH);
            _nomalCellHeight += (picH + TopicCellMargin);
        }
        
    }
    return _nomalCellHeight + TopicCellBottomHeight + TopicCellMargin;
}
@end

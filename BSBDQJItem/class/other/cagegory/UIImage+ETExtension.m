//
//  UIImage+ETExtension.m
//  BSBDQJItem
//
//  Created by etund on 15/8/11.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "UIImage+ETExtension.h"

@implementation UIImage (ETExtension)
- (UIImage *)circle{
//    开始上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
//    获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    添加圆到上下文
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
//    截取图片
    CGContextClip(ctx);
    [self drawInRect:rect];
//    获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    关闭上下文
    UIGraphicsEndImageContext();
    return image;
}
@end

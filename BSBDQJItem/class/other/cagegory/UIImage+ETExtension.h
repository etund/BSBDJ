//
//  UIImage+ETExtension.h
//  BSBDQJItem
//
//  Created by etund on 15/8/11.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ETExtension)

/**
 * 用layer设置圆角，资源占用较大，应当用画图去实现
 */
- (UIImage *)circle;

@end

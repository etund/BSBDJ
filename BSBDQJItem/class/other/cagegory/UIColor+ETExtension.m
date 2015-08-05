//
//  UIColor+ETExtension.m
//  BSBDQJItem
//
//  Created by etund on 15/7/24.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "UIColor+ETExtension.h"

@implementation UIColor (ETExtension)
+ (instancetype)randomColor{
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    return ETColor(r, g, b);
}
@end

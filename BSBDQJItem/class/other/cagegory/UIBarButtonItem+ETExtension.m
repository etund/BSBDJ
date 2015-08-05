//
//  UIBarButtonItem+ETExtension.m
//  BSBDQJItem
//
//  Created by etund on 15/7/23.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "UIBarButtonItem+ETExtension.h"

@implementation UIBarButtonItem (ETExtension)
+ (instancetype)itemWithNormalImage:(NSString *)nomalImage andClickImage:(NSString *)hightLightImage andTarget:(id)target andSelect:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[[UIImage imageNamed:nomalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [btn setImage:[[UIImage imageNamed:hightLightImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}
@end

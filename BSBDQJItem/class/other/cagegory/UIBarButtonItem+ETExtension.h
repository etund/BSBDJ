//
//  UIBarButtonItem+ETExtension.h
//  BSBDQJItem
//
//  Created by etund on 15/7/23.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ETExtension)
+ (instancetype)itemWithNormalImage:(NSString *)nomalImage andClickImage:(NSString *)hightLightImage andTarget:(id)target andSelect:(SEL)action;

@end

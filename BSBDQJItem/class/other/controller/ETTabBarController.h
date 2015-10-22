//
//  ETTabBarController.h
//  BSBDQJItem
//
//  Created by etund on 15/7/22.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETTabBarController : UITabBarController

+ (instancetype)tabBarControllerWithTitleArray:(NSArray *)titles andNormalImages:(NSArray *)nomalImages andSelectedImages:(NSArray *)selectedImages andClassName:(NSArray *)classNames;

@end

//
//  ETTabBarController.h
//  BSBDQJItem
//
//  Created by etund on 15/7/22.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETTabBarController : UITabBarController

/**
 *  用户返回一个自定义的TabBarVC实例，若然对NavigationController没有特殊要求可以用这个方法并且对菜单栏没有特殊要求的
 *
 *  @param titles         控制器标题S
 *  @param nomalImages    菜单栏普通状态图片
 *  @param selectedImages 菜单栏选中状态图片
 *  @param classNames     控制器的类名
 *
 *  @return 返回一个自定义框架的菜单栏
 */
+ (instancetype)tabBarControllerWithTitleArray:(NSArray *)titles andNormalImages:(NSArray *)nomalImages andSelectedImages:(NSArray *)selectedImages andClassName:(NSArray *)classNames;


/**
 *  用户返回一个自定义的TabBarVC实例，若然对NavigationController有特殊要求可以用这个方法
 *
 *  @param titles          控制器标题S
 *  @param nomalImages     菜单栏普通状态图片
 *  @param selectedImages  菜单栏选中状态图片
 *  @param classNames      控制器的类名
 *  @param navigationClass 传进来的导航栏的类，若为空，则使用系统自带的UINavgationController
 *
 *  @return 返回一个自定义框架的菜单栏
 */
+ (instancetype)tabBarControllerWithTitleArray:(NSArray *)titles andNormalImages:(NSArray *)nomalImages andSelectedImages:(NSArray *)selectedImages andClassName:(NSArray *)classNames withNavigation:(Class)navigationClass;


/**
 *  用户返回一个自定义的TabBarVC实例，若然对NavigationController有特殊要求并且对整个菜单栏有要求的话有特殊要求可以用这个方法
 *
 *  @param titles          控制器标题S
 *  @param nomalImages     菜单栏普通状态图片
 *  @param selectedImages  菜单栏选中状态图片
 *  @param classNames      控制器的类名
 *  @param navigationClass 传进来的导航栏的类，若为空，则使用系统自带的UINavgationController
 *  @param tabBar          自定义的UITabBar类
 *
 *  @return 返回一个自定义框架的菜单栏
 */
+ (instancetype)tabBarControllerWithTitleArray:(NSArray *)titles andNormalImages:(NSArray *)nomalImages andSelectedImages:(NSArray *)selectedImages andClassName:(NSArray *)classNames withNavigation:(Class)navigationClass andSelfTabBarClass:(Class)tabBarClass;
@end

//
//  ETTabBarController.m
//  BSBDQJItem
//
//  Created by etund on 15/7/22.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETTabBarController.h"
#import "ETEssenceController.h"
#import "ETFriendController.h"
#import "ETMeController.h"
#import "ETNewPostController.h"

#import "ETTabBar.h"

#import "ETNavContioller.h"

typedef void(^initBlock)();


@interface ETTabBarController ()

@property (nonatomic, copy)  initBlock initBLK;

@end

@implementation ETTabBarController
#pragma mark - 初始化方法
+ (instancetype)tabBarControllerWithTitleArray:(NSArray *)titles andNormalImages:(NSArray *)nomalImages andSelectedImages:(NSArray *)selectedImages andClassName:(NSArray *)classNames{
    ETTabBarController *tabBarVC = [[ETTabBarController alloc] init];
    NSString * title = nil;
    NSString * nomalImage = nil;
    NSString * selectedImage = nil;
    __unsafe_unretained Class  className = nil;
    for (int i = 0; i < titles.count; i++) {
        title = titles[i];
        nomalImage = nomalImages[i];
        selectedImage = selectedImages[i];
        className = classNames[i];
        [tabBarVC addSigleControllerWith:className andTitle:title withNormalImage:nomalImage andSelectImage:selectedImage];
        }
    [tabBarVC setValue:[[ETTabBar alloc] init]forKeyPath:@"tabBar"];
    return tabBarVC;
}

#pragma mark - 添加控制器
//添加单个子控制器
- (void)addSigleControllerWith:(Class)class andTitle:(NSString *)tabBarTitle withNormalImage:(NSString *)imageName andSelectImage:(NSString *)selectImageName{
    UIViewController *vc = [[class alloc] init];
    vc.tabBarItem.title = tabBarTitle;
    [vc.tabBarItem setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [vc.tabBarItem setSelectedImage:[[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self addChildViewController:[[ETNavContioller alloc] initWithRootViewController:vc]];
}

@end

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


@interface ETTabBarController ()
@end

@implementation ETTabBarController



#pragma mark - 初始化方法
+ (instancetype)tabBarController{
    ETTabBarController *tabBar = [[ETTabBarController alloc] init];
    return tabBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubControllers];
}

#pragma mark - 添加控制器
//添加子控制器
- (void)addSubControllers{
    [self addSigleControllerWith:[ETEssenceController class] andTitle:@"精华" withNormalImage:@"tabBar_essence_icon" andSelectImage:@"tabBar_essence_click_icon"];
    [self addSigleControllerWith:[ETNewPostController class] andTitle:@"新帖" withNormalImage:@"tabBar_new_icon" andSelectImage:@"tabBar_new_click_icon"];
    [self addSigleControllerWith:[ETFriendController class] andTitle:@"关注" withNormalImage:@"tabBar_friendTrends_icon" andSelectImage:@"tabBar_friendTrends_click_icon"];
    [self addSigleControllerWith:[ETMeController class] andTitle:@"我" withNormalImage:@"tabBar_me_icon" andSelectImage:@"tabBar_me_click_icon"];
    
    [self setValue:[[ETTabBar alloc] init]forKeyPath:@"tabBar"];
}

//添加单个子控制器
- (void)addSigleControllerWith:(Class)class andTitle:(NSString *)tabBarTitle withNormalImage:(NSString *)imageName andSelectImage:(NSString *)selectImageName{
    UIViewController *vc = [[class alloc] init];
    vc.tabBarItem.title = tabBarTitle;
    [vc.tabBarItem setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [vc.tabBarItem setSelectedImage:[[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self addChildViewController:[[ETNavContioller alloc] initWithRootViewController:vc]];
}

- (UIColor *)randomColor{
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
 
    return ETColor(r, g, b);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ETLog(@"%@",NSStringFromCGRect(self.view.frame));
}

@end

//
//  AppDelegate.m
//  BSBDQJItem
//
//  Created by etund on 15/7/22.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "AppDelegate.h"
#import "ETTabBarController.h"
#import "ETTopWindow.h"
#import "ETEssenceController.h"
#import "ETNewPostController.h"
#import "ETFriendController.h"
#import "ETMeController.h"
#import "ETNavContioller.h"
#import "ETTabBar.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [ETTabBarController tabBarControllerWithTitleArray:@[@"精华",@"新帖",@"关注",@"我"] andNormalImages:@[@"tabBar_essence_icon",@"tabBar_new_icon",@"tabBar_friendTrends_icon",@"tabBar_me_icon"] andSelectedImages:@[@"tabBar_essence_click_icon",@"tabBar_new_click_icon",@"tabBar_friendTrends_click_icon",@"tabBar_me_click_icon"] andClassName:@[[ETEssenceController class] ,[ETNewPostController class],[ETFriendController class],[ETMeController class]] withNavigation:[ETNavContioller class] andSelfTabBarClass:[ETTabBar class]];
    [self.window makeKeyAndVisible];
    [self configreAppearance];
    return YES;
}

#pragma mark - 统一设置属性
- (void)configreAppearance{
    
    UINavigationBar *bar = [UINavigationBar appearance];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14 weight:100];
    [bar setTitleTextAttributes:dict];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    
    NSMutableDictionary *nomalDict = [NSMutableDictionary dictionary];
    nomalDict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    nomalDict[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectDict = [NSMutableDictionary dictionary];
    selectDict[NSFontAttributeName] = nomalDict[NSFontAttributeName];
    selectDict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:nomalDict forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectDict forState:UIControlStateHighlighted];
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [ETTopWindow show];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

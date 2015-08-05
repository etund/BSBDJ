//
//  UINavigationController+ETExtension.h
//  BSBDQJItem
//
//  Created by etund on 15/7/23.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (ETExtension)
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated finish:(void(^)())finish;
@end

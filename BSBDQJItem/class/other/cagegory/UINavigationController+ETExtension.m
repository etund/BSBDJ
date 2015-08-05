//
//  UINavigationController+ETExtension.m
//  BSBDQJItem
//
//  Created by etund on 15/7/23.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "UINavigationController+ETExtension.h"

@implementation UINavigationController (ETExtension)
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated finish:(void (^)())finish{
    [self pushViewController:viewController animated:YES];
    if (finish) {
        finish();
    }
}
@end

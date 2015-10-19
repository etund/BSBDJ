//
//  ETNavContioller.m
//  BSBDQJItem
//
//  Created by etund on 15/7/22.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETNavContioller.h"

@interface ETNavContioller ()

@end

@implementation ETNavContioller



- (void)viewDidLoad{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([self checkIsExit:viewController]) {
        return;
    }
    
//    非根控制器 q
    if (self.childViewControllers.count > 0) {
//        设置文字属性
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitle:@"返回" forState:UIControlStateHighlighted];
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [backBtn setImage:[[UIImage imageNamed:@"navigationButtonReturn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [backBtn setImage:[[UIImage imageNamed:@"navigationButtonReturnClick"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
        [backBtn sizeToFit];
//        设置内容属性
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [backBtn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.view.frame = [UIScreen mainScreen].bounds;
        viewController.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [super pushViewController:viewController animated:YES];
    
}

- (BOOL)checkIsExit:(id)VC{
    for (id classObj in self.childViewControllers) {
        Class class = [classObj class];
        if ([VC isKindOfClass:class]) {
            return YES;
        }
    }
    return NO;
}

- (void)pop{
    [self popViewControllerAnimated:YES];
}

@end

//
//  ETMeController.m
//  BSBDQJItem
//
//  Created by etund on 15/7/22.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETMeController.h"

@interface ETMeController ()

@end

@implementation ETMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ETGlobalBackColor;
    [self viewDeal];
}

- (void)viewDeal{
    self.navigationItem.title = @"我的";
    
    self.navigationItem.rightBarButtonItems = @[
                                                [UIBarButtonItem itemWithNormalImage:@"mine-setting-icon" andClickImage:@"mine-setting-icon-click" andTarget:self andSelect:@selector(btnClick)],
                                                
                                                [UIBarButtonItem itemWithNormalImage:@"mine-moon-icon" andClickImage:@"mine-moon-icon-click" andTarget:self andSelect:@selector(btnClick)]
                                                ];
}

- (void)btnClick{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ETFriendController.m
//  BSBDQJItem
//
//  Created by etund on 15/7/22.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETFriendController.h"
#import "ETRecomendController.h"
#import "ETLoginRegisterController.h"

@interface ETFriendController ()

@end

@implementation ETFriendController

- (IBAction)LoginRegister:(UIButton *)sender {
    ETLoginRegisterController *logRegVC = [[ETLoginRegisterController alloc] init];
    [self presentViewController:logRegVC animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  viewDeal];
    self.view.backgroundColor = ETGlobalBackColor;
    
}


- (void)viewDeal{
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImage:@"friendsRecommentIcon" andClickImage:@"friendsRecommentIcon-click" andTarget:self andSelect:@selector(btnClick)];
}

- (void)btnClick{
    [self.navigationController pushViewController:[[ETRecomendController alloc] init] animated:YES];
}



@end

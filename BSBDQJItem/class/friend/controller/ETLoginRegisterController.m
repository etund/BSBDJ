//
//  ETLoginRegisterController.m
//  BSBDQJItem
//
//  Created by etund on 15/7/27.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETLoginRegisterController.h"

@interface ETLoginRegisterController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraints;

@end

@implementation ETLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hadAccount:(UIButton *)btn {
    [self.view endEditing:YES];
    if (self.rightConstraints.constant == 0) {//登陆界面点击的时候
        self.rightConstraints.constant = -self.view.width;
        btn.selected = YES;
    }else {
        self.rightConstraints.constant = 0;
        btn.selected = NO;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

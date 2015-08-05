//
//  ETShowDetailsController.m
//  BSBDQJItem
//
//  Created by etund on 15/8/3.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETShowDetailsController.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"

@interface ETShowDetailsController ()
@property (nonatomic, strong) UIImageView * imageView;
@end

@implementation ETShowDetailsController

- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_data.large_image]];
    CGFloat picW = self.view.width;
    CGFloat picH = picW * _data.height/_data.width;
    imageView.userInteractionEnabled = YES;
    if (picH>self.view.height) {
        imageView.frame = CGRectMake(0, 0, picW, picH);
    }else{
        imageView.center = self.view.center;
        imageView.bounds = CGRectMake(0, 0, picW, picH);
    }
    self.imageView = imageView;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.contentSize = CGSizeMake(imageView.width, imageView.height);
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tab:)]];
    [scrollView addSubview:imageView];
    [self.view addSubview:scrollView];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat btnH = 20;
    CGFloat btnW = 40;
    CGFloat btnX = self.view.width - btnW - TopicCellMargin;
    CGFloat btnY = self.view.height - btnH - TopicCellMargin;
    saveBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    [saveBtn setTitle:@"⬇️" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:saveBtn];
    
}

- (void)btnClick{
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)tab:(UITapGestureRecognizer *)tap{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error!=nil) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}
@end

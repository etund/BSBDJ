//
//  ETPublishController.m
//  BSBDQJItem
//
//  Created by etund on 15/8/5.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETPublishController.h"
#import "ETInputPublishTextView.h"

@interface ETPublishController ()
@property (nonatomic, weak) ETInputPublishTextView * textView;
@property (nonatomic, weak) UILabel * placeHolderLabel;
@property (nonatomic, weak) UIView * contentView;
@end

@implementation ETPublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self setUpContentView];
    [self viewInit];
    
    
}

#pragma mark - 视图处理
//添加内置内容框
- (void)setUpContentView{
    CGFloat viewY = 70;
    CGFloat viewX = TopicCellMargin;
    CGFloat viewW = ETScreenW - 2 * viewX;
    CGFloat viewH = ETScreenH - viewY-10;
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
    self.contentView = contentView;
    [self.view addSubview:contentView];
}

//view初始化
- (void)viewInit{
    self.automaticallyAdjustsScrollViewInsets = NO;
    ETInputPublishTextView *textView = [[ETInputPublishTextView alloc] initWithFrame:self.contentView.bounds];
//    textView.backgroundColor = [UIColor randomColor];
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.alwaysBounceVertical = YES;
    self.textView = textView;
    [self.contentView addSubview:textView];
}

//导航栏设置
- (void)setUpNav{
    self.navigationItem.title = @"发段子";
}

@end

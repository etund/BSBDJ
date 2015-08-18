//
//  ETPublishController.m
//  BSBDQJItem
//
//  Created by etund on 15/8/5.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETPublishController.h"
#import "ETInputPublishTextView.h"
#import "ETToolView.h"

@interface ETPublishController ()
@property (nonatomic, weak) ETInputPublishTextView * textView;
@property (nonatomic, weak) UILabel * placeHolderLabel;
@property (nonatomic, weak) UIView * contentView;

@property (nonatomic, weak) ETToolView * toolView;

//定义tags数组
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


- (void)keyBoardChange:(NSNotification *)note{
//    动画高度
    CGFloat transfromY = ETScreenH - [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
//    动画时间
    CGFloat time = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:time animations:^{
        self.toolView.transform = CGAffineTransformMakeTranslation(0, -transfromY);
    }];
}

//view初始化
- (void)viewInit{
    self.automaticallyAdjustsScrollViewInsets = NO;
    ETInputPublishTextView *textView = [[ETInputPublishTextView alloc] initWithFrame:self.contentView.bounds];
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.alwaysBounceVertical = YES;
    self.textView = textView;
    [self.contentView addSubview:textView];
    ETToolView *toolView = [ETToolView toolView];
    toolView.width = ETScreenW;
    toolView.x = 0;
    toolView.y = ETScreenH - self.toolView.height;
    [self.view addSubview:toolView];
    self.toolView = toolView;
}




- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    在移除键盘监听之后成为第一响应者
    [ETDefaultNotificationCenter addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self.textView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    在移除键盘监听之前注销第一响应者
    [self.textView resignFirstResponder];
    [ETDefaultNotificationCenter removeObserver:self];
}

//导航栏设置
- (void)setUpNav{
    self.navigationItem.title = @"发段子";
//    设置导航栏左上角视图
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancleClick)];
    
}

- (void)cancleClick{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
}

@end

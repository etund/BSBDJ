//
//  ETTabBar.m
//  BSBDQJItem
//
//  Created by etund on 15/7/23.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETTabBar.h"

#import "ETButton.h"
#import "ETPublishController.h"

#import "ETNavContioller.h"

#define ETDivided self.width / 5.0

@interface ETTabBar()
@property (nonatomic,strong) UIButton* centerBtn;
@property (nonatomic,assign) NSInteger flag;

@property (nonatomic, assign) NSInteger  index;
@property (nonatomic, strong) UIView * view;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) dispatch_source_t timer_;
@property (nonatomic, strong) UIButton * cancleBtn;


@property (nonatomic, strong) UIDynamicAnimator * animator;
@property (nonatomic, strong) UIGravityBehavior * gravity;
@property (nonatomic, strong) UICollisionBehavior * collision;

@property (nonatomic, strong) NSMutableArray * viewArr;

@property (nonatomic, assign,getter=isAddedFlag) BOOL  addedFlag;

@end

@implementation ETTabBar

#pragma mark - 懒加载
- (UIGravityBehavior *)gravity{
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc] init];
    }
    return _gravity;
}

- (UICollisionBehavior *)collision{
    if (!_collision) {
        _collision = [[UICollisionBehavior alloc] init];
        self.collision.translatesReferenceBoundsIntoBoundary = YES;
        
    }
    return _collision;
}

- (UIDynamicAnimator *)animator{
    if (!   _animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

#pragma mark - 重写系统方法
- (void)layoutSubviews{
    
    [super layoutSubviews];
//    static BOOL added = YES;
    int index = 0;
    CGFloat width = ETDivided;
    for (UIButton *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            view.frame = CGRectMake(index * width, 0, width, self.height);
            index++;
            index = index!=2?index:index+1;
            if (!self.isAddedFlag) {
                [view addTarget:self action:@selector(toTop) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    self.addedFlag = YES;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [centerBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [centerBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        centerBtn.layer.anchorPoint = CGPointMake(0.5, 0);
        centerBtn.bounds = CGRectMake(0, 0, ETDivided, self.height);
        [centerBtn addTarget:self action:@selector(animationWay) forControlEvents:UIControlEventTouchUpInside];
        self.centerBtn = centerBtn;
        [self addSubview:centerBtn];
    });
    
    do {
        self.centerBtn.center = CGPointMake(self.center.x, 0);
        self.flag++;
    } while (self.flag<2);
    
}

#pragma mark - tabbar按钮功能实现
- (void)toTop{
//    在通知中心注册通知
    [ETDefaultNotificationCenter postNotificationName:ETTabBarDidSelectNotification object:nil];
}

#pragma mark - 添加按钮功能实现
//动画效果
- (void)animationWay{
//    第一种方式
    [self timerBegin];
}

- (void)timerBegin{
    self.index = 0;
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ETScreenW, ETScreenH)];
//    view.backgroundColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:0.5];
    view.backgroundColor = ETGlobalBackColorAlpha(0.5);
    self.view = view;
//    添加数据模型
    CGFloat btnW = 72;
    CGFloat margin = (ETScreenW - 3*btnW)/4;
    CGFloat btnH = 72 + 30;
    for (int i = 0; i < images.count; i++) {
        ETButton  *btn = [ETButton buttonWithType:UIButtonTypeCustom];
        CGFloat col = i % 3;
        CGFloat row = i / 3;
        btn.frame = CGRectMake(margin + col * (btnW + margin),200 + row * btnH , btnW, btnH);
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.transform = CGAffineTransformMakeTranslation(0, -ETScreenH);
        [view addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    CGFloat sloganX = self.view.center.x;
    CGFloat sloganY = 150;
    UIImageView *sloganView = [[UIImageView alloc] init];
    sloganView.bounds = CGRectMake(0, 0, 202, 20);
    sloganView.center = CGPointMake(sloganX, sloganY);
    sloganView.image = [UIImage imageNamed:@"app_slogan"];
    sloganView.transform = CGAffineTransformMakeTranslation(0, -ETScreenH);
    [view addSubview:sloganView];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setBackgroundImage:[UIImage imageNamed:@"shareButtonCancel"] forState:UIControlStateNormal];
    [cancleBtn setBackgroundImage:[UIImage imageNamed:@"shareButtonCancelClick"] forState:UIControlStateHighlighted];
    cancleBtn.backgroundColor = ETGlobalBackColor;
    cancleBtn.bounds = CGRectMake(0, 0, 289, 40);
    cancleBtn.center = CGPointMake(self.view.center.x, self.view.height - 100);
    cancleBtn.enabled = NO;
    [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancleBtn];
    self.cancleBtn = cancleBtn;
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
   self.timer =  [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(centerBtnClick) userInfo:nil repeats:YES];
}

//中心按钮点击
- (void)centerBtnClick{
/** 方法一 用animation **/
    ETButton *btn = self.view.subviews[_index];
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        btn.transform = CGAffineTransformIdentity;
    } completion:nil];
    if (_index >= _view.subviews.count-2) {
        [self.timer invalidate];
        self.cancleBtn.enabled = YES;
    }else{
        _index++;
    }
}



//监听按钮点击
- (void)btnClick:(UIButton *)btn{
    [UIView animateWithDuration:1.0 animations:^{
        [self viewDismiss];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            UINavigationController *nav = [[ETNavContioller alloc] initWithRootViewController:[[ETPublishController alloc] init]];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
        }];
    }];
}

//转场动画
- (void)cancleBtnClick{
//    [self.view layoutIfNeeded]
//    for (UIView *view in self.view.subviews) {
//        view.userInteractionEnabled = NO;
//    }
    [self.view.subviews makeObjectsPerformSelector:@selector(setUserInteractionEnabled:) withObject:@(NO)];
    self.viewArr = [NSMutableArray arrayWithArray:self.view.subviews];
    self.index = 0;
    self.timer_ = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)/4.0);
    //    定义时间间隔
    uint64_t interver = (uint64_t)(1.0 * NSEC_PER_SEC);
    //    设置开始时间和时间间隔
    dispatch_source_set_timer(self.timer_, start,interver, 0);
    dispatch_source_set_event_handler(self.timer_, ^{
        [self drop];
    });
    dispatch_resume(self.timer_);
    
    [self.collision addItem:self.view.subviews.lastObject];
    [self.animator addBehavior:self.gravity];
    [self.animator addBehavior:self.collision];
    
}

- (void)viewDismiss{
    CATransition *transition = [[CATransition alloc] init];
    transition.type = @"cute";
    [self.view.layer addAnimation:transition forKey:@""];
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:nil];
    [self.view removeFromSuperview];
    self.view = nil;
    self.collision = nil;
    self.gravity = nil;
    [self.animator removeAllBehaviors];
    self.animator = nil;
    return;
}

//取消时跌落
- (void)drop{
    UIView *view = self.viewArr[_index];
    if ([view isKindOfClass:[UIButton class]]&&_index!=self.viewArr.count-1) {
        
        view.height = view.width;
        view.layer.cornerRadius = view.width/2.0;
        [(UIButton *)view setTitle:@"" forState:UIControlStateNormal];
        [view layoutSubviews];
    }
    if (_index >= self.viewArr.count-1) {
        dispatch_cancel(self.timer_);
        [UIView animateWithDuration:1.0 animations:^{
            ((UIView *)self.viewArr.lastObject).alpha = 0.01;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0 animations:^{
                ((UIView *)self.viewArr.lastObject).hidden = YES;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:1.0 animations:^{
                    [self viewDismiss];
                }];
            }];
        }];
    }else{
        _index++;
    }
    
    [self.gravity addItem:view];
    [self.collision addItem:view];
    [UIView animateWithDuration:1.0 animations:^{
        view.alpha = 0.01;
    } completion:^(BOOL finished) {
        view.hidden = YES;
        [self.collision removeItem:view];
        [view removeFromSuperview];
    }];
    
}


@end

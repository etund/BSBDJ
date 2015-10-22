//
//  ETEssenceController.m
//  BSBDQJItem
//
//  Created by etund on 15/7/27.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETEssenceController.h"
#import "ETRecommendController.h"
#import "ETTopicCell.h"
#import "ETTopicController.h"

#import "ETIndecatorView.h"

#define ETTitleBtnWith (self.titleView.width/self.childViewControllers.count)


static NSString * const topicID = @"tipic";

@interface ETEssenceController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * titleView;
@property (nonatomic, strong) ETIndecatorView * indecatorView;
@property (nonatomic, strong) UIScrollView * baseScrollView;

@property (nonatomic, strong) UIDynamicAnimator * animator;

@end

@implementation ETEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _dataType = @"list";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = ETGlobalBackColor;
    self.view.frame = [UIScreen mainScreen].bounds;
    [self viewDeal];
//    [self.tableView ] 
}

- (NSString *)dataType{
    return @"list";
}


#pragma mark - 视图处理
- (void)viewDeal{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImage:@"MainTagSubIcon" andClickImage:@"MainTagSubIconClick" andTarget:self andSelect:@selector(btnClick:)];
    self.view.frame = [UIScreen mainScreen].bounds;
    //    添加TableView
    [self addChildViewControllers];
//    添加底层的ScrollView
    [self addBaseScrollView];
//   添加标题栏
    [self addTitleView];
//    添加标题按钮
    [self addtitleBtns];
    [self loadFristView];
}

- (void)addChildViewControllers{
    ETTopicController *allVC = [[ETTopicController alloc] init];
    allVC.title = @"全部";
    allVC.type = ETTopicControllerTypeAll;
    
    ETTopicController *wordVC = [[ETTopicController  alloc] init];
    wordVC.title = @"段子";
    wordVC.type = ETTopicControllerTypeWord;
    
    ETTopicController *picVC = [[ETTopicController alloc] init];
    picVC.title = @"图片";
    picVC.type = ETTopicControllerTypePic;
    
    ETTopicController *voiceVC = [[ETTopicController alloc] init];
    voiceVC.title = @"声音";
    voiceVC.type = ETTopicControllerTypeVoice;
    
    ETTopicController *videoVC = [[ETTopicController alloc] init];
    videoVC.title = @"视频";
    videoVC.type = ETTopicControllerTypeVideo;
    
    [self addChildViewController:allVC];
    [self addChildViewController:wordVC];
    [self addChildViewController:picVC];
    [self addChildViewController:voiceVC];
    [self addChildViewController:videoVC];
//    [self.childViewControllers makeObjectsPerformSelector:@selector(setDataType:) withObject:self.dataType];
}
- (void)loadFristView{
    NSInteger index = 0;
    CGRect frame = CGRectMake(index * self.view.width, 0, self.view.width, self.view.height);
    ETTopicController *vc = self.childViewControllers[index];
    vc.view.frame = frame;
    [self.baseScrollView addSubview:vc.view];
}

//添加按钮
- (void)addtitleBtns{
    CGFloat btnW = self.titleView.width / self.childViewControllers.count;
    CGFloat btnH = self.titleView.height;
    for (int i = 0; i < self.childViewControllers.count; i++) {
        NSString *title = [self.childViewControllers[i] title];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * btnW, 0, btnW, btnH)];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:title forState:UIControlStateNormal];
        if (i == 0) {
            CGFloat height = 2;
            ETIndecatorView *indecatorView = [[ETIndecatorView alloc] initWithFrame:CGRectMake(0,self.titleView.height - height , btn.width, height)];
            indecatorView.center = CGPointMake(btn.center.x, indecatorView.center.y);
            indecatorView.backgroundColor = [UIColor redColor];
            [btn layoutIfNeeded];
            indecatorView.width = btn.titleLabel.width;
            indecatorView.center =  CGPointMake(btn.center.x, indecatorView.center.y);
            self.indecatorView = indecatorView;
            [self.titleView addSubview:indecatorView];
        }
        [self.titleView addSubview:btn];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

//添加标题
- (void)addTitleView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 66, self.view.width, 30)];
    titleView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    [self.view addSubview:titleView];
    self.titleView = titleView;
}

//添加底层ScrollView
- (void)addBaseScrollView{
    UIScrollView *baseScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    baseScrollView.contentSize = CGSizeMake(baseScrollView.width * self.childViewControllers.count, 0);
    baseScrollView.backgroundColor = ETGlobalBackColor;
    baseScrollView.pagingEnabled = YES;
    baseScrollView.delegate = self;
    baseScrollView.bounces = NO;
    self.baseScrollView = baseScrollView;
    [self.view insertSubview:baseScrollView atIndex:0];
}



#pragma mark - 事件接收
//导航栏左上角点击跳转到推荐关注用户
- (void)btnClick:(UIButton *)btn{
    [self.navigationController pushViewController:[[ETRecommendController alloc] init] animated:YES];
}

//标题按钮点击
- (void)titleBtnClick:(UIButton *)btn{
    self.indecatorView.width = btn.titleLabel.width;
    NSInteger index = [self.titleView.subviews indexOfObject:btn] - 1;
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index * self.view.width, 0, self.view.width, self.view.height);
    [self.baseScrollView addSubview:vc.view];
    [self.baseScrollView setContentOffset:CGPointMake(index * self.view.width, 0) animated:YES];
}



#pragma mark - scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    获取比例
    CGFloat scale = self.baseScrollView.contentOffset.x / self.baseScrollView.frame.size.width;
    int index = scale;
//    self.indecatorView.width = btn.titleLabel.width;
    UIButton *btn = (UIButton *)self.titleView.subviews[index + 1];
    self.indecatorView.width = btn.titleLabel.width;
    self.indecatorView.scale = scale;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / self.view.width;
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index * self.view.width, 0, self.view.width, self.view.height);
    [self.baseScrollView addSubview:vc.view];
}

- (void)dealloc{
    
}


@end

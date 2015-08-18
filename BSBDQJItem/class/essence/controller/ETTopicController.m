//
//  ETTopicController.m
//  BSBDQJItem
//
//  Created by etund on 15/7/27.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETTopicController.h"
#import "ETTopicCell.h"
#import "ETTopicData.h"
#import "ETReplyController.h"

#import "MJExtension.h"
#import "AFNetworking.h"
#import "MJRefresh.h"


static NSString * const allID = @"all";
@interface ETTopicController ()
@property (nonatomic, strong) NSString * maxtime;
@property (nonatomic, assign) NSInteger  page;
@property (nonatomic, strong) NSMutableArray * topicDatas;

@property (nonatomic, strong)  AFHTTPSessionManager* manager;

@property (nonatomic, assign) NSInteger  lasetSelectIndex;
@end

@implementation ETTopicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self viewInit];
    [self addRefreshView];
    [self.tableView.header beginRefreshing];
}

#pragma mark - 初始化
- (void)viewInit{
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(100, 0, 50, 0);
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ETTopicCell class]) bundle:nil] forCellReuseIdentifier:allID];
    self.tableView.backgroundColor = ETGlobalBackColor;
    self.tableView.contentInset = UIEdgeInsetsMake(100, 0, 50, 0);
}
#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 视图处理
- (void)addRefreshView{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    自动改变透明度
    self.tableView.header.autoChangeAlpha = YES;
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.footer.hidden = YES;
}

#pragma mark - 数据处理
- (void)checkFinish{
}

- (void)loadNewData{
    [self.tableView.footer endRefreshing];
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    prams[@"a"] = self.dataType;// @"list";
    prams[@"c"] = @"data";
    prams[@"type"] = @(self.type);
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:prams success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {
        self.topicDatas = [ETTopicData objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.maxtime = responseObject[@"maxtime"];
        if (self.type == ETTopicControllerTypeVideo) {
            [responseObject writeToFile:@"Users/etund/desktop/data_1.plist" atomically:YES];
        }
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"加载失败");
        [self.tableView.header endRefreshing];
    }];
}
- (void)loadMoreData{
    [self.tableView.header endRefreshing];
    
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    prams[@"a"] = @"list";
    prams[@"c"] = @"data";
    NSInteger page = self.page++;
    prams[@"page"] = @(page);
    prams[@"type"] = @(self.type);
    if(self.maxtime!=nil) prams[@"maxtime"] = self.maxtime;
    ETLog(@"%@",self.maxtime);
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:prams success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {
        [self.topicDatas addObjectsFromArray:[ETTopicData objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        if(self.type == ETTopicControllerTypeVideo){
            [responseObject writeToFile:@"Users/etund/desktop/data_1.plist" atomically:YES];
        }
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"加载失败");
        [self.tableView.footer endRefreshing];
    }];
}

#pragma mark - UITableView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableView.footer.hidden = !self.topicDatas.count;
    return self.topicDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ETTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:allID];
    ETTopicData *data = self.topicDatas[indexPath.row];
    cell.data = data;
    [cell sizeToFit];
    return cell;
}
#pragma mark - UITableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ETTopicData *data = self.topicDatas[indexPath.row];
    return data.nomalCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ETReplyController *replyController = [[ETReplyController alloc] init];
    replyController.topPicData = self.topicDatas[indexPath.row];
    
    [self.navigationController pushViewController:replyController animated:YES];
}

#pragma mark - 通知的接收与移除
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [ETDefaultNotificationCenter addObserver:self selector:@selector(tabBarClick) name:ETTabBarDidSelectNotification object:nil];
//    self.tableView.header.autoChangeAlpha
}

- (void)tabBarClick{
    ETLog(@"--------------");
    if (self.lasetSelectIndex == self.tabBarController.selectedIndex&&self.view.isShowingOnCurrentWindow) {
        [self.tableView.header beginRefreshing];
    }
    self.lasetSelectIndex = self.tabBarController.selectedIndex;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [ETDefaultNotificationCenter removeObserver:self];
}


@end

//
//  ETRecomendController.m
//  BSBDQJItem
//
//  Created by etund on 15/7/24.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETRecomendController.h"
#import "ETCategoryCell.h"
#import "ETCategoryData.h"
#import "ETUserCell.h"
#import "ETRecomentUserData.h"

#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "AFNetworking.h"



@interface ETRecomendController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *categoryView;
@property (nonatomic, strong) NSArray *categoryDatas;

@property (nonatomic, strong) UITableView * userView;
@property (nonatomic, strong) AFHTTPSessionManager * manager;

@property (nonatomic, strong) NSDictionary * dict;
@end

static NSString * const catagoryID = @"catagory";
static NSString * const userID = @"user";

@implementation ETRecomendController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ETGlobalBackColor;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MM.jpg"]];
    imageView.frame = self.view.frame;
    self.view = imageView;
    self.view.userInteractionEnabled = YES;
//    视图处理
    [self viewDeal];
//    注册cell
    [self.categoryView registerNib:[UINib nibWithNibName:NSStringFromClass([ETCategoryCell  class]) bundle:nil] forCellReuseIdentifier:catagoryID];
    [self.userView registerNib:[UINib nibWithNibName:NSStringFromClass([ETUserCell class]) bundle:nil] forCellReuseIdentifier:userID];
//    数据处理
    [self dataHandle];
}

#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}


#pragma mark - 数据处理
- (void)dataHandle{
    [self loadLeftViewData];
}

- (void)checkIsFinish{
    ETCategoryData *data = self.categoryDatas[self.categoryView.indexPathForSelectedRow.row];
    if (data.userDatas.count==data.total) {
        [self.userView.footer noticeNoMoreData];
    }else{
        [self.userView.footer endRefreshing];
    }
}

- (void)loadLeftViewData{
//    不让用户交互
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
//    发请求
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"category";
    dict[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
//        指示器消失
        [SVProgressHUD dismiss];
//      数据转模型
        self.categoryDatas = [ETCategoryData objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryView reloadData];
        [self.categoryView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self tableView:self.categoryView didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
    }];
}


//加载最新的首页数据
- (void)loadNewData{
    ETCategoryData *cData = self.categoryDatas[self.categoryView.indexPathForSelectedRow.row];
    cData.currentPage = 1;
    //    这是为了在点击另外一个cell的时候，table没有收到数据还保持着上次的数据
    [self.userView reloadData];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"a"] = @"list";
    dict[@"c"] = @"subscribe";
    dict[@"category_id"] = @(cData.id);
    dict[@"page"] = @(cData.currentPage);
    self.dict = dict;
    [_manager GET:@"http://api.budejie.com/api/api_open.php" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *userArr = [ETRecomentUserData objectArrayWithKeyValuesArray:responseObject[@"list"]];
        cData.userDatas = [NSMutableArray arrayWithArray:userArr];
//        由于总数是一样的，所以存一次就好
        if (cData.total == 0) {
            cData.total = [responseObject[@"total"] integerValue];
        }
//   当前数据返回之前点击其他页面要把数据存起来但不reloadData,其实判断不判断都会存储，只是不用多次调用reloadData方法而已。
        if (self.dict!=dict) return ;
        [self.userView reloadData];
        [self.userView.header endRefreshing];
        if (cData.userDatas.count==cData.total) {
            [self.userView.footer noticeNoMoreData];
        }
        [self checkIsFinish];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

//加载更多数据
- (void)loadMoreData{
    ETCategoryData *cData = self.categoryDatas[self.categoryView.indexPathForSelectedRow.row];
    //    这是为了在点击另外一个cell的时候，table没有收到数据还保持着上次的数据
    [self.userView reloadData];
    //        这里的需求是为了让数据存储起来，不然用户在花流量。
    //        如果已经在缓存里面就不用去网络下载了
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    dict[@"a"] = @"list";
    dict[@"c"] = @"subscribe";
    dict[@"category_id"] = @(cData.id);
    dict[@"page"] = @(++cData.currentPage);
    self.dict = dict;
    [_manager GET:@"http://api.budejie.com/api/api_open.php" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *userArr = [ETRecomentUserData objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [cData.userDatas addObjectsFromArray:userArr];
//        当前数据返回之前点击其他页面要把数据存起来但不reloadData,其实判断不判断都会存储，只是不用多次调用reloadData方法而已。
        if (self.dict!=dict) return ;
        [self.userView reloadData];
        [self checkIsFinish];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

#pragma  mark - 视图处理
- (void)viewDeal{
    self.navigationItem.title = @"推荐关注";
    [self addCategoryView];
    [self addUserView];
    [self addRefreshView];
}

- (void)addCategoryView{
//    添加分类视图
    UITableView *categoryView = [[UITableView alloc] init];
    categoryView.separatorStyle = UITableViewCellSeparatorStyleNone;
    categoryView.contentInset = UIEdgeInsetsMake(6, 0, 0, 0);
    categoryView.backgroundColor = [UIColor clearColor];
    categoryView.frame = CGRectMake(0, 0, self.view.width/4, self.view.height);
    categoryView.delegate = self;
    categoryView.dataSource = self;
    categoryView.showsHorizontalScrollIndicator = NO;
    categoryView.showsVerticalScrollIndicator = NO;
    self.categoryView = categoryView;
    [self.view addSubview:categoryView];
}


- (void)addUserView{
    UITableView *userView = [[UITableView alloc] init];
    userView.separatorStyle = UITableViewCellSeparatorStyleNone;
    userView.frame = CGRectMake(self.categoryView.width, 0, self.view.width - self.categoryView.width, self.view.height);
    userView.backgroundColor = [UIColor clearColor];
    userView.contentInset = UIEdgeInsetsMake(70, 0, 0, 0);
    userView.showsVerticalScrollIndicator = YES;
    userView.showsHorizontalScrollIndicator = NO;
    userView.dataSource = self;
    userView.delegate = self;
    
    self.userView = userView;
    [self.view addSubview:userView];
}

- (void)addRefreshView{
    self.userView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.userView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.userView.footer.hidden = YES;
}

#pragma mark - UITableView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.categoryView){
        return self.categoryDatas.count;
    }else if (tableView == self.userView){
        ETCategoryData *cData = self.categoryDatas[self.categoryView.indexPathForSelectedRow.row];
        self.userView.footer.hidden = (cData.userDatas.count == 0);
        return cData.userDatas.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryView) {
        ETCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:catagoryID];
        ETCategoryData *data = self.categoryDatas[indexPath.row];
        cell.data = data;
        return cell;
    }else if (tableView == self.userView){
        ETUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userID];
        ETCategoryData *cData = self.categoryDatas[self.categoryView.indexPathForSelectedRow.row];
        ETRecomentUserData *data = cData.userDatas[indexPath.row];
        cell.data = data;
        return cell;
    }
    return nil;
}

#pragma mark - UITableView代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.userView.header endRefreshing];
    [self.userView.footer endRefreshing];
    if (tableView == self.categoryView) {
    ETCategoryData *cData = self.categoryDatas[indexPath.row];
//    这是为了在点击另外一个cell的时候，table没有                            收到数据还保持着上次的数据
//    这里的需求是为了让数据存储起来，不然用户在花流量。
        if (cData.userDatas.count) {
            [self.userView reloadData];
        }else{
            [self.userView reloadData];
            [self.userView.header beginRefreshing];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.userView){
        return 80;
    }
    return 44;
}

@end

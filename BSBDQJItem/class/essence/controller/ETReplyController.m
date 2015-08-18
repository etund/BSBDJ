//
//  ETReplyController.m
//  BSBDQJItem
//
//  Created by etund on 15/8/5.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETReplyController.h"

#import "ETCommentCell.h"
#import "ETHeaderView.h"

#import "AFNetworking.h"
#import "MJRefresh.h"
#import "MJExtension.h"

#import <objc/runtime.h>

static NSString * const ID = @"reply";
static NSString * const commentTopicID = @"commentTopicID";


@interface ETReplyController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *commentView;

@property (nonatomic, strong) AFHTTPSessionManager * manager;

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, assign) NSInteger  page;

//数据源模型
@property (nonatomic, strong) NSMutableArray * hotComents;
@property (nonatomic, strong) NSMutableArray * nomalComents;
@property (nonatomic, strong) NSMutableArray * comentArr;

@end

@implementation ETReplyController

- (void)viewDidLoad {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ETCommentCell class]) bundle:nil] forCellReuseIdentifier:ID];
    [self.tableView registerClass:[ETHeaderView class] forHeaderFooterViewReuseIdentifier:commentTopicID];
    [self viewInit];
    [self addSubView];
    [self.tableView.header beginRefreshing];
}

#pragma  mark - 懒加载；
- (NSMutableArray *)comentArr{
    if (!_comentArr) {
        _comentArr = [NSMutableArray array];
    }
    return _comentArr;
}

- (NSMutableArray *)hotComents{
    if (!_hotComents) {
        _hotComents = [NSMutableArray array];
    }
    return _hotComents;
}

- (NSMutableArray *)nomalComents{
    if (!_nomalComents) {
        _nomalComents = [NSMutableArray array];
    }
    return _nomalComents;
}

- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame ];// style:UITableViewStyleGrouped];
        tableView.backgroundColor = ETGlobalBackColor;
        tableView.contentInset = UIEdgeInsetsMake(64 + TopicCellMargin, 0, self.commentView.height + TopicCellMargin, 0);
        tableView.delegate = self;
        tableView.dataSource = self;
        
        [self.view insertSubview:tableView atIndex:0];
        _tableView = tableView;
    }
    return _tableView;
}

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 视图处理
- (void)viewInit{
//    self.tableView.separatorInset
    self.view.backgroundColor = ETGlobalBackColor;
    self.navigationController.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNormalImage:@"comment_nav_item_share_icon" andClickImage:@"comment_nav_item_share_icon_click" andTarget:nil andSelect:nil];
}

- (void)addSubView{
//    添加tableView刷新控件
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.header.autoChangeAlpha = YES;
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.footer.hidden = YES;
//    添加tableView头部控件
    ETTopicCell *topicCell = [ETTopicCell viewFromXib];
    topicCell.data = self.topPicData;
    topicCell.size = CGSizeMake(ETScreenW - 2 * TopicCellMargin, _topPicData.nomalCellHeight);
    topicCell.x = TopicCellMargin;
    topicCell.y = 0;
    topicCell.backgroundColor = [UIColor whiteColor];
    [self.tableView setTableHeaderView:topicCell];
//    分组控件
}

#pragma mark - 数据处理
//加载新数据
- (void)loadNewData{
//    结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    prams[@"a"] = @"dataList";
    prams[@"c"] = @"comment";
    prams[@"data_id"] = _topPicData.ID;
    prams[@"hot"] = @"1";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:prams success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {
        self.nomalComents = [ETReplyData objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.hotComents = [ETReplyData objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        if (self.hotComents.count>0) [self.comentArr addObject:self.hotComents];
        if (self.nomalComents.count>0) [self.comentArr addObject:self.nomalComents];
        [self.tableView reloadData];
        [self checkDataLoaded:[responseObject[@"total"] integerValue]];
        [self.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.header endRefreshing];
        
    }];
    
}

- (void)loadMoreData{
//    结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSInteger page = self.page + 1;
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topPicData.ID;
    params[@"page"] = @(page);
    ETReplyData *data = self.nomalComents.lastObject;
    params[@"lastcid"] = @(data.ID);
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {
        [self.nomalComents addObjectsFromArray:[ETReplyData objectArrayWithKeyValuesArray:responseObject[@"data"]]];
        [self.tableView reloadData];
        NSInteger totalCount = [responseObject[@"total"] integerValue];
        [self checkDataLoaded:totalCount];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.footer endRefreshing];
    }];
}

- (void)checkDataLoaded:(NSInteger)totalCount{
    if (self.nomalComents.count>= totalCount) {
        [self.tableView.footer noticeNoMoreData];
    }else{
        [self.tableView.footer endRefreshing];
    }
}

#pragma mark - UITabeleViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    self.tableView.footer.hidden = self.comentArr;
    return self.comentArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [(NSMutableArray *)self.comentArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ETCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.data = self.comentArr[indexPath.section][indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ETReplyData *data = self.comentArr[indexPath.section][indexPath.row];
    return data.cellHeght;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ETHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:commentTopicID];
    headerView.title = self.comentArr[section]==self.nomalComents?@">最新评论":@">最热评论";
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}



#pragma  mark - 事件接收
/**
 userInfo = {
 UIKeyboardAnimationCurveUserInfoKey = 7;
 UIKeyboardAnimationDurationUserInfoKey = "0.25";
 UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 216}}";
 UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 676}";
 UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 460}";
 UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 568}, {320, 216}}";
 UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 352}, {320, 216}}";
 }}
 */
- (void)keyBoardChange:(NSNotification *)note{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat transY = ETScreenH - [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    [UIView animateWithDuration:duration animations:^{
        self.commentView.transform = CGAffineTransformMakeTranslation(0, -transY);
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - 键盘监听添加与移除
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [ETDefaultNotificationCenter addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.view resignFirstResponder];
    [ETDefaultNotificationCenter removeObserver:self];
}

#pragma mark - 请求的移除
- (void)dealloc{
//    在控制器死亡的时候把请求全部取消
    [self.manager invalidateSessionCancelingTasks:YES];
}

@end

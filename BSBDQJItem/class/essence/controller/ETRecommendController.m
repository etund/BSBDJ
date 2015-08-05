//
//  ETRecommendController.m
//  BSBDQJItem
//
//  Created by etund on 15/7/23.
//  Copyright (c) 2015年 etund. All rights reserved.
//

#import "ETRecommendController.h"
#import "ETRecommendTagCell.h"
#import "ETRecommendTagData.h"

#import "AFHTTPSessionManager.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"

static NSString * tagCellId = @"tagCell";
@interface ETRecommendController ()
@property (nonatomic, strong) NSMutableArray * tagDatas;
@end

@implementation ETRecommendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ETGlobalBackColor;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ETRecommendTagCell  class]) bundle:nil] forCellReuseIdentifier:tagCellId];
    [self dataHandle];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MM.jpg"]];
}

#pragma mark - 数据处理
- (void)dataHandle{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    prams[@"a"] = @"tag_recommend";
    prams[@"action"] = @"sub";
    prams[@"c"] = @"topic";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:prams success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {
        //ETLog(@"%@-------------",responseObject);
        //[responseObject writeToFile:@"/Users/etund/Desktop/data.plist" atomically:YES];
        self.tagDatas = [ETRecommendTagData objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


#pragma mark - Table view 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tagDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ETRecommendTagCell  *cell = [tableView dequeueReusableCellWithIdentifier:tagCellId];
    cell.data = self.tagDatas[indexPath.row];
    return cell;
}

#pragma mark - Table View 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

@end

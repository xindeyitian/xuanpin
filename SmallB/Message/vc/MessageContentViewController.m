//
//  MessageContentViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/24.
//

#import "MessageContentViewController.h"
#import "MessageOrderTableViewCell.h"
#import "MessageSystemTableViewCell.h"
#import "MessageDetailViewController.h"
#import "MagicBoxMessageListModel.h"

@interface MessageContentViewController ()

@property (nonatomic , assign)NSInteger pageNo;
@property (nonatomic , copy)NSString *msgId;
@end

@implementation MessageContentViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"self.msgId---%@",self.msgId);
    if (self.msgId) {
        [self getDetail];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emptyDataView.noDataImageView.image = IMAGE_NAMED(@"no_data_list");
    self.emptyDataView.noDataTitleLabel.text = @"暂无数据哦～";
    
    self.tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - KNavBarHeight - 44);
    [self.tableView registerClass:[MessageOrderTableViewCell class] forCellReuseIdentifier:[MessageOrderTableViewCell description]];
    [self.tableView registerClass:[MessageSystemTableViewCell class] forCellReuseIdentifier:[MessageSystemTableViewCell description]];
    self.needPullUpRefresh = self.needPullDownRefresh = YES;
    [self loadNewData];
}

- (void)loadNewData{
    self.pageNo = 1;
    [self getMessageList];
}

- (void)loadMoreData{
    self.pageNo ++;
    [self getMessageList];
}

- (void)getDetail{
    [self startLoadingHUD];
    [THHttpManager POST:[NSString stringWithFormat:@"msg_log/queryUserMsgDetail/%@",self.msgId] parameters:@{} dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            MagicBoxMessageListModel *detailModel = [MagicBoxMessageListModel mj_objectWithKeyValues:data];
            for (MagicBoxMessageListModel *model in self.dataArray) {
                if ([model.msgId isEqualToString:self.msgId]) {
                    NSInteger index = [self.dataArray indexOfObject:model];
                    [self.dataArray replaceObjectAtIndex:index withObject:detailModel];
                    break;
                }
            }
            [self.tableView reloadData];
        }
    }];
}

-(void)getMessageList{
    if (!self.tableView.mj_header.isRefreshing && !self.tableView.mj_footer.isRefreshing) {
        [self startLoadingHUD];
    }
    self.emptyDataView.hidden = YES;
    [THHttpManager POST:@"msg_log/queryUserPushLog" parameters:@{@"appCode":@"xlxp",@"pageNo":[NSString stringWithFormat:@"%ld",self.pageNo],@"pageSize":@"10",@"type":self.index == 0 ? @"301": @"302"} dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            MagicBoxMessageModel *model = [MagicBoxMessageModel mj_objectWithKeyValues:data];
            if (self.pageNo == 1) {
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:model.data];
            }else{
                [self.dataArray addObjectsFromArray:model.data];
            }
            if (self.pageNo == 1 && self.dataArray.count == 0) {
                self.emptyDataView.hidden = NO;
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            if (self.pageNo > 1 && model.data.count == 0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MessageOrderTableViewCell description]];
    cell.autoCorner = YES;
    [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
    cell.separatorLineView.hidden = YES;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageDetailViewController *vc = [[MessageDetailViewController alloc]init];
    vc.index = self.index;
    MagicBoxMessageListModel *model = self.dataArray[indexPath.row];
    self.msgId = model.msgId;
    vc.msgID = model.msgId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SetIOS13;
    [navigationController setNavigationBarHidden:NO animated:YES];
}

- (UIView *)listView {
    return self.view;
}

@end

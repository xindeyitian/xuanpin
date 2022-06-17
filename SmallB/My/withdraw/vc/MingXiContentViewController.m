//
//  MingXiContentViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/25.
//

#import "MingXiContentViewController.h"
#import "MingXiTableViewCell.h"
#import "WithdrawRecordModel.h"

@interface MingXiContentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic , assign)NSInteger page;

@end

@implementation MingXiContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emptyDataView.noDataImageView.image = IMAGE_NAMED(@"no_data_list");
    self.emptyDataView.noDataTitleLabel.text = @"暂无数据哦～";
    self.view.backgroundColor = KBGColor;
    self.tableView.backgroundColor = KBGColor;
    [self.tableView registerClass:[MingXiTableViewCell class] forCellReuseIdentifier:[MingXiTableViewCell description]];
    
    self.needPullUpRefresh = self.needPullDownRefresh = YES;
    [self loadNewData];
}

- (void)setNeedReload:(BOOL)needReload{
    _needReload = needReload;
    [self loadNewData];
}

- (void)loadNewData{
    self.page = 1;
    [self getRecords];
}

- (void)loadMoreData{
    self.page ++ ;
    [self getRecords];
}

- (void)getRecords{
    //dealSign 0待审核 1已处理 9已提现 -1提现失败
    if (!self.tableView.mj_header.isRefreshing && !self.tableView.mj_footer.isRefreshing) {
        [self startLoadingHUD];
    }
    NSString *start = @"";
    if (self.startTime.length) {
        start = [NSString stringWithFormat:@"%@ 00:00:00",self.startTime];
    }
    NSString *end = @"";
    if (self.endTime.length) {
        end = [NSString stringWithFormat:@"%@ 23:59:59",self.endTime];
    }
    
    NSDictionary *dica = @{@"startTime":start,
                           @"endTime":end,
                           @"moneyAccount":[NSString stringWithFormat:@"%ld",self.typeIndex],
                           @"pageNum":[NSString stringWithFormat:@"%ld",self.page],
                           @"pageSize":@"10",
    };
    NSString *url = @"user/shopWithdraw/returnsDetail";
    self.emptyDataView.hidden = YES;
    [THHttpManager POST:url parameters:dica dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            WithdrawRecordModel *model = [WithdrawRecordModel mj_objectWithKeyValues:data];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:model.records];
                self.emptyDataView.hidden = !(self.dataArray.count == 0);
            }else{
                [self.dataArray addObjectsFromArray:model.records];
                if (model.records.count == 0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [self.tableView reloadData];
        }
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 44, ScreenWidth, ScreenHeight - 42 - KNavBarHeight- 44);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MingXiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MingXiTableViewCell description]];
    cell.autoCorner = YES;
    [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
    if (self.dataArray.count) {
        cell.model = self.dataArray[indexPath.row];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UIView *)listView {
    return self.view;
}

@end

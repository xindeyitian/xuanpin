//
//  withdrawRecordViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/13.
//

#import "withdrawRecordViewController.h"
#import "withdrawRecordTableViewCell.h"
#import "withdrawShaixuanView.h"
#import "WithdrawRecordModel.h"

@interface withdrawRecordViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic , strong)withdrawShaixuanView *shaixuanView;
@property(nonatomic , assign)NSInteger page;

@property(nonatomic , copy)NSString *startTime;
@property(nonatomic , copy)NSString *endTime;
@property(nonatomic , copy)NSString *dealSign;

@end

@implementation withdrawRecordViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.startTime = self.endTime = @"";
    self.dealSign = @"";
    
    self.emptyDataView.noDataImageView.image = IMAGE_NAMED(@"no_data_list");
    self.emptyDataView.noDataTitleLabel.text = @"暂无数据哦～";
    
    self.navigationController.delegate = self;
    self.navigationItem.title = @"提现记录";
    self.view.backgroundColor = KBGColor;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [btn setTitle:@"筛选" forState:UIControlStateNormal];
    [btn setTitleColor:KBlack333TextColor forState:UIControlStateNormal];
    btn.titleLabel.font = DEFAULT_FONT_R(15);
    [btn setImage:IMAGE_NAMED(@"withdraw_shaixuan_img") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shaixuanClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:4];
    self.rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setRightBarButtonItem:self.rightButtonItem];
    
    [self.tableView registerClass:[withdrawRecordTableViewCell class] forCellReuseIdentifier:[withdrawRecordTableViewCell description]];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(12);
        } else {
            make.top.equalTo(self.view).offset(KNavBarHeight).offset(12);
        }
    }];
    self.shaixuanView = [[withdrawShaixuanView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.shaixuanView.hiddenStatus = NO;
    CJWeakSelf()
    self.shaixuanView.confirmBlock = ^(NSString * _Nonnull startTime, NSString * _Nonnull endTime, NSString * _Nonnull type) {
        CJStrongSelf()
        if (startTime.length) {
            self.startTime = [NSString stringWithFormat:@"%@ 00:00:00",startTime];
        }else{
            self.startTime = @"";
        }
        if (endTime.length) {
            self.endTime = [NSString stringWithFormat:@"%@ 23:59:59",endTime];;
        }else{
            self.endTime = @"";
        }
        self.dealSign = type;
        [self loadNewData];
    };
    self.needPullUpRefresh = self.needPullDownRefresh = YES;
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
    NSDictionary *dica = @{@"applyTimeStart":self.startTime,
                           @"applyTimeEnd":self.endTime,
                           @"dealSign":self.dealSign,
                           @"pageNum":[NSString stringWithFormat:@"%ld",self.page],
                           @"pageSize":@"10",
    };
    NSString *url = @"user/shopWithdraw/withdrawLogPage";
    self.emptyDataView.hidden = YES;
    [THHttpManager GET:url parameters:dica block:^(NSInteger returnCode, THRequestStatus status, id data) {
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

-(void)shaixuanClick:(BaseButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.shaixuanView show];
    }
    if (!btn.selected) {
        [self.shaixuanView dismiss];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    withdrawRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[withdrawRecordTableViewCell description]];
    cell.autoCorner = YES;
    [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
    if (self.dataArray) {
        cell.model = self.dataArray[indexPath.row];
    }
    return cell;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    SetIOS13;
    [navigationController setNavigationBarHidden:NO animated:YES];
}

@end


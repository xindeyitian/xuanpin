//
//  THBaseTableViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import "THBaseTableViewController.h"

@interface THBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation THBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.backBtn.hidden = YES;
//    self.needPullUpRefresh = self.needPullDownRefresh = YES;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.equalTo(self.view).offset(KNavBarHeight);
        }
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(self.view.mas_bottom);
        }
        make.left.right.equalTo(self.view);
    }];
}

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:self.tableViewStyle ? self.tableViewStyle : UITableViewStyleGrouped];
        _tableView.backgroundColor = KBGColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.estimatedRowHeight = 44 ;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.00001f)];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.00001f)];
        if (@available(iOS 11.0, *)) {
           _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell description]];
    }
    return _tableView;
}

#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell description]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)setNeedPullDownRefresh:(BOOL)needPullDownRefresh {
    if(needPullDownRefresh) {
        CJWeakSelf()
        self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            CJStrongSelf()
            [self loadNewData];
        }];
    }
}

- (void)setNeedPullUpRefresh:(BOOL)needPullUpRefresh {
    if(needPullUpRefresh) {
        CJWeakSelf()
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            CJStrongSelf()
            [self loadMoreData];
        }];
    }
}

- (void)loadNewData {
    //[self endRefresh];
}

- (void)loadMoreData {
    //[self endRefresh];
}

- (void)endRefresh {
    [UIView animateWithDuration:3 animations:^{
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (NSMutableArray *)dataArray {
    if(!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)setEmptyImageName:(NSString *)emptyImageName {
    _emptyImageName = emptyImageName;
    self.emptyDataView.noDataImageView.image = [UIImage imageNamed:emptyImageName];
}

- (void)setEmptyText:(NSString *)emptyText {
    _emptyText = emptyText;
    self.emptyDataView.noDataTitleLabel.text = emptyText;
}

- (CJNoDataView *)emptyDataView {
    if(!_emptyDataView) {
        _emptyDataView = [[CJNoDataView alloc] init];
        _emptyDataView.hidden = YES;
        [self.tableView addSubview:_emptyDataView];
        [_emptyDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.tableView);
            make.width.mas_equalTo(278);
            make.height.mas_equalTo(170);
        }];
    }
    return _emptyDataView;
}

- (CJNoDataView *)noNetView {
    if (!_noNetView) {
        _noNetView = [[CJNoDataView alloc] initWithFrame:CGRectZero];
        [self.tableView addSubview:_noNetView];
        _noNetView.hidden = YES;
        [_emptyDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.tableView);
            make.width.mas_equalTo(278);
            make.height.mas_equalTo(170);
        }];
//        CJWeakSelf()
//        _noNetView.reloadRequestBlock = ^{
//            CJStrongSelf()
//            [self loadNewData];
//        };
    }
    return _noNetView;
}

- (BaseButton *)backBtn{
    if (!_backBtn) {
        
        _backBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(backClcik) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"bar_back" HeightLightBackgroundImage:@"bar_back"];
        _backBtn.frame = CGRectMake(0, KStatusBarHeight+7, 30, 30);
        _backBtn.backgroundColor = UIColor.clearColor;
        [self.view addSubview:_backBtn];
    }
    return _backBtn;
}

- (void)backClcik{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SetIOS13;
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}

@end

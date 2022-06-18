//
//  HomeStoreContentViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/28.
//

#import "HomeStoreContentViewController.h"
#import "HomeStoreContentTableViewCell.h"
#import "HomeDataModel.h"
#import "SearchNavBar.h"
#import "BrandModel.h"

@interface HomeStoreContentViewController ()

@property (nonatomic , assign)NSInteger page;
@property (nonatomic , strong)SearchNavBar *nav;

@end

@implementation HomeStoreContentViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchStr = @"";
    self.page = 1;
    
    self.view.backgroundColor = self.tableView.backgroundColor = KBGLightColor;
    
    self.nav = [[SearchNavBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight)];
    self.nav.searchStr = _searchStr;
    self.nav.searchTF.text = _searchStr;
    self.nav.searchTF.placeholder = @"搜索店铺名称";
    [self.view addSubview:self.nav];
    CJWeakSelf()
    self.nav.searchBtnOperationBlock = ^(NSString * _Nonnull searchStr) {
        CJStrongSelf()
        self.searchStr = searchStr;
        [self getHomeData];
    };
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nav.mas_bottom);
        make.bottom.left.right.equalTo(self.view);
    }];
    [self.tableView registerClass:[HomeStoreContentTableViewCell class] forCellReuseIdentifier:[HomeStoreContentTableViewCell description]];
    
    self.needPullUpRefresh = self.needPullDownRefresh = YES;
    [self getHomeData];
}

- (void)setSearchStr:(NSString *)searchStr{
    _searchStr = searchStr;
    [self loadNewData];
}

-(void)loadNewData{
    self.page = 1;
    [self getHomeData];
}

- (void)loadMoreData{
    self.page ++;
    [self getHomeData];
}

- (void)getHomeData{
    if (!self.tableView.mj_header.isRefreshing && !self.tableView.mj_footer.isRefreshing) {
        [self startLoadingHUD];
    }
    //supplyId
    NSMutableDictionary *dic = [@{ @"pageNum":[NSString stringWithFormat:@"%ld",(long)self.page],
                                @"pageSize":@"10",
    } mutableCopy];
    
    if (self.searchStr.length) {
        [dic setValue:[NSString stringWithFormat:@"%@",self.searchStr] forKey:@"supplyId"];
    }
    self.emptyDataView.hidden = YES;
    [THHttpManager GET:@"supply/supplyInfo/brandConceptPage" parameters:dic block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            BrandModel *model = [BrandModel mj_objectWithKeyValues:data];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:model.records];
                self.emptyDataView.hidden = !(self.dataArray.count == 0);
                if (self.dataArray.count == 0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
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

#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeStoreContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeStoreContentTableViewCell description]];
    cell.autoCorner = YES;
    cell.bgViewContentInset = UIEdgeInsetsMake(12, 12, 0, 12);
    [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
    if (self.dataArray.count) {
        BrandConceptVosModel *model = self.dataArray[indexPath.section];
        cell.model = model;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 240 + 12  - 76 + 76*KScreenW_Ratio;
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

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

//- (UIView *)listView {
//    return self.view;
//}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SetIOS13;
    [navigationController setNavigationBarHidden:YES animated:YES];
}

@end

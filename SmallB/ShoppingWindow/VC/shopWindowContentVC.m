//
//  shopWindowContentVC.m
//  SmallB
//
//  Created by zhang on 2022/4/9.
//

#import "shopWindowContentVC.h"
#import "shipWindowContentCell.h"
#import "RecordsModel.h"

@interface shopWindowContentVC ()<JXCategoryViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,LMJVerticalFlowLayoutDelegate>
{
    NSInteger _index;
}
@property (copy,   nonatomic) void(^scrollCallback)(UIScrollView *scrollView);
@property (strong, nonatomic) UICollectionView *homeCollection;
@property (strong, nonatomic) UIView *topUtilityView;
@property (nonatomic, strong) NSMutableArray<NSString *> *titles;
@property (nonatomic, strong) JXCategoryTitleSortView *categoryView;

@property (strong, nonatomic) CJNoDataView *emptyView;

@property (assign, nonatomic) NSInteger page;

@end

@implementation shopWindowContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.dataArray = [NSMutableArray array];
    self.tableView.backgroundColor = KBlackLineColor;
    self.needPullUpRefresh = self.needPullDownRefresh = YES;
    
    [self.tableView registerClass:[shipWindowContentCell class] forCellReuseIdentifier:[shipWindowContentCell description]];
    
    self.page = 1;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadNewData];
}

-(void)setIndex:(NSInteger)index{
    _index = index;
}

-(void)setShopType:(NSInteger)shopType{
    _shopType = shopType;
    //[self loadNewData];
}

- (void)setSearchStr:(NSString *)searchStr{
    _searchStr = searchStr;
    [self loadNewData];
}

- (void)loadNewData{
    self.page = 1;
    [self getHomeData];
}

- (void)loadMoreData{
    self.page ++ ;
    [self getHomeData];
}

- (void)getHomeData{
    if (!self.tableView.mj_header.isRefreshing && !self.tableView.mj_footer.isRefreshing) {
        [self startLoadingHUD];
    }
    NSString *goodsStatus = @"";
    if (self.shopType == 0) {
        goodsStatus = self.index == 0 ? @"1":@"2";
    }
    if (self.shopType == 1) {
        goodsStatus = self.index == 0 ? @"1":(self.index == 1? @"3":@"2");
    }
  
    NSMutableDictionary *dic = [@{
                          @"pageNum":[NSString stringWithFormat:@"%ld",(long)self.page],
                          @"pageSize":@"10",
                          @"ifSelf":[NSString stringWithFormat:@"%ld",(long)self.shopType],
                          @"goodsStatus":goodsStatus
    } mutableCopy];
    if (self.searchStr.length) {
        [dic setObject:self.searchStr forKey:@"goodsName"];
    }
    self.emptyView.hidden = YES;
    [THHttpManager GET:@"goods/shopGoods/shopGoodsPage" parameters:dic block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            RecordsModel *model = [RecordsModel mj_objectWithKeyValues:data];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:model.records];
                self.emptyView.hidden = !(self.dataArray.count == 0);
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


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 107 - KNavBarHeight - KTabBarHeight);
}
#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    shipWindowContentCell *cell = [tableView dequeueReusableCellWithIdentifier:[shipWindowContentCell description]];
    cell.index = self.index;
    cell.shopType = self.shopType;
    if (self.dataArray.count) {
        GoodsListVosModel *model = self.dataArray[indexPath.section];
        cell.model = model;
    }
    cell.viewBlock = ^{
        [self loadNewData];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 144;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
    view.backgroundColor = KBlackLineColor;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)listView {
    return self.view;
}

- (CJNoDataView *)emptyView {
    if(!_emptyView) {
        _emptyView = [[CJNoDataView alloc] init];
        _emptyView.hidden = YES;
        _emptyView.backgroundColor = UIColor.clearColor;
        [self.tableView addSubview:_emptyView];
        [_emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.tableView.centerY).offset(30*KScreenW_Ratio);
            make.left.mas_equalTo(self.tableView).offset(ScreenWidth/2.0 -  100);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(235);
        }];
    }
    return _emptyView;
}

@end


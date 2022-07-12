//
//  HomeMoreCommonViewController.m
//  SmallB
//
//  Created by zhang on 2022/5/1.
//

#import "HomeMoreCommonViewController.h"
#import "BaseOwnerNavView.h"
#import "BaseSearchView.h"
#import "RecordsModel.h"
#import "HomeCollectionViewCell.h"
#import "RankListContentTableViewCell.h"
#import "SearchNavBar.h"

@interface HomeMoreCommonViewController ()

@property (nonatomic , assign)NSInteger sortType;
@property (nonatomic , assign)NSInteger page;
@property (nonatomic , assign)NSInteger orderBy;

@property (nonatomic , strong)CJNoDataView *emptyView;
@property (nonatomic , strong)CJNoDataView *collecEmptyView;
@property (nonatomic , strong)SearchNavBar *nav;

@end

@implementation HomeMoreCommonViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *title = @"";
    self.page = 1;
    self.dataArray = [NSMutableArray array];
    self.sortType = 0;
   
    if (self.homeMoreCommonType != HomeMoreCommonType_SearchResult) {
        self.searchStr = @"";
    }

    BOOL haveTypeFlitter = YES;//有筛选
    BOOL ziDingYiNav = YES;
    switch (self.homeMoreCommonType) {
   
        case HomeMoreCommonType_Recommend:{
            title = @"好货推荐";
            self.topView.currentTitles = @[@"综合", @"销量", @"积分",@"价格"].mutableCopy;
            self.topView.hiddenAllBtn = NO;
            ziDingYiNav = YES;
        }
            break;
        case HomeMoreCommonType_Category:{
            title = self.titleStr;
            self.topView.hiddenAllBtn = NO;
            ziDingYiNav = YES;
        }
            break;
        case HomeMoreCommonType_HomeCategory:{
            title = @"分类";
            self.topView.hiddenAllBtn = NO;
            ziDingYiNav = YES;
        }
            break;
        case HomeMoreCommonType_SearchResult:{
            title = @"搜索结果";
            self.topView.hiddenAllBtn = NO;
            ziDingYiNav = NO;
        }
            break;
        default:
            break;
    }
    self.navigationItem.title = title;
    self.topView.hidden = !haveTypeFlitter;
    CJWeakSelf()
    self.topView.itemClickBlcok = ^(NSInteger index, BOOL isDescending) {
        CJStrongSelf()
        self.sortType = index;
        self.orderBy = isDescending ? 1:2;
        [self loadNewData];
    };
    float topHeight = KNavBarHeight;

    self.collectionView.frame = CGRectMake(0, topHeight + 10+(haveTypeFlitter ? 50:0), ScreenWidth, ScreenHeight - 20 - (haveTypeFlitter ? 50:0) - topHeight);
    self.tableView.frame = CGRectMake(0,topHeight + 10+(haveTypeFlitter ? 50:0), ScreenWidth, ScreenHeight - 20 - (haveTypeFlitter ? 50:0) - topHeight);
    self.topView.frame = CGRectMake(0, topHeight, ScreenWidth, 50);
    [self.tableView registerClass:[RankListContentTableViewCell class] forCellReuseIdentifier:[RankListContentTableViewCell description]];
    
    if (ziDingYiNav) {
        UIView *topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, KStatusBarHeight + 44)];
        topBackView.backgroundColor = [UIColor bm_colorGradientChangeWithSize:topBackView.size direction:IHGradientChangeDirectionLevel startColor:KJianBianBGColor endColor:KMainBGColor];
        [topBackView removeFromSuperview];
        [self.view addSubview:topBackView];
        
        BaseSearchNavBarView *bar = [[BaseSearchNavBarView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight)];
        bar.hiddenBackBtn = NO;
        bar.fieldEnabled = YES;
        CJWeakSelf()
        bar.viewClickBlock = ^(NSInteger index, NSString * _Nonnull searchStr) {
            CJStrongSelf()
            self.searchStr = searchStr;
            [self getHomeData];
        };
        [topBackView addSubview:bar];
    }else{
        self.nav = [[SearchNavBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight)];
        self.nav.searchStr = _searchStr;
        self.nav.searchTF.text = _searchStr;
        [self.view addSubview:self.nav];
        CJWeakSelf()
        self.nav.searchBtnOperationBlock = ^(NSString * _Nonnull searchStr) {
            CJStrongSelf()
            self.searchStr = searchStr;
            [self getHomeData];
        };
    }
    self.needPullUpRefresh = self.needPullDownRefresh = YES;
    self.collectionNeedPullUpRefresh = self.collectionNeedPullDownRefresh = YES;
    [self getHomeData];
}

- (void)setSearchStr:(NSString *)searchStr{
    _searchStr = searchStr;
    self.nav.searchStr = _searchStr;
    self.nav.searchTF.text = _searchStr;
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
    if (!self.tableView.mj_header.isRefreshing && !self.tableView.mj_footer.isRefreshing && !self.collectionView.mj_header.isRefreshing && !self.collectionView.mj_footer.isRefreshing) {
        [self startLoadingHUD];
    }
    NSMutableDictionary *dic = [@{@"blockId":K_NotNullHolder(self.blockId, @""),
                          @"pageNum":[NSString stringWithFormat:@"%ld",(long)self.page],
                          @"pageSize":@"10",
    } mutableCopy];
    if (self.sortType != 0) {
        [dic setValue:[NSString stringWithFormat:@"%ld",(long)self.sortType] forKey:@"sortType"];
        [dic setValue:[NSString stringWithFormat:@"%ld",(long)self.orderBy] forKey:@"orderBy"];
    }
    self.emptyView.hidden = YES;
    self.collecEmptyView.hidden = YES;
    NSString *url = @"goods/shopBlockDefine/shopBlockGoodsPage";
    if (self.categoryId.length) {
        url = @"goods/goodsInfo/goodsPage";
        [dic removeObjectForKey:@"blockId"];
        [dic setValue:[NSString stringWithFormat:@"%@",self.categoryId] forKey:@"categoryId"];
    }
    
    if (self.homeMoreCommonType == HomeMoreCommonType_SearchResult) {
        if ([dic objectForKey:@"categoryId"]) {
            [dic removeObjectForKey:@"categoryId"];
        }
        if ([dic objectForKey:@"blockId"]) {
            [dic removeObjectForKey:@"blockId"];
        }
        url = @"goods/goodsInfo/goodsPage";
    }
    if (self.searchStr.length) {
        [dic setValue:[NSString stringWithFormat:@"%@",self.searchStr] forKey:@"goodsName"];
    }
    
    if (self.searchStr.length && self.homeMoreCommonType == HomeMoreCommonType_SearchResult) {
        [AppTool saveToLocalSearchHistory:self.searchStr];
    }
    
    [THHttpManager GET:url parameters:dic block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            RecordsModel *model = [RecordsModel mj_objectWithKeyValues:data];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:model.records];
                self.emptyView.hidden = !(self.dataArray.count == 0);
                self.collecEmptyView.hidden = !(self.dataArray.count == 0);
                if (self.dataArray.count == 0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }
            }else{
                [self.dataArray addObjectsFromArray:model.records];
                if (model.records.count == 0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [AppTool dealCollectionDataAry:self.dataArray];
            [self.collectionView reloadData];
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HomeCollectionViewCell description] forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}

- (CGFloat)waterflowLayout:(THFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    GoodsListVosModel *model = self.dataArray[indexPath.item];
    return model.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.homeMoreCommonType == HomeMoreCommonType_Recommend) {
        ProductsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:[ProductsCommentCell description]];
        if (self.dataArray.count) {
            cell.dataModel = self.dataArray[indexPath.row];
        }
        return cell;
    }
    
    RankListContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RankListContentTableViewCell description]];
    if (self.dataArray.count) {
        cell.model = self.dataArray[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count) {
        GoodsListVosModel *dataModel = self.dataArray[indexPath.row];
        [AppTool GoToProductDetailWithID:dataModel.goodsId];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count) {
        GoodsListVosModel *model = self.dataArray[indexPath.item];
        [AppTool GoToProductDetailWithID:model.goodsId];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{

    if (self.homeMoreCommonType == HomeMoreCommonType_SearchResult) {
        return UIStatusBarStyleDefault;
    }
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

- (CJNoDataView *)emptyView {
    if(!_emptyView) {
        _emptyView = [[CJNoDataView alloc] init];
        _emptyView.hidden = YES;
        _emptyView.backgroundColor = UIColor.clearColor;
        [self.tableView addSubview:_emptyView];
        [_emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.tableView.centerY).offset(-20*KScreenW_Ratio);
            make.left.mas_equalTo(self.tableView).offset(ScreenWidth/2.0 -  139);
            make.width.mas_equalTo(278);
            make.height.mas_equalTo(170);
        }];
    }
    return _emptyView;
}

- (CJNoDataView *)collecEmptyView {
    if(!_collecEmptyView) {
        _collecEmptyView = [[CJNoDataView alloc] init];
        _collecEmptyView.hidden = YES;
        _collecEmptyView.backgroundColor = UIColor.clearColor;
        [self.collectionView addSubview:_collecEmptyView];
        [_collecEmptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.collectionView.centerY).offset(-20*KScreenW_Ratio);
            make.left.mas_equalTo(self.tableView).offset(ScreenWidth/2.0 -  139);
            make.width.mas_equalTo(278);
            make.height.mas_equalTo(170);
        }];
    }
    return _collecEmptyView;
}


@end

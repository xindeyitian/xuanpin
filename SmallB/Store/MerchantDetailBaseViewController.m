//
//  MerchantDetailBaseViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/11.
//

#import "MerchantDetailBaseViewController.h"
#import "MerchantDetailIProductViewController.h"
#import "MerchantDetailCategoryViewController.h"
#import "TicketViewController.h"
#import "MerchantDetailViewController.h"
#import "MerchantDetailView.h"
#import "RankListContentTableViewCell.h"
#import "ProductDetailViewController.h"
#import "StoreModel.h"
#import "RecordsModel.h"
#import "HomeCollectionViewCell.h"

@interface MerchantDetailBaseViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) MyLinearLayout      *topLy;
@property (strong, nonatomic) UITextField         *searchTF;
@property (strong, nonatomic) UIImageView         *merchantImg;
@property (strong, nonatomic) UILabel             *merchantName;
@property (strong, nonatomic) UIButton            *attentionBtn;
@property (strong, nonatomic) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) StoreModel *storeModel;
@property (nonatomic, strong) MerchantDetailView *infoView;

@property (nonatomic , assign)NSInteger sortType;
@property (nonatomic , assign)NSInteger page;
@property (nonatomic , assign)NSInteger orderBy;
@property (nonatomic , strong)CJNoDataView *emptyView;
@property (nonatomic , strong)CJNoDataView *collecemptyView;
@property (nonatomic , copy)NSString *searchStr;

@end

@implementation MerchantDetailBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    
    self.page = 1;
    self.dataArray = [NSMutableArray array];
    self.sortType = 0;
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(collectionChange) name:@"collectionChange" object:nil];
    
    self.infoView = [[MerchantDetailView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 98+KNavBarHeight)];
    self.infoView.havSearchNav = YES;
    CJWeakSelf()
    self.infoView.searchBlock = ^(NSString * _Nonnull searchStr) {
        CJStrongSelf()
        self.searchStr = searchStr;
        [self loadNewData];
    };
    
    [self.view addSubview:self.infoView];
    
    self.topView.frame = CGRectMake(0, KNavBarHeight + 98, ScreenWidth, 50);
    self.topView.currentTitles =  @[@"综合", @"销量", @"积分",@"价格"].mutableCopy;
    self.tableView.frame = CGRectMake(0,  KNavBarHeight + 98 + 50 + 12, ScreenWidth, ScreenHeight - KNavBarHeight - 98 - 50 - 12);
    self.collectionView.frame = CGRectMake(0, KNavBarHeight + 98 + 50+12, ScreenWidth, ScreenHeight - 98 - KNavBarHeight - 50 - 12);
   
    self.topView.itemClickBlcok = ^(NSInteger index, BOOL isDescending) {
        CJStrongSelf()
        self.sortType = index;
        self.orderBy = isDescending ? 1:2;
        [self getStoreProduct];
    };
    self.topView.typeClickBlcok = ^(BOOL isSelected) {
        CJStrongSelf()
        self.tableView.hidden = !isSelected;
        self.collectionView.hidden = isSelected;
    };
    [self.tableView registerClass:[RankListContentTableViewCell class] forCellReuseIdentifier:[RankListContentTableViewCell description]];
    self.needPullUpRefresh = self.needPullDownRefresh = YES;
    self.collectionNeedPullUpRefresh = self.collectionNeedPullDownRefresh = YES;
    [self loadNewData];
}

- (void)collectionChange{
    [self getStoreDetail];
}

-(void)loadNewData{
    self.page = 1;
    [self getStoreProduct];
    [self getStoreDetail];
}

- (void)loadMoreData{
    self.page ++;
    [self getStoreProduct];
}

- (void)getStoreDetail{
    [THHttpManager GET:@"supply/supplyInfo/getSupplierDetail" parameters:@{@"supplyId":self.supplierID} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            self.storeModel = [StoreModel mj_objectWithKeyValues:data];
            self.infoView.storeModel = self.storeModel;
        }
    }];
}

- (void)getStoreProduct{
    if (!self.tableView.mj_header.isRefreshing && !self.tableView.mj_footer.isRefreshing && !self.collectionView.mj_header.isRefreshing && !self.collectionView.mj_footer.isRefreshing) {
        [self startLoadingHUD];
    }
    NSMutableDictionary *dic = [@{@"supplyId":K_NotNullHolder(self.supplierID, @""),
                          @"pageNum":[NSString stringWithFormat:@"%ld",(long)self.page],
                          @"pageSize":@"10",
    } mutableCopy];
    if (self.sortType != 0) {
        [dic setValue:[NSString stringWithFormat:@"%ld",(long)self.sortType] forKey:@"sortType"];
        [dic setValue:[NSString stringWithFormat:@"%ld",(long)self.orderBy] forKey:@"orderBy"];
    }
    self.emptyView.hidden = YES;
    self.collecemptyView.hidden = YES;
    
    if (self.searchStr.length) {
        [dic setValue:[NSString stringWithFormat:@"%@",self.searchStr] forKey:@"goodsName"];
    }
    [THHttpManager GET:@"goods/goodsInfo/goodsForSupplierPage" parameters:dic block:^(NSInteger returnCode, THRequestStatus status, id data) {
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
                self.collecemptyView.hidden = !(self.dataArray.count == 0);
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    RankListContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RankListContentTableViewCell description]];
    cell.autoCorner = YES;
    cell.bgViewContentInset = UIEdgeInsetsMake(0, 12, 0, 12);
    [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 118;
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count) {
        GoodsListVosModel *model = self.dataArray[indexPath.item];
        [AppTool GoToProductDetailWithID:model.goodsId];
    }
}

- (void)attentionBtnClicked:(BaseButton *)btn{
    
}

- (void)btnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - JXPagingViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    if (index == 0) {
        return [[MerchantDetailIProductViewController alloc] init];
    }else if(index == 1){
        return [[MerchantDetailCategoryViewController alloc] init];
    }else{
        return [[TicketViewController alloc] init];
    }
}
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 3;
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
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
            make.centerY.mas_equalTo(self.tableView.centerY).offset(10*KScreenW_Ratio);
            make.left.mas_equalTo(self.tableView).offset(ScreenWidth/2.0 -  139);
            make.width.mas_equalTo(278);
            make.height.mas_equalTo(170);
        }];
    }
    return _emptyView;
}

- (CJNoDataView *)collecemptyView {
    if(!_collecemptyView) {
        _collecemptyView = [[CJNoDataView alloc] init];
        _collecemptyView.hidden = YES;
        _collecemptyView.backgroundColor = UIColor.clearColor;
        [self.collectionView addSubview:_collecemptyView];
        [_collecemptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.collectionView.centerY).offset(10*KScreenW_Ratio);
            make.left.mas_equalTo(self.tableView).offset(ScreenWidth/2.0 -  139);
            make.width.mas_equalTo(278);
            make.height.mas_equalTo(170);
        }];
    }
    return _collecemptyView;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

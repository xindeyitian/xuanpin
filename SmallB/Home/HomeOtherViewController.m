//
//  HomeOtherViewController.m
//  SmallB
//
//  Created by 张昊男 on 2022/4/6.
//

#import "HomeOtherViewController.h"
#import "HomeCollectionViewCell.h"
#import "HomeTopView.h"
#import "HomeCollectionReusableHeaderView.h"
#import "HomeDataModel.h"
#import "RecordsModel.h"

@interface HomeOtherViewController ()<JXCategoryViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,LMJVerticalFlowLayoutDelegate>
{
    NSInteger _index;
    NSInteger _layerType;//0:主页排布方式为tableview 1:主页排布方式为collection
}
@property (copy,   nonatomic) void(^scrollCallback)(UIScrollView *scrollView);
@property (strong, nonatomic) UITableView *homeTable;
@property (strong, nonatomic) UICollectionView *homeCollection;
@property (strong, nonatomic) BaseTopSelectView *topUtilityView;
@property (nonatomic, strong) NSMutableArray<NSString *> *titles;
@property (nonatomic, strong) JXCategoryTitleSortView *categoryView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) HomeTopView *topView;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) GoodsCategoryListVosModel *categoryModel;
@property (strong, nonatomic)THFlowLayout *collectionLayout;

@property (nonatomic , strong)CJNoDataView *emptyView;
@property (assign, nonatomic) NSInteger page;
@property (assign, nonatomic) NSInteger orderBy;
@property (assign, nonatomic) NSInteger sortType;

@end

@implementation HomeOtherViewController
#pragma mark - 切换tableview和collectionView

- (void)viewDidLoad {
    [super viewDidLoad];
    //0:主页排布方式为tableview 1:主页排布方式为collection
    _layerType = 0;
    self.dataArray = @[].mutableCopy;
    self.page = 1;
    self.orderBy = 0;
    
    self.view.backgroundColor = KBGColor;
    self.homeTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.homeTable.delegate = self;
    self.homeTable.dataSource = self;
    self.homeTable.showsVerticalScrollIndicator = NO;
    self.homeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.homeTable.backgroundColor = KBGColor;
    self.homeTable.layer.cornerRadius = 8;
    self.homeTable.layer.masksToBounds = YES;
    [self.view addSubview:self.homeTable];
    [self.homeTable registerClass:[ProductsCommentCell class] forCellReuseIdentifier:[ProductsCommentCell description]];
    if (@available(iOS 15.0,*)) {
        self.homeTable.sectionHeaderTopPadding = YES;
    }
    self.topView = [[HomeTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 305+10)];
    self.homeTable.tableHeaderView = self.topView;
    self.homeTable.hidden = YES;
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
    if (!self.homeCollection.mj_header.isRefreshing && !self.homeCollection.mj_footer.isRefreshing) {
        [self startLoadingHUD];
    }
    GoodsCategoryListVosModel *categoryModel = self.dataModel.goodsCategoryListVos[self.index-1];
    NSMutableDictionary *dica = [@{@"pageNum":[NSString stringWithFormat:@"%ld",(long)self.page],
                           @"pageSize":@"10",
                           @"categoryId":categoryModel.categoryId
    } mutableCopy];
    if (self.sortType != 0) {
        [dica setValue:[NSString stringWithFormat:@"%d",self.sortType] forKey:@"sortType"];
        [dica setValue:[NSString stringWithFormat:@"%d",self.orderBy] forKey:@"orderBy"];
    }
    [THHttpManager GET:@"goods/goodsInfo/goodsPage" parameters:dica block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        [self.homeCollection.mj_header endRefreshing];
        [self.homeCollection.mj_footer endRefreshing];
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            RecordsModel *model = [RecordsModel mj_objectWithKeyValues:data];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:model.records];
                self.emptyView.hidden = !(self.dataArray.count == 0);
                if (self.dataArray.count == 0) {
                    [self.homeCollection.mj_footer endRefreshingWithNoMoreData];
                }
            }else{
                [self.dataArray addObjectsFromArray:model.records];
                if (model.records.count == 0) {
                    [self.homeCollection.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [AppTool dealCollectionDataAry:self.dataArray];
            [self.homeCollection reloadData];
        }
    }];
}

- (void)setIndex:(NSInteger)index{
    _index = index;
}

- (void)setDataModel:(HomeDataModel *)dataModel{
    _dataModel = dataModel;
    
    if (self.index > 0) {
        GoodsCategoryListVosModel *model = dataModel.goodsCategoryListVos[self.index - 1];
        self.topView.categoryModel = model;
        self.categoryModel = model;

        float height = (12 + 44*KScreenW_Ratio + 30)*(model.listVos.count%5 == 0 ? model.listVos.count/5 : model.listVos.count/5 + 1);
        if (model.bannerUrls.count) {
            height += 20;
            height += 140*KScreenW_Ratio;
        }
        if (model.listVos.count && model.bannerUrls.count == 0) {
            height += 20;
        }
        height += 44*KScreenW_Ratio;
        THFlowLayout *layout = [[THFlowLayout alloc] init];
        layout.delegate = self;
        layout.columnMargin = 8;
        layout.rowMargin = 8;
        layout.columnsCount = 2;
        layout.headerReferenceSize = CGSizeMake(ScreenWidth, height);
        layout.sectionInset = UIEdgeInsetsMake(10, 12, 0, 12);
        layout.isHeaderStick = YES;
        layout.stickHight = 44*KScreenW_Ratio;
        self.collectionLayout = layout;
        
        self.homeCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight - KTabBarHeight - KNavBarHeight - 50) collectionViewLayout:layout];
        self.homeCollection.collectionViewLayout = layout;
         if (@available(iOS 10.0, *)) {
             self.homeCollection.prefetchingEnabled = NO;
         }
        self.homeCollection.hidden = NO;
        self.homeCollection.backgroundColor = UIColor.clearColor;
        self.homeCollection.scrollEnabled = YES;
        self.homeCollection.dataSource = self;
        self.homeCollection.delegate = self;
        self.homeCollection.showsVerticalScrollIndicator = NO;
        self.homeCollection.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            self.homeCollection.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self.view addSubview:self.homeCollection];
        [self.homeCollection registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
        [self.homeCollection registerClass:[HomeCollectionReusableHeaderView class] forSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" withReuseIdentifier:@"HomeCollectionReusableHeaderView"];
        [self.homeCollection reloadData];
        
        [self.emptyView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.homeCollection.centerY).offset(height/2.0);
        }];
        
        [self loadNewData];
        CJWeakSelf()
        self.homeCollection.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            CJStrongSelf()
            [self loadNewData];
        }];
        
        self.homeCollection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            CJStrongSelf()
            [self loadMoreData];
        }];
    }
}

- (void)initTopView{
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 62)];
    self.headerView.backgroundColor = KBGColor;
    
    self.topUtilityView = [[BaseTopSelectView alloc] init];
    self.topUtilityView.hiddenAllBtn = YES;
    self.topUtilityView.frame = CGRectMake(0, 0, ScreenWidth, 50);
    [self.headerView addSubview:self.topUtilityView];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.categoryView.frame = CGRectMake(0, 0, ScreenWidth - 60, 50);
    self.homeTable.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - KNavBarHeight - KTabBarHeight - 62);
}

#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:[ProductsCommentCell description]];
    cell.bgViewContentInset = UIEdgeInsetsMake(0, 12, 0, 12);
    cell.autoCorner = YES;
    [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //return 0.01;
    return 62.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //return [UIView new];
    return self.headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [AppTool GoToProductDetailWithID:@""];
}

#pragma mark - collectionViewDelegate datasorce--------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    if (self.dataArray.count) {
        cell.model = self.dataArray[indexPath.item];
    }
    return cell;
}

//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView =nil;
    //返回段头段尾视图
    if (kind == UICollectionElementKindSectionHeader) {

        HomeCollectionReusableHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HomeCollectionReusableHeaderView" forIndexPath:indexPath];
        headerView.backgroundColor = KWhiteBGColor;
        headerView.categoryModel = self.categoryModel;
        CJWeakSelf()
        headerView.topUtilityView.itemClickBlcok = ^(NSInteger index, BOOL isDescending) {
            CJStrongSelf()
            self.sortType = index;
            self.orderBy = isDescending ? 1:2;
            [self loadNewData];
        };
        return headerView;
    }
    return reusableView;
}

- (CGFloat)waterflowLayout:(THFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count) {
        GoodsListVosModel *model = self.dataArray[indexPath.item];
        return model.height;
    }
    return 30;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count) {
        GoodsListVosModel *model = self.dataArray[indexPath.item];
        [AppTool GoToProductDetailWithID:model.goodsId];
    }
}

#pragma mark - JXCategoryListContentViewDelegate -
- (UIScrollView *)listScrollView {
    return self.homeTable;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self.view;
}

- (CJNoDataView *)emptyView {
    if(!_emptyView) {
        _emptyView = [[CJNoDataView alloc] init];
        _emptyView.hidden = YES;
        _emptyView.backgroundColor = UIColor.clearColor;
        [self.homeCollection addSubview:_emptyView];
        [_emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.homeCollection.centerY).offset(10*KScreenW_Ratio);
            make.centerX.mas_equalTo(self.homeCollection.mas_centerX);
            make.width.mas_equalTo(278);
            make.height.mas_equalTo(170);
        }];
    }
    return _emptyView;
}

@end

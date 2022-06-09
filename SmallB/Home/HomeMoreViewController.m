//
//  HomeMoreViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/29.
//

#import "HomeMoreViewController.h"
#import "BaseSearchView.h"
#import "HomeMoreCollectionReusableView.h"
#import "HomeCollectionViewCell.h"
#import "RecordsModel.h"
#import "CJNoDataView.h"

@interface HomeMoreViewController ()
{
    BOOL  haveTypeFlitter;
}
@property (strong, nonatomic) UICollectionView *homeCollection;
@property (nonatomic , strong)UIView *topBackView;
@property (nonatomic , copy)NSString *imageNameStr;
@property (nonatomic , strong)NSMutableArray *dataArray;

@property (nonatomic , assign)NSInteger sortType;
@property (nonatomic , assign)NSInteger page;
@property (nonatomic , assign)NSInteger orderBy;
@property (nonatomic , copy)NSString *searchStr;
@property (nonatomic , strong)CJNoDataView *emptyView;

@end

@implementation HomeMoreViewController

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
    
    haveTypeFlitter = YES;//有筛选
    
    NSString *imageName = @"";
    switch (self.homeMoreType) {
        case HomeMoreType_Brand:{
            title = @"品牌产品";
            imageName = @"home_brand";
        }
            break;
        case HomeMoreType_GoodYouXuan:{
            title = @"好货优选";
            imageName = @"home_goodYouXuan";
        }
            break;
        case HomeMoreType_JiuKuaiJiu:{
            title = @"9.9包邮";
            haveTypeFlitter = NO;
            imageName = @"home_jiukuaijiu";
        }
            break;
        case HomeMoreType_Global:{
            title = @"全球嗨购";
            imageName = @"home_global";
        }
            break;
        case HomeMoreType_Rank:{
            title = @"带货榜单";
            imageName = @"home_rank";
        }
            break;
        case HomeMoreType_XiaoLianYouXuan:{
            title = @"小莲优选";
            imageName = @"home_xiaolianyouxuan";
        }
            break;
        default:
            break;
    }
    self.imageNameStr = imageName;
    self.navigationItem.title = title;

    [self creatCollection];
    
    self.topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, KStatusBarHeight + 44)];
    self.topBackView.backgroundColor = [UIColor bm_colorGradientChangeWithSize:self.topBackView.size direction:IHGradientChangeDirectionLevel startColor:KJianBianBGColor endColor:KMainBGColor];
    [self.topBackView removeFromSuperview];
    [self.view addSubview:self.topBackView];
    self.topBackView.alpha = 0;
    
    BaseSearchView *searchV = [[BaseSearchView alloc] initWithFrame:CGRectMake(0, KStatusBarHeight+2, ScreenWidth, 40)];
    searchV.fieldEnabled = YES;
    searchV.showBackBtn = YES;
    CJWeakSelf()
    searchV.viewClickBlock = ^(NSInteger index, NSString * _Nonnull searchStr) {
        CJStrongSelf()
        self.searchStr = searchStr;
        [self loadNewData];
    };
    searchV.backgroundColor = UIColor.clearColor;
    searchV.searchBtn.backgroundColor = UIColor.clearColor;
    [searchV.searchBtn setTitleColor:KWhiteTextColor forState:UIControlStateNormal];
    [self.view addSubview:searchV];
    
    [self loadNewData];
}

- (void)creatCollection{
    THFlowLayout *layout = [[THFlowLayout alloc] init];
    layout.delegate = self;
    layout.columnMargin = 8;
    layout.rowMargin = 8;
    layout.columnsCount = 2;
    layout.headerReferenceSize = CGSizeMake(ScreenWidth, 233*KScreenW_Ratio + 42);
    if (!haveTypeFlitter) {
        layout.headerReferenceSize = CGSizeMake(ScreenWidth, 233*KScreenW_Ratio);
    }
    layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
    if (self.dataArray.count) {
        layout.isHeaderStick = YES;
        layout.stickHight = 42+KNavBarHeight;
    }
    if (!haveTypeFlitter) {
        layout.isHeaderStick = NO;
    }

    self.homeCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight - 0) collectionViewLayout:layout];
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
    [self.view sendSubviewToBack:self.homeCollection];

    [self.homeCollection reloadData];
    [self.homeCollection registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:[HomeCollectionViewCell description]];
    [self.homeCollection registerClass:[HomeMoreCollectionReusableView class] forSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" withReuseIdentifier:@"HomeMoreCollectionReusableView"];
    
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

-(void)loadNewData{
    self.page = 1;
    [self getHomeData];
}

- (void)loadMoreData{
    self.page ++;
    [self getHomeData];
}

- (void)getHomeData{
    if (!self.homeCollection.mj_header.isRefreshing && !self.homeCollection.mj_footer.isRefreshing) {
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
    if (self.searchStr.length) {
        [dic setValue:self.searchStr forKey:@"goodsName"];
    }
    self.emptyView.hidden = YES;
    
    [THHttpManager GET:@"goods/shopBlockDefine/shopBlockGoodsPage" parameters:dic block:^(NSInteger returnCode, THRequestStatus status, id data) {
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
            [self.homeCollection reloadData];
        }
    }];
}

//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView =nil;
    if (kind == UICollectionElementKindSectionHeader) {
        HomeMoreCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HomeMoreCollectionReusableView" forIndexPath:indexPath];
        headerView.topBackV.image = IMAGE_NAMED(self.imageNameStr);
        if (!haveTypeFlitter) {
            headerView.topView.hidden = YES;
        }
        CJWeakSelf()
        headerView.topView.itemClickBlcok = ^(NSInteger index, BOOL isDescending) {
            CJStrongSelf()
            self.sortType = index;
            self.orderBy = isDescending ? 1:2;
            [self loadNewData];
        };
        return headerView;
    }
    return reusableView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y;
    float maxHeight = 233*KScreenW_Ratio - 8 - KNavBarHeight;
    if (!haveTypeFlitter) {
        maxHeight = 233*KScreenW_Ratio - KNavBarHeight;
    }
    [UIView animateWithDuration:0.1 animations:^{
        if (offset > maxHeight){
            self.topBackView.alpha = 1;
        }else if(offset < maxHeight){
            self.topBackView.alpha = offset/maxHeight;
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ProductsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:[ProductsCommentCell description]];
    cell.autoCorner = YES;
    [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
    cell.showYongJin = YES;
    return cell;
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
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HomeCollectionViewCell description] forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}

- (CGFloat)waterflowLayout:(THFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    GoodsListVosModel *model = self.dataArray[indexPath.item];
    return model.height;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsListVosModel *model = self.dataArray[indexPath.item];
     [AppTool GoToProductDetailWithID:model.goodsId];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (CJNoDataView *)emptyView {
    if(!_emptyView) {
        _emptyView = [[CJNoDataView alloc] init];
        _emptyView.hidden = YES;
        _emptyView.backgroundColor = UIColor.clearColor;
        [self.homeCollection addSubview:_emptyView];
        [_emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.homeCollection.centerY).offset(112*KScreenW_Ratio);
            make.left.mas_equalTo(self.homeCollection).offset(ScreenWidth/2.0 -  100);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(235);
        }];
    }
    return _emptyView;
}

@end



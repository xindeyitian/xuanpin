//
//  BaseCollectionAndTableViewVC.m
//  SmallB
//
//  Created by zhang on 2022/4/22.
//

#import "BaseCollectionAndTableViewVC.h"
#import "HomeCollectionViewCell.h"
#import "ProductsCommentCell.h"

@interface BaseCollectionAndTableViewVC ()<UICollectionViewDelegate,UICollectionViewDataSource,THFlowLayoutDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseCollectionAndTableViewVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KBGColor;
    self.dataArray = @[].mutableCopy;
    NSArray *title = @[@"日本药妆店便宜",@"日本药妆店便京购物精华",@"日本药妆店华",@"日本药妆店精华",@"日本药华",@"日本药妆本药妆宜必败好物东京购物精华",@"日本药妆店便宜物精华",@"日本药妆店便宜精华",@"日本药妆店",@"日本药妆店便精华"];
    for (int i = 0; i < 10; i++) {
        
        GoodsListVosModel *model = [[GoodsListVosModel alloc] init];
        model.goodsName = title[i];
        [self.dataArray addObject:model];
    }
    [self.view addSubview:self.topView];
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = CGRectMake(0, 10+50, ScreenWidth, ScreenHeight - KNavBarHeight - 10 - 50 );

    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 10+50, ScreenWidth, ScreenHeight - KNavBarHeight - 10 - 50 );
    
    self.tableView.hidden = NO;
    self.collectionView.hidden = YES;

    CJWeakSelf()
    self.topView.itemClickBlcok = ^(NSInteger index, BOOL isDescending) {
        CJStrongSelf()
        [self.tableView reloadData];
        [self.collectionView reloadData];
    };
    self.topView.typeClickBlcok = ^(BOOL isSelected) {
        CJStrongSelf()
        self.tableView.hidden = !isSelected;
        self.collectionView.hidden = isSelected;
    };
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
        [_tableView registerClass:[ProductsCommentCell class] forCellReuseIdentifier:[ProductsCommentCell description]];
    }
    return _tableView;
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
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [AppTool GoToProductDetailWithID:@""];
}

#pragma mark - collectionViewDelegate datasorce--------
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
    [AppTool GoToProductDetailWithID:@""];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
    THFlowLayout *layout = [[THFlowLayout alloc] init];
    layout.delegate = self;
    layout.columnMargin = 8;
    layout.rowMargin = 8;
    layout.columnsCount = 2;
    layout.headerReferenceSize = CGSizeMake(ScreenWidth, 0);
    layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);

    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, ScreenHeight - KNavBarHeight - 10) collectionViewLayout:layout];
     if (@available(iOS 10.0, *)) {
         _collectionView.prefetchingEnabled = NO;
         _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
     } else {
         
     }
    _collectionView.backgroundColor = UIColor.clearColor;
    _collectionView.scrollEnabled = YES;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:[UICollectionViewCell description]];
    [_collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:[HomeCollectionViewCell description]];
    }
    return _collectionView;
}

- (BaseTopSelectView *)topView{
    if (!_topView) {
        _topView = [[BaseTopSelectView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    }
    return _topView;
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

- (void)setCollectionNeedPullUpRefresh:(BOOL)collectionNeedPullUpRefresh {
    if(collectionNeedPullUpRefresh) {
        CJWeakSelf()
        self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            CJStrongSelf()
            [self loadMoreData];
        }];
    }
}

- (void)setCollectionNeedPullDownRefresh:(BOOL)collectionNeedPullDownRefresh {
    if(collectionNeedPullDownRefresh) {
        CJWeakSelf()
        self.collectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
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

- (void)loadNewData {}

- (void)loadMoreData {}

- (NSMutableArray *)dataArray {
    if(!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)setEmptyImageName:(NSString *)emptyImageName {
    _emptyImageName = emptyImageName;
    //self.emptyDataView.noDataImageView.image = [UIImage imageNamed:emptyImageName];
}

- (void)setEmptyText:(NSString *)emptyText {
    _emptyText = emptyText;
    //self.emptyDataView.noDataTitleLabel.text = emptyText;
}

- (CJNoDataView *)emptyDataView {
    if(!_emptyDataView) {
        _emptyDataView = [[CJNoDataView alloc] init];
        _emptyDataView.hidden = YES;
        [self.tableView addSubview:_emptyDataView];
        [_emptyDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.tableView);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(235);
        }];
    }
    return _emptyDataView;
}
//
//- (CJImportNoNetworkView *)noNetView {
//    if (!_noNetView) {
//        _noNetView = [[CJImportNoNetworkView alloc] initWithFrame:CGRectMake(0, 0, CJScreenW, CJScreenH - CJSafeAreaTopHeight)];
//        _noNetView.remindsIconView.image = [UIImage imageNamed:@"common_nonetwork_img_normal"];
//        [self.tableView addSubview:_noNetView];
//        _noNetView.hidden = YES;
//        CJWeakSelf()
//        _noNetView.reloadRequestBlock = ^{
//            CJStrongSelf()
//            [self loadNewData];
//        };
//    }
//    return _noNetView;
//}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SetIOS13;
    [navigationController setNavigationBarHidden:NO animated:YES];
}

@end

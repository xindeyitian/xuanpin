//
//  BaseCollectionViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/21.
//

#import "BaseCollectionViewController.h"
#import "HomeCollectionViewCell.h"

@interface BaseCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,THFlowLayoutDelegate,UINavigationControllerDelegate>

@end

@implementation BaseCollectionViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[].mutableCopy;
    NSArray *title = @[@"日本药妆店便宜",@"日本药妆店便京购物精华",@"日本药妆店华",@"日本药妆店精华",@"日本药华",@"日本药妆本药妆宜必败好物东京购物精华",@"日本药妆店便宜物精华",@"日本药妆店便宜精华",@"日本药妆店",@"日本药妆店便精华"];
    for (int i = 0; i < 10; i++) {
        
        GoodsListVosModel *model = [[GoodsListVosModel alloc] init];
        model.goodsName = title[i];
        [self.dataArray addObject:model];
    }
    [self.view addSubview:self.topView];
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = CGRectMake(0, 10+50, ScreenWidth, ScreenHeight - KNavBarHeight - 10 - 50);
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
        _topView.hiddenAllBtn = YES;
    }
    return _topView;
}

- (void)setNeedPullDownRefresh:(BOOL)needPullDownRefresh {
//    if(needPullDownRefresh) {
//        CJWeakSelf()
//        self.tableView.mj_header= [CJAnimatorRefreshHeader headerWithRefreshingBlock:^{
//            CJStrongSelf()
//            [self loadNewData];
//        }];
//    }
}

- (void)setNeedPullUpRefresh:(BOOL)needPullUpRefresh {
//    if(needPullUpRefresh) {
//        CJWeakSelf()
//        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            CJStrongSelf()
//            [self loadMoreData];
//        }];
//    }
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

//- (CJNoDataView *)emptyDataView {
//    if(!_emptyDataView) {
//        _emptyDataView = [[CJNoDataView alloc] init];
//        _emptyDataView.hidden = YES;
//        [self.tableView addSubview:_emptyDataView];
//        [_emptyDataView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self.tableView);
//            make.width.mas_equalTo(kCJScreenWRatio(200));
//            make.height.mas_equalTo(kCJScreenWRatio(235));
//        }];
//    }
//    return _emptyDataView;
//}
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

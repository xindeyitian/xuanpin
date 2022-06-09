//
//  SearchResultViewController.m
//  SmallB
//
//  Created by 张昊男 on 2022/4/7.
//

#import "SearchResultViewController.h"
#import "HomeCollectionViewCell.h"
#import "SearchNavBar.h"

@interface SearchResultViewController ()<JXCategoryViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,LMJVerticalFlowLayoutDelegate>
{
    NSInteger _index;
    NSInteger _layerType;//0:主页排布方式为tableview 1:主页排布方式为collection
}
@property (strong, nonatomic) UITableView *homeTable;
@property (strong, nonatomic) UICollectionView *homeCollection;
@property (strong, nonatomic) BaseTopSelectView *topUtilityView;
@property (strong, nonatomic) UIButton *changeLayerBtn;
@property (nonatomic, strong) NSMutableArray<NSString *> *titles;
@property (nonatomic, strong) JXCategoryTitleSortView *categoryView;
@property (strong, nonatomic) NSMutableArray *dataSorce;

@end

@implementation SearchResultViewController

#pragma mark - 切换tableview和collectionView

- (void)viewDidLoad {
    [super viewDidLoad];
    //0:主页排布方式为tableview 1:主页排布方式为collection
    _layerType = 0;
    self.dataSorce = @[].mutableCopy;
    [self initTopView];
    
    self.nav.searchTF.text = self.key;
    
    NSArray *title = @[@"日本药妆店便宜必败好物东京购物精华日东京购物精华"];
    for (int i = 0; i < 1; i++) {
        
        GoodsListVosModel *model = [[GoodsListVosModel alloc] init];
        model.goodsName = title[i];
        [self.dataSorce addObject:model];
    }
    
    self.homeTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.homeTable.delegate = self;
    self.homeTable.dataSource = self;
    self.homeTable.showsVerticalScrollIndicator = NO;
    self.homeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.homeTable.backgroundColor = UIColor.whiteColor;
    self.homeTable.layer.cornerRadius = 8;
    self.homeTable.layer.masksToBounds = YES;
    [self.view addSubview:self.homeTable];
    [self.homeTable registerClass:[ProductsCommentCell class] forCellReuseIdentifier:[ProductsCommentCell description]];
    
    LMJVerticalFlowLayout *layout = [[LMJVerticalFlowLayout alloc] initWithDelegate:self];

    self.homeCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0,KNavBarHeight + 50, ScreenWidth, ScreenHeight - KNavBarHeight - 50) collectionViewLayout:layout];
    if (@available(iOS 10.0, *)) {
        self.homeCollection.prefetchingEnabled = NO;
    } else {
         // Fallback on earlier versions
    }
    self.homeCollection.hidden = YES;
    self.homeCollection.backgroundColor = UIColor.clearColor;
    self.homeCollection.scrollEnabled = YES;
    self.homeCollection.dataSource = self;
    self.homeCollection.delegate = self;
    self.homeCollection.showsVerticalScrollIndicator = NO;
    self.homeCollection.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        self.homeCollection.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    [self.view addSubview:self.homeCollection];
    [self.homeCollection reloadData];
    [self.homeCollection registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
}
- (void)initTopView{
    
    self.topUtilityView = [[BaseTopSelectView alloc] init];
    self.topUtilityView.currentTitles = @[@"综合", @"销量", @"积分", @"价格"].mutableCopy;
    CJWeakSelf()
    self.topUtilityView.itemClickBlcok = ^(NSInteger index, BOOL isDescending) {
        CJStrongSelf()
        [self.homeTable reloadData];
        [self.homeCollection reloadData];
    };
    self.topUtilityView.typeClickBlcok = ^(BOOL isSelected) {
        CJStrongSelf()
        self->_layerType = 1 - isSelected;
        self.homeCollection.hidden = !self->_layerType;
        self.homeTable.hidden = self->_layerType;
    };
    [self.view addSubview:self.topUtilityView];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.topUtilityView.frame = CGRectMake(0, KNavBarHeight, ScreenWidth, 50);
    self.categoryView.frame = CGRectMake(0, 0, ScreenWidth - 60, 50);
    self.changeLayerBtn.frame = CGRectMake(ScreenWidth - 50, 0, 50, 50);
    self.homeTable.frame = CGRectMake(12, KNavBarHeight + 50 + 12, ScreenWidth - 24, ScreenHeight - KNavBarHeight - 50 - 24);
}
#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:[ProductsCommentCell description]];
    cell.bgViewContentInset = UIEdgeInsetsMake(0, 0, 0, 0);
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [AppTool GoToProductDetailWithID:@""];
}

#pragma mark - collectionViewDelegate datasorce--------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.dataSorce[indexPath.item];
    return cell;
}

#pragma mark - <LMJVerticalFlowLayoutDelegate>
- (CGFloat)waterflowLayout:(LMJVerticalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth
{
    GoodsListVosModel *model = self.dataSorce[indexPath.item];
    return model.height;
}
/**
 *  需要显示的列数, 默认3
 */
- (NSInteger)waterflowLayout:(LMJVerticalFlowLayout *)waterflowLayout columnsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
/**
 *  列间距, 默认10
 */
- (CGFloat)waterflowLayout:(LMJVerticalFlowLayout *)waterflowLayout columnsMarginInCollectionView:(UICollectionView *)collectionView
{
    return 7;
}
/**
 *  行间距, 默认10
 */
- (CGFloat)waterflowLayout:(LMJVerticalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView linesMarginForItemAtIndexPath:(NSIndexPath *)indexPath{

    return 8;
}

/**
 *  距离collectionView四周的间距, 默认{20, 10, 10, 10}
 */
- (UIEdgeInsets)waterflowLayout:(LMJVerticalFlowLayout *)waterflowLayout edgeInsetsInCollectionView:(UICollectionView *)collectionView
{
    return UIEdgeInsetsMake(12, 12, 0, 12);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [AppTool GoToProductDetailWithID:@""];
}

@end

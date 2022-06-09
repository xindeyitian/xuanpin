//
//  CategoryDetailViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/11.
//

#import "CategoryDetailViewController.h"
#import "CategoryPopView.h"
#import "HomeCollectionViewCell.h"

@interface CategoryDetailViewController ()<JXCategoryViewDelegate,THFlowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) JXCategoryTitleSortView *categoryView;//菜单标题view
@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (strong, nonatomic) UICollectionView *homeCollection;
@property (strong, nonatomic) NSMutableArray *dataSorce;

@end

@implementation CategoryDetailViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    SetIOS13
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @[@"综合", @"价格", @"销量", @"分类"].mutableCopy;
    self.categoryView = [[JXCategoryTitleSortView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 42)];
    self.categoryView.delegate = self;
    self.categoryView.titles = self.titles;
    self.categoryView.uiTypes = @{@(0) : @(JXCategoryTitleSortUIType_ArrowNone),
                                  @(1) : @(JXCategoryTitleSortUIType_ArrowBoth),
                                    @(2) : @(JXCategoryTitleSortUIType_ArrowBoth),
                                    @(3) : @(JXCategoryTitleSortUIType_SingleImage)}.mutableCopy;
    self.categoryView.arrowDirections = @{@(1) : @(JXCategoryTitleSortArrowDirection_Both),
                                          @(2) : @(JXCategoryTitleSortArrowDirection_Both)
    }.mutableCopy;
    self.categoryView.contentEdgeInsetLeft = self.categoryView.contentEdgeInsetRight = 16;
    self.categoryView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.categoryView];
    
    JXCategoryIndicatorAlignmentLineView *line = [[JXCategoryIndicatorAlignmentLineView alloc] init];
    line.indicatorColor = UIColor.redColor;
    line.indicatorHeight = 2;
    line.indicatorWidth = JXCategoryViewAutomaticDimension;
    self.categoryView.indicators = @[line];
    
    self.dataSorce = @[].mutableCopy;
    NSArray *title = @[@"日本药妆店便宜必败好物东京购物精华日东京购物精华",@"日本药妆店便宜必败好物东京购物精华",@"日本药妆店便宜必败好物东京购物精华",@"日本药妆店便宜必败好物本药妆店便宜必败好物本药妆店便宜必败好物东京购物精华",@"日本药妆店便宜必败好物东京本药妆店便宜必败好物购物精华",@"日本药妆本药妆店便宜必败好物本药妆店便宜必败好物本药妆店便宜必败好物店便宜必败好物东京购物精华",@"日本药妆店便宜必败好物东京购物精华",@"日本药妆店便宜必败好本药妆店便宜必败好物物东京购物精华",@"日本药妆店便宜必败好物东本药妆店便宜必败好物本药妆店便宜必败好物本药妆店便宜必败好物京购物精华",@"日本药妆店便宜必败好物东本药妆店便宜必败好物京购物精华"];
    for (int i = 0; i < 10; i++) {
        
        GoodsListVosModel *model = [[GoodsListVosModel alloc] init];
        model.goodsName = title[i];
        [self.dataSorce addObject:model];
    }
    
    THFlowLayout *layout = [[THFlowLayout alloc] init];
    layout.delegate = self;
    layout.columnMargin = 8;
    layout.rowMargin = 8;
    layout.columnsCount = 2;
    layout.headerReferenceSize = CGSizeMake(ScreenWidth, 0);
    layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
    layout.isHeaderStick = YES;

    self.homeCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 42, ScreenWidth, ScreenHeight - KNavBarHeight - 42) collectionViewLayout:layout];
     self.homeCollection.prefetchingEnabled = NO;
    self.homeCollection.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
    self.homeCollection.scrollEnabled = YES;
    self.homeCollection.dataSource = self;
    self.homeCollection.delegate = self;
    self.homeCollection.showsVerticalScrollIndicator = NO;
    self.homeCollection.showsHorizontalScrollIndicator = NO;
    self.homeCollection.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:self.homeCollection];
    [self.homeCollection reloadData];
    [self.homeCollection registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
    
}
#pragma mark - collectionViewDelegate datasorce--------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.dataSorce[indexPath.item];
    return cell;
}
- (CGFloat)waterflowLayout:(THFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    GoodsListVosModel *model = self.dataSorce[indexPath.item];
    return model.height;
}
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    
    JXCategoryTitleSortArrowDirection currentPriceDirection = (JXCategoryTitleSortArrowDirection)(self.categoryView.arrowDirections[@(1)].integerValue);
    JXCategoryTitleSortArrowDirection currentPriceDirection1 = (JXCategoryTitleSortArrowDirection)(self.categoryView.arrowDirections[@(2)].integerValue);

    if (index == 1) {
        self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Both);
        
        if (currentPriceDirection == JXCategoryTitleSortArrowDirection_Both) {
            
            self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Up);
        }else if (currentPriceDirection == JXCategoryTitleSortArrowDirection_Up){
            
            self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Down);
        }else{
            
            self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Up);
        }
        [self.categoryView reloadData];
    }else if (index == 2){
        
        self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Both);
        if (currentPriceDirection1 == JXCategoryTitleSortArrowDirection_Both) {
            
            self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Up);
        }else if (currentPriceDirection1 == JXCategoryTitleSortArrowDirection_Up){
            
            self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Down);
        }else{
            
            self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Up);
        }
        [self.categoryView reloadData];
    }else if (index == 3){
        
        
    }else{
        
        [self.categoryView reloadData];
    }
}
- (BOOL)categoryView:(JXCategoryBaseView *)categoryView canClickItemAtIndex:(NSInteger)index {
    if (index == 3) {
        
        [[CategoryPopView shareInstance] popCategroyView];
        return NO;
    }
    return YES;
}
@end

//
//  MerchantDetailIProductViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/11.
//

#import "MerchantDetailIProductViewController.h"
#import "HomeCollectionViewCell.h"
#import "ProductTopView.h"

@interface MerchantDetailIProductViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,THFlowLayoutDelegate>

@property (copy,   nonatomic) void(^scrollCallback)(UIScrollView *scrollView);
@property (strong, nonatomic) UICollectionView *merchantCollection;
@property (strong, nonatomic) NSMutableArray *dataSorce;
@property (strong, nonatomic) ProductTopView *topView;

@end

@implementation MerchantDetailIProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    layout.headerReferenceSize = CGSizeMake(ScreenWidth, 208);
    layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
    layout.isHeaderStick = YES;
    layout.stickHight = 40;

    self.merchantCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 210) collectionViewLayout:layout];
    self.merchantCollection.scrollEnabled = YES;
    self.merchantCollection.dataSource = self;
    self.merchantCollection.delegate = self;
    self.merchantCollection.showsVerticalScrollIndicator = NO;
    self.merchantCollection.showsHorizontalScrollIndicator = NO;
    self.merchantCollection.backgroundColor = KViewBGColor;
    [self.view addSubview:self.merchantCollection];
    [self.merchantCollection reloadData];
    [self.merchantCollection registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
    [self.merchantCollection registerClass:[ProductTopView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ProductTopView"];
}
#pragma mark - collectionViewDelegate datasorce--------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.dataSorce[indexPath.item];
    return cell;
}
//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView =nil;
    //返回段头段尾视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        self.topView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ProductTopView" forIndexPath:indexPath];
        self.topView.frame = CGRectMake(0, 0, ScreenWidth, 208);
        //添加头视图的内容
        reusableView = self.topView;
        return reusableView;
    }
    return reusableView;
}

- (CGFloat)waterflowLayout:(THFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    GoodsListVosModel *model = self.dataSorce[indexPath.item];
    return model.height;
}

#pragma mark - JXCategoryListContentViewDelegate -
- (UIScrollView *)listScrollView {
    return self.merchantCollection;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self.view;
}

@end

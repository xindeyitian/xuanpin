//
//  CategoryRightCollectionView.m
//  SmallB
//
//  Created by zhang on 2022/4/18.
//

#import "CategoryRightCollectionView.h"
#import "CategoryCategoryCollectionViewCell.h"

@interface CJCategoryRightHeaderView : UICollectionReusableView
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIView *lineView;
@property(nonatomic,strong)void(^pushToDetailBlock)(void);
@end

@implementation CJCategoryRightHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KWhiteBGColor;
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,  5, self.width -32, 30)];
    titleLabel.textAlignment = 0;
    self.titleLabel = titleLabel;
    titleLabel.font = DEFAULT_FONT_M(15);
    titleLabel.textColor = KBlack333TextColor;
    titleLabel.text = @"二级分类";
    [self addSubview:titleLabel];
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, self.width, 1)];
    self.lineView.backgroundColor = KBlackLineColor;
    //[self addSubview:self.lineView];

    UIImageView * imgV = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-17, 0, 7, 15)];
    imgV.image = [UIImage imageNamed:@"arrow"];
    imgV.centerY = self.height/2.0;
    //[self addSubview:imgV];
    
    self.userInteractionEnabled = 1;
    UITapGestureRecognizer * gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToDetail)];
    [self addGestureRecognizer:gest];
}

-(void)pushToDetail{
    if (_pushToDetailBlock){
        _pushToDetailBlock();
    }
}

@end

@interface CJCategoryRightSectionOneHeaderView : UICollectionReusableView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *photoImgV;
@property (nonatomic, strong) NSMutableArray *bannerAry;
@property (nonatomic, strong) SDCycleScrollView *bannerCycle;

@end

@implementation CJCategoryRightSectionOneHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KWhiteBGColor;
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,  105, self.width -32, 35)];
    titleLabel.textAlignment = 0;
    self.titleLabel = titleLabel;
    titleLabel.font = DEFAULT_FONT_M(15);
    titleLabel.textColor = KBlack333TextColor;
    titleLabel.text = @"二级分类";
    [self addSubview:titleLabel];
    
    self.bannerCycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
    self.bannerCycle.imageURLStringsGroup = @[];
    self.bannerCycle.frame = CGRectMake(10, 12, self.width - 20, 90);
    self.bannerCycle.autoScroll = YES;
    self.bannerCycle.showPageControl = YES;
    self.bannerCycle.pageControlDotSize = CGSizeMake(10, 10);
    self.bannerCycle.currentPageDotImage = IMAGE_NAMED(@"banner_select_image");
    self.bannerCycle.pageDotImage = IMAGE_NAMED(@"banner_normal_image");
    self.bannerCycle.backgroundColor = UIColor.clearColor;
    self.bannerCycle.clipsToBounds = YES;
    self.bannerCycle.layer.cornerRadius = 6;
    [self addSubview:self.bannerCycle];
    
    self.userInteractionEnabled = 1;
    UITapGestureRecognizer * gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToDetail)];
    [self addGestureRecognizer:gest];
}

- (void)setBannerAry:(NSMutableArray *)bannerAry{
    _bannerAry = bannerAry;
    self.bannerCycle.imageURLStringsGroup = _bannerAry;
}

-(void)pushToDetail{
    
}

@end

@interface CJCategoryRightFooterView : UICollectionReusableView
@property (nonatomic, retain) UIView *lineView;
@end

@implementation CJCategoryRightFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KBlackLineColor;
    }
    return self;
}
@end


@interface CategoryRightCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation CategoryRightCollectionView


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self == [super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = KWhiteBGColor;
        [self registerClass:[CategoryCategoryCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        [self registerClass:NSClassFromString(@"CJCategoryRightHeaderView")  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CJCategoryRightHeaderView"];
        [self registerClass:NSClassFromString(@"CJCategoryRightFooterView")  forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CJCategoryRightFooterView"];
        [self registerClass:NSClassFromString(@"CJCategoryRightSectionOneHeaderView")  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CJCategoryRightSectionOneHeaderView"];
    }
    return self;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat width = ScreenWidth - 105 - 40;
    if (section == 0) {
        GoodsCategoryListVosModel *model = self.dataAry[section];
        if (model.bannerUrls.count) {
            return CGSizeMake(width, 143);
        }
        return CGSizeMake(width, 43);
    }
    return CGSizeMake(width, 43);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        if (indexPath.section == 0) {
            GoodsCategoryListVosModel *cateModel = self.dataAry[0];
            if (cateModel.bannerUrls.count) {
                CJCategoryRightSectionOneHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CJCategoryRightSectionOneHeaderView" forIndexPath:indexPath];
                if (self.currentAry.count) {
                    HomeListVosModel *model = self.currentAry[indexPath.section];
                    headerView.titleLabel.text = model.categoryName;
                    headerView.bannerAry = cateModel.bannerUrls;
                }
                return headerView;
            }
            CJCategoryRightHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CJCategoryRightHeaderView" forIndexPath:indexPath];
            if (self.currentAry.count) {
                HomeListVosModel *model = self.currentAry[indexPath.section];
                headerView.titleLabel.text = model.categoryName;
            }
            return headerView;
        }
        CJCategoryRightHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CJCategoryRightHeaderView" forIndexPath:indexPath];
        if (self.currentAry.count) {
            HomeListVosModel *model = self.currentAry[indexPath.section];
            headerView.titleLabel.text = model.categoryName;
        }
        return headerView;
    } else {
        CJCategoryRightFooterView * footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CJCategoryRightFooterView" forIndexPath:indexPath];
        return footerView;
    }
}

- (void)setDataAry:(NSMutableArray *)dataAry{
    _dataAry = dataAry;
    self.currentAry = [NSMutableArray array];
    if (_dataAry.count) {
        GoodsCategoryListVosModel *model = _dataAry[0];
        self.currentAry = model.listVos;
        [self reloadData];
    }
}

-(void)setDataWithDataAry:(NSMutableArray*)allAry withSelectedRow:(NSInteger)Row
{
    if (allAry.count) {
        GoodsCategoryListVosModel *model = allAry[Row];
        self.currentAry = model.listVos;
        [self reloadData];
    }
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.currentAry.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.currentAry.count) {
        HomeListVosModel *model = self.currentAry[section];
        return model.listVos.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (self.currentAry.count) {
        HomeListVosModel *model = self.currentAry[indexPath.section];
        HomeListVosModel *currentModel = model.listVos[indexPath.item];
        cell.goodNameLabel.text = currentModel.categoryName;

        [cell.goodImageView sd_setImageWithURL:[NSURL URLWithString:[AppTool dealChineseUrl:currentModel.categoryThumb]] placeholderImage:KPlaceholder_DefaultImage];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentAry.count) {
        HomeListVosModel *model = self.currentAry[indexPath.section];
        HomeListVosModel *currentModel = model.listVos[indexPath.item];
        if (_CellSelectedBlock)
        { _CellSelectedBlock(currentModel.categoryName,currentModel.categoryId);
        }
    }
}

@end


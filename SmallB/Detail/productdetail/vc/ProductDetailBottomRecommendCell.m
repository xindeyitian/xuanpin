//
//  ProductDetailRecommendCell.m
//  SmallB
//
//  Created by zhang on 2022/5/24.
//

#import "ProductDetailBottomRecommendCell.h"
#import "HomeCollectionViewCell.h"
#import "ProductDetailViewController.h"

static NSString *identify = @"HomeCollectionViewCell";

@interface ProductDetailBottomRecommendCell()<UICollectionViewDelegate,UICollectionViewDataSource,THFlowLayoutDelegate,JXCategoryViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) THFlowLayout         *layout;

@end

@implementation ProductDetailBottomRecommendCell

- (void)setDataAry:(NSMutableArray *)dataAry{
    _dataAry = dataAry;
    [self.collectionView reloadData];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initCell];
    }
    return self;
}
- (void)initCell{
    
    self.contentView.backgroundColor = KBGColor;
    
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(12);
        make.right.mas_equalTo(self.contentView).offset(-12);
    }];
    [self.collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGFloat height = self.collectionView.contentSize.height;
        [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(12);
            make.right.mas_equalTo(self.contentView).offset(-12);
            make.height.equalTo(@(height));
        }];
        if (_heightBlock) {
            _heightBlock(height);
        }
    }
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataAry.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.model = self.dataAry[indexPath.item];
    cell.rootLy.backgroundColor = KWhiteBGColor;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsListVosModel *model = self.dataAry[indexPath.item];
    [AppTool GoToProductDetailWithID:model.goodsId];
}
- (CGFloat)waterflowLayout:(THFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    GoodsListVosModel *model = self.dataAry[indexPath.item];
    return model.height;
}
#pragma mark - getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        _layout = [[THFlowLayout alloc] init];
        _layout.delegate = self;
        _layout.columnMargin = 8;
        _layout.rowMargin = 8;
        _layout.columnsCount = 2;
        _layout.headerReferenceSize = CGSizeMake(ScreenWidth, 0);
        _layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        _collectionView.backgroundColor = KBGColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:identify];
    }
    return _collectionView;
}
@end

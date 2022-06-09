//
//  THFlowLayout.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/7.
//

#import <UIKit/UIKit.h>
#import "THFlowLayout.h"

@interface THFlowLayout();
/** 这个字典用来存储每一列最大的Y值(每一列的高度) */
@property (nonatomic, strong) NSMutableDictionary *maxYDict;

/** 存放所有的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;

@end

@implementation THFlowLayout
- (NSMutableDictionary *)maxYDict
{
    if (!_maxYDict) {
        self.maxYDict = [[NSMutableDictionary alloc] init];
    }
    return _maxYDict;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        self.attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.columnMargin = 10;
        self.rowMargin = 10;
        self.sectionInset = UIEdgeInsetsMake(8, 0, 8, 0);
        self.columnsCount = 3;
        //如果段头的高度不一致 可以仿照UICollectionViewFlowLayout的代理 自己写一个代理方法返回 CGSize
        self.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 0);
        self.isHeaderStick = NO;
        self.stickHight = 0.0;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 *  每次布局之前的准备
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    // 1.清空最大的Y值
    [self.maxYDict removeAllObjects];

    for (int i = 0; i<self.columnsCount; i++) {
        NSString *column = [NSString stringWithFormat:@"%d", i];
        self.maxYDict[column] = @(self.sectionInset.top);
    }
    
    // 2.计算所有cell的属性
    [self.attrsArray removeAllObjects];
    
    //头部视图
    UICollectionViewLayoutAttributes * layoutHeader = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathWithIndex:0]];
    layoutHeader.frame =CGRectMake(0,0, self.headerReferenceSize.width, self.headerReferenceSize.height);
    [self.attrsArray addObject:layoutHeader];

    //item内容视图
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i<count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attrs];
    }
}

/**
 *  返回所有的尺寸
 */
- (CGSize)collectionViewContentSize
{
    __block NSString *maxColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.maxYDict[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
    
    //包括段头headerView的高度
    return CGSizeMake(0, [self.maxYDict[maxColumn] floatValue] + self.sectionInset.bottom + self.headerReferenceSize.height );
}

/**
 *  返回indexPath这个位置Item的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 假设最短的那一列的第0列
    __block NSString *minColumn = @"0";
    // 找出最短的那一列
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] < [self.maxYDict[minColumn] floatValue]) {
            minColumn = column;
        }
    }];
    
    // 计算尺寸
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.columnsCount - 1) * self.columnMargin)/self.columnsCount;
    CGFloat height = [self.delegate waterflowLayout:self heightForWidth:width atIndexPath:indexPath];
    
    // 计算位置
    CGFloat x = self.sectionInset.left + (width + self.columnMargin) * [minColumn intValue];
    CGFloat y = [self.maxYDict[minColumn] floatValue] + self.rowMargin;
    
    // 更新这一列的最大Y值
    self.maxYDict[minColumn] = @(y + height);
    
    // 创建属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //把瀑布流的Cell的起始位置从headerView的最大Y开始布局
    attrs.frame = CGRectMake(x, self.headerReferenceSize.height + y, width, height );
    return attrs;
}
#pragma mark - Header停留算法
- (void)sectionHeaderStickCounter
{
    if (self.isHeaderStick) {
        
        for (UICollectionViewLayoutAttributes *layoutAttributes in self.attrsArray) {
            if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
                // 这里第1个cell是根据自己存放attribute的数组而定的
                if (self.attrsArray.count < 2) {
                    return;
                }
                UICollectionViewLayoutAttributes *firstCellAttrs = self.attrsArray[1];
                
                CGFloat headerHeight = CGRectGetHeight(layoutAttributes.frame);
                CGPoint origin = layoutAttributes.frame.origin;
                // 悬停临界点的计算，self.stickHight默认设置为64
                if (headerHeight - self.collectionView.contentOffset.y <= self.stickHight) {
                    
                    origin.y = self.collectionView.contentOffset.y - (headerHeight - self.stickHight);
                }
                
                CGFloat width = layoutAttributes.frame.size.width;
                
                layoutAttributes.zIndex = 2048;//设置一个比cell的zIndex大的值
                layoutAttributes.frame = (CGRect){
                    .origin = origin,
                    .size = CGSizeMake(width, layoutAttributes.frame.size.height)
                };
            }
        }
    }
}
/**
 *  返回rect范围内的布局属性
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    if (self.isHeaderStick) {
        [self sectionHeaderStickCounter];//计算Header停留
    }
    
    return self.attrsArray;
}
@end

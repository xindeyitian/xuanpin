//
//  ProductTopView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/11.
//

#import "ProductTopView.h"

@interface ProductTopView()<JXCategoryViewDelegate,SDCycleScrollViewDelegate>

@property (strong, nonatomic) MyLinearLayout    *rootLy;
@property (strong, nonatomic) SDCycleScrollView *cycleView;
@property (nonatomic, strong) NSMutableArray<NSString *> *titles;
@property (nonatomic, strong) JXCategoryTitleSortView *categoryView;

@end

@implementation ProductTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.gravity = MyGravity_Horz_Center;
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = 208;
    self.rootLy.backgroundColor = UIColor.whiteColor;
    self.rootLy.subviewVSpace = 12;
    [self addSubview:self.rootLy];
    
    self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:KPlaceholder_DefaultImage];
    self.cycleView.myHorzMargin = 12;
    self.cycleView.myHeight = 140;
    self.cycleView.myTop = 12;
    self.cycleView.showPageControl = NO;
    self.cycleView.layer.cornerRadius = 12;
    self.cycleView.layer.masksToBounds = YES;
    [self.rootLy addSubview:self.cycleView];
    
    self.titles = @[@"综合", @"价格", @"销量"].mutableCopy;
    self.categoryView = [[JXCategoryTitleSortView alloc] init];
    self.categoryView.myHorzMargin = 0;
    self.categoryView.myHeight = 40;
    self.categoryView.delegate = self;
    self.categoryView.titles = self.titles;
    self.categoryView.uiTypes = @{@(0) : @(JXCategoryTitleSortUIType_ArrowNone),
                                  @(1) : @(JXCategoryTitleSortUIType_ArrowBoth),
                                    @(2) : @(JXCategoryTitleSortUIType_ArrowBoth)}.mutableCopy;
    self.categoryView.arrowDirections = @{@(1) : @(JXCategoryTitleSortArrowDirection_Both),
                                          @(2) : @(JXCategoryTitleSortArrowDirection_Both)
    }.mutableCopy;
    [self.rootLy addSubview:self.categoryView];
    
    JXCategoryIndicatorAlignmentLineView *line = [[JXCategoryIndicatorAlignmentLineView alloc] init];
    line.indicatorColor = UIColor.redColor;
    line.indicatorHeight = 2;
    line.indicatorWidth = 40;
    self.categoryView.indicators = @[line];
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
    }
}
@end

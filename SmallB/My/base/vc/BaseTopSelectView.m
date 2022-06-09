//
//  BaseTopSelectView.m
//  SmallB
//
//  Created by zhang on 2022/4/21.
//

#import "BaseTopSelectView.h"

@interface BaseTopSelectView ()<JXCategoryViewDelegate>

@property (strong, nonatomic) UIView *topUtilityView;
@property (nonatomic, strong) JXCategoryTitleSortView *categoryView;
@property (strong, nonatomic) UIButton *changeLayerBtn;
@property (nonatomic, strong) NSMutableArray<NSString *> *titles;

@end

@implementation BaseTopSelectView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    
    self.topUtilityView = [[UIView alloc] init];
    self.topUtilityView.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.topUtilityView];
    
    self.titles = @[@"综合", @"销量", @"积分", @"价格"].mutableCopy;
    self.categoryView = [[JXCategoryTitleSortView alloc] init];
    self.categoryView.delegate = self;
    self.categoryView.titles = self.titles;
    
    self.categoryView.uiTypes = @{@(0) : @(JXCategoryTitleSortUIType_ArrowNone),
                                  @(1) : @(JXCategoryTitleSortUIType_ArrowBoth),
                                    @(2) : @(JXCategoryTitleSortUIType_ArrowBoth),
                                    @(3) : @(JXCategoryTitleSortUIType_ArrowBoth)}.mutableCopy;
    self.categoryView.arrowDirections = @{@(1) : @(JXCategoryTitleSortArrowDirection_Both),
                                          @(2) : @(JXCategoryTitleSortArrowDirection_Both),
                                          @(3) : @(JXCategoryTitleSortArrowDirection_Both)}.mutableCopy;
    [self.topUtilityView addSubview:self.categoryView];
    
    self.changeLayerBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(changeLayer:) Font:[UIFont systemFontOfSize:10] BackgroundColor:UIColor.whiteColor Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:2];
    [self.changeLayerBtn setImage:IMAGE_NAMED(@"changeLayer") forState:UIControlStateNormal];
    [self.changeLayerBtn setImage:IMAGE_NAMED(@"collection") forState:UIControlStateSelected];
    self.changeLayerBtn.imageView.hidden = NO;
    [self.topUtilityView addSubview:self.changeLayerBtn];
    
    self.topUtilityView.frame = CGRectMake(0, 0, ScreenWidth, 50);
    self.categoryView.frame = CGRectMake(0, 0, ScreenWidth - 60, 50);
    self.changeLayerBtn.frame = CGRectMake(ScreenWidth - 50, 0, 50, 50);
}

- (void)changeLayer:(UIButton *)sender{
    
    if (_typeClickBlcok) {
        _typeClickBlcok(sender.selected);
    }
    sender.selected = !sender.isSelected;
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
  
    JXCategoryTitleSortArrowDirection currentPriceDirection1 = (JXCategoryTitleSortArrowDirection)(self.categoryView.arrowDirections[@(1)].integerValue);
    JXCategoryTitleSortArrowDirection currentPriceDirection2 = (JXCategoryTitleSortArrowDirection)(self.categoryView.arrowDirections[@(2)].integerValue);
    JXCategoryTitleSortArrowDirection currentPriceDirection3 = (JXCategoryTitleSortArrowDirection)(self.categoryView.arrowDirections[@(3)].integerValue);
    if (index == 1) {
        self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Both);
        self.categoryView.arrowDirections[@(3)] = @(JXCategoryTitleSortArrowDirection_Both);
        if (currentPriceDirection1 == JXCategoryTitleSortArrowDirection_Both) {
            self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Up);
        }else if (currentPriceDirection1 == JXCategoryTitleSortArrowDirection_Up){
            self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Down);
        }else{
            self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Up);
        }
        [self.categoryView reloadData];
    }else if (index == 2){
        self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Both);
        self.categoryView.arrowDirections[@(3)] = @(JXCategoryTitleSortArrowDirection_Both);
        if (currentPriceDirection2 == JXCategoryTitleSortArrowDirection_Both) {
            self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Up);
        }else if (currentPriceDirection2 == JXCategoryTitleSortArrowDirection_Up){
            self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Down);
        }else{
            self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Up);
        }
        [self.categoryView reloadData];
    }else if (index == 3){
        
        self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Both);
        self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Both);
        if (currentPriceDirection3 == JXCategoryTitleSortArrowDirection_Both) {
            self.categoryView.arrowDirections[@(3)] = @(JXCategoryTitleSortArrowDirection_Up);
        }else if (currentPriceDirection3 == JXCategoryTitleSortArrowDirection_Up){
            self.categoryView.arrowDirections[@(3)] = @(JXCategoryTitleSortArrowDirection_Down);
        }else{
            self.categoryView.arrowDirections[@(3)] = @(JXCategoryTitleSortArrowDirection_Up);
        }
        [self.categoryView reloadData];
    }else{
        self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Both);
        self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Both);
        self.categoryView.arrowDirections[@(3)] = @(JXCategoryTitleSortArrowDirection_Both);
        [self.categoryView reloadData];
    }
    
    BOOL isDescending = [self.categoryView.arrowDirections[@(index)]  isEqual: @(JXCategoryTitleSortArrowDirection_Up)];
    if (_itemClickBlcok) {
        _itemClickBlcok(index,isDescending);
    }
}

- (void)setHiddenAllBtn:(BOOL)hiddenAllBtn{
    _hiddenAllBtn = hiddenAllBtn;
    
    self.changeLayerBtn.hidden = _hiddenAllBtn;
    self.categoryView.frame = CGRectMake(0, 0, _hiddenAllBtn ? ScreenWidth : ScreenWidth - 60, 50);
}

- (void)setCurrentTitles:(NSMutableArray<NSString *> *)currentTitles{
    _currentTitles = currentTitles;
    self.titles = _currentTitles;
    self.categoryView.titles = self.titles;
    [self.categoryView reloadData];
}

@end

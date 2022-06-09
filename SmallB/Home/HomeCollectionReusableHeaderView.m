//
//  HomeCollectionReusableHeaderView.m
//  SmallB
//
//  Created by zhang on 2022/4/29.
//

#import "HomeCollectionReusableHeaderView.h"

@implementation HomeCollectionReusableHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
     
    self.backgroundColor = UIColor.clearColor;
    
    self.topView = [[HomeTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,self.frame.size.height - 44*KScreenW_Ratio )];
    self.topView.backgroundColor = KWhiteBGColor;
    [self addSubview:self.topView];
    
    self.topUtilityView = [[BaseTopSelectView alloc] init];
    self.topUtilityView.hiddenAllBtn = YES;
    self.topUtilityView.frame = CGRectMake(0, self.frame.size.height - 44*KScreenW_Ratio , ScreenWidth, 44*KScreenW_Ratio);
    [self addSubview:self.topUtilityView];

    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 0, ScreenWidth, 0)];
    bottomV.backgroundColor = KBGColor;
    //[self addSubview:bottomV];
}

- (void)setCategoryModel:(GoodsCategoryListVosModel *)categoryModel{
    _categoryModel = categoryModel;
    self.topView.categoryModel = categoryModel;
    self.topView.frame = CGRectMake(0, 0, ScreenWidth,self.frame.size.height - 44*KScreenW_Ratio);
}

@end

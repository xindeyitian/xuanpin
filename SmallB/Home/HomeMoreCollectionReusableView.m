//
//  HomeMoreCollectionReusableView.m
//  SmallB
//
//  Created by zhang on 2022/5/1.
//

#import "HomeMoreCollectionReusableView.h"

@implementation HomeMoreCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    
    UIImageView *topBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 233*KScreenW_Ratio)];
    topBackView.userInteractionEnabled = YES;
    [self addSubview:topBackView];
    self.topBackV = topBackView;
    
    _topView = [[BaseTopSelectView alloc]initWithFrame:CGRectMake(0,233*KScreenW_Ratio - 8 , ScreenWidth, 50)];
    _topView.hiddenAllBtn = YES;
    [self addSubview:_topView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_topView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _topView.bounds;
    maskLayer.path = maskPath.CGPath;
    _topView.layer.mask = maskLayer;
}

@end

//
//  ProductDetailGuiGeHeaderView.m
//  SmallB
//
//  Created by zhang on 2022/4/25.
//

#import "ProductDetailGuiGeHeaderView.h"

@implementation ProductDetailGuiGeHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
   
    self.backgroundColor = UIColor.clearColor;
    
    UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    whiteV.backgroundColor = KWhiteBGColor;
    [self addSubview:whiteV];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:whiteV.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = whiteV.bounds;
    maskLayer.path = maskPath.CGPath;
    whiteV.layer.mask = maskLayer;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 37, 12, 25, 25)];
    [btn setBackgroundImage:IMAGE_NAMED(@"supplier_add_photo_delete") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [whiteV addSubview:btn];

    UILabel *title = [UILabel creatLabelWithTitle:@"产品参数" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(17)];
    title.frame = CGRectMake(0, 12, 180, 25);
    title.centerX = whiteV.centerX;
    [whiteV addSubview:title];
}

- (void)closeClick{
    [[AppTool currentVC] dismissViewControllerAnimated:NO completion:nil];
}

@end


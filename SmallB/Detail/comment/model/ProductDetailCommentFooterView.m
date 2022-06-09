//
//  ProductDetailCommentFooterView.m
//  SmallB
//
//  Created by zhang on 2022/4/24.
//

#import "ProductDetailCommentFooterView.h"
#import "ProductDetailCommentViewController.h"

@implementation ProductDetailCommentFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
   
    self.backgroundColor = KBGColor;
    
    UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(12, 0, ScreenWidth - 24, self.frame.size.height-12)];
    whiteV.backgroundColor = KWhiteBGColor;
    [self addSubview:whiteV];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:whiteV.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = whiteV.bounds;
    maskLayer.path = maskPath.CGPath;
    whiteV.layer.mask = maskLayer;
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"查看更多评价" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_R(13) BackgroundColor:UIColor.clearColor Color:KBlack333TextColor Frame:CGRectMake(0, 4, 125, 40) Alignment:NSTextAlignmentCenter Tag:3];
    btn.centerX = self.centerX;;
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 20;
    btn.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
    btn.layer.borderWidth = 1;
    [self addSubview:btn];
}

- (void)btnClick{
    ProductDetailCommentViewController *vc = [[ProductDetailCommentViewController alloc]init];
    [[THAPPService shareAppService].currentViewController.navigationController pushViewController:vc animated:YES];
}

@end

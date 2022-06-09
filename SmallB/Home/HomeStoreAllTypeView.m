//
//  HomeStoreAllTypeView.m
//  SmallB
//
//  Created by zhang on 2022/4/28.
//

#import "HomeStoreAllTypeView.h"

@implementation HomeStoreAllTypeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    self.backgroundColor = kRGBA(0,0,0,0.55);
}

- (void)setTitleAry:(NSMutableArray *)titleAry{
    
    UIView *whiteV = [[UIView alloc]init];
    whiteV.backgroundColor = KWhiteBGColor;
    [self addSubview:whiteV];
    
    float btnWidth = (ScreenWidth - 48)/3.0;
    float y = .0f;
    for (int i =0; i < titleAry.count; i ++) {
        BaseButton *btn = [BaseButton CreateBaseButtonTitle:titleAry[i] Target:self Action:@selector(btnClick:) Font:DEFAULT_FONT_R(15) BackgroundColor:KBGLightColor Color:KBlack333TextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:10+i];
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = 16;
        btn.frame = CGRectMake(12 + (btnWidth + 12) *(i%3), 20 + (32 + 12) *(i/3), btnWidth, 32);
        [whiteV addSubview:btn];
        if (i == titleAry.count - 1) {
            y = CGRectGetMaxY(btn.frame)+16;
        }
    }
    whiteV.frame = CGRectMake(0, 0, ScreenWidth, y);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:whiteV.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = whiteV.bounds;
    maskLayer.path = maskPath.CGPath;
    whiteV.layer.mask = maskLayer;
}

- (void)setIndex:(NSInteger)index{
    BaseButton *btn = [self viewWithTag:10+index];
    btn.selected = YES;
    btn.backgroundColor = [UIColor colorWithHexString:@"#FAEDEB"];
}

-(void)btnClick:(BaseButton *)btn{
    if (_btnClickBlock) {
        _btnClickBlock(btn.tag - 10,btn.titleLabel.text);
    }
}

@end

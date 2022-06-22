//
//  ProductDetailSKUHeaderView.m
//  SmallB
//
//  Created by zhang on 2022/4/25.
//

#import "ProductDetailSKUHeaderView.h"

@interface ProductDetailSKUHeaderView ()

@property (nonatomic , strong)UIImageView *imageV;
@property (nonatomic , strong)UILabel *nameL;
@property (nonatomic , strong)UILabel *priceL;
@property (nonatomic , strong)UILabel *zhuanL;

@end

@implementation ProductDetailSKUHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
   
    self.backgroundColor = UIColor.clearColor;
    
    UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
    whiteV.backgroundColor = KWhiteBGColor;
    [self addSubview:whiteV];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:whiteV.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = whiteV.bounds;
    maskLayer.path = maskPath.CGPath;
    whiteV.layer.mask = maskLayer;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 32, 14, 20, 20)];
    [btn setBackgroundImage:IMAGE_NAMED(@"supplier_add_photo_delete") forState:UIControlStateNormal];
    [btn setBackgroundImage:IMAGE_NAMED(@"supplier_add_photo_delete") forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [whiteV addSubview:btn];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:nil];
    image.frame = CGRectMake(12, 12, 90, 90);
    self.imageV = image;
    [whiteV addSubview:image];
    
    UILabel *name = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(15)];
    name.frame = CGRectMake(112, 12, ScreenWidth - 112 - 37, 45);
    name.numberOfLines = 2;
    [whiteV addSubview:name];
    self.nameL = name;
    
    UILabel *price = [UILabel creatLabelWithTitle:@"" textColor:KMaintextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(18)];
    price.frame = CGRectMake(112, 60, ScreenWidth - 112 - 37, 20);
    [whiteV addSubview:price];
    self.priceL = price;
    
    UILabel *zhuan = [UILabel creatLabelWithTitle:@"" textColor:KOrangeTextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(12)];
    zhuan.frame = CGRectMake(112, 90, ScreenWidth - 112 - 37, 15);
    [whiteV addSubview:zhuan];
    self.zhuanL = zhuan;
}

- (void)setModel:(ProductDetailModel *)model{
    _model = model;
    if (_model.productImgAry.count) {
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:_model.productImgAry[0]] placeholderImage:KPlaceholder_DefaultImage];
    }
    self.nameL.text = model.goodsName;
    self.priceL.text = [NSString stringWithFormat:@"¥ %@",model.salePrice];
    self.zhuanL.text = [NSString stringWithFormat:@"赚积分 %@",model.commission];
}

- (void)closeClick{
    [[AppTool currentVC] dismissViewControllerAnimated:NO completion:nil];
}

@end

//
//  myOrderListContentTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/8.
//

#import "myOrderListContentTableViewCell.h"

@interface myOrderListContentTableViewCell ()

@property(nonatomic , strong)UIImageView *productImg;
@property(nonatomic , strong)UILabel *productpriceL;

@property(nonatomic , strong)UIView *lineV;
@property(nonatomic , strong)UILabel *instrucL;
@property(nonatomic , strong)UILabel *numL;

@property(nonatomic , strong)UILabel *yongjinLab;
@property(nonatomic , strong)UILabel *hasSoldLab;
@property(nonatomic , strong)UILabel *allpriceLab;

@end

@implementation myOrderListContentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews {
    
    self.contentView.backgroundColor = KBGColor;
    
    UIView *whiteBGV = [[UIView alloc]init];
    whiteBGV.backgroundColor = KWhiteBGColor;
    [self.contentView addSubview:whiteBGV];
    [whiteBGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 12, 0, 12));
    }];
    
    UIImageView *productImgV = [[UIImageView alloc]init];
    productImgV.clipsToBounds = YES;
    productImgV.layer.cornerRadius = 4;
    [whiteBGV addSubview:productImgV];
    [productImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(whiteBGV).offset(12);
        make.top.mas_equalTo(whiteBGV).offset(7);
        make.height.width.mas_equalTo(72);
    }];
    self.productImg = productImgV;
    
    UILabel *productprice = [[UILabel alloc]init];
    productprice.font = DIN_Medium_FONT_R(13);
    productprice.textAlignment = NSTextAlignmentRight;
    productprice.textColor = KBlack333TextColor;
    [whiteBGV addSubview:productprice];
    [productprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(whiteBGV).offset(-12);
        make.top.mas_equalTo(productImgV.mas_top);
        make.height.mas_equalTo(22);
    }];
    self.productpriceL = productprice;
    
    UILabel *productName = [[UILabel alloc]init];
    productName.font = DEFAULT_FONT_M(13);
    productName.textAlignment = NSTextAlignmentLeft;
    productName.textColor = KBlack333TextColor;
    productName.text = @"";
    [whiteBGV addSubview:productName];
    [productName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(productImgV.mas_right).offset(12);
        make.right.mas_equalTo(productprice.mas_left).offset(-12);
        make.top.mas_equalTo(productImgV.mas_top);
        make.height.mas_equalTo(22);
    }];
    self.productTitleL = productName;
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    view.clipsToBounds = YES;
    view.layer.cornerRadius = 10;
    [whiteBGV addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(productName.mas_left);
        make.top.mas_equalTo(productName.mas_bottom).offset(8);
    }];
    
    UILabel *instrucLable = [UILabel creatLabelWithTitle:@"" textColor:KBlack666TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(11)];
    [view addSubview:instrucLable];
    [instrucLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(12);
        make.right.mas_equalTo(view).offset(-12);
        make.top.mas_equalTo(view.mas_top);
        make.height.mas_equalTo(20);
    }];
    self.instrucL = instrucLable;
    
    UILabel *numLable = [UILabel creatLabelWithTitle:@"" textColor:KBlack666TextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_R(15)];
    [whiteBGV addSubview:numLable];
    [numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(whiteBGV).offset(-12);
        make.top.mas_equalTo(productprice.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_greaterThanOrEqualTo(10);
    }];
    self.numL = numLable;
}

- (void)setModel:(OrderListProductModel *)model{
    _model = model;
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:model.skuImgUrl] placeholderImage:[UIImage imageNamed:@"icon_image"]];
    self.productpriceL.text = [NSString stringWithFormat:@"¥%@",model.priceSale];
    self.productTitleL.text = model.goodsName;
    self.instrucL.text = model.skuName;
    self.numL.text = [NSString stringWithFormat:@"x%@",model.quantityTotal];
}

- (void)setShouHouModel:(OrderShouHouListRecordsModel *)shouHouModel{
    _shouHouModel = shouHouModel;
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:_shouHouModel.skuImgUrl] placeholderImage:[UIImage imageNamed:@"icon_image"]];
    self.productpriceL.text = [NSString stringWithFormat:@"¥%@",_shouHouModel.priceSale];
    self.productTitleL.text = _shouHouModel.goodsName;
    self.instrucL.text = _shouHouModel.skuName;
    self.numL.text = [NSString stringWithFormat:@"x%@",_shouHouModel.quantityTotal];
}

@end

@interface myOrderListContentCellHeadView ()

@property(nonatomic , strong)UILabel *timeL;
@property(nonatomic , strong)UILabel *statusL;

@end

@implementation myOrderListContentCellHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    
    self.backgroundColor = KBGColor;
    
    UIView *whiteBGView = [[UIView alloc]initWithFrame:CGRectMake(12, 12, ScreenWidth - 24, 44)];
    whiteBGView.backgroundColor = KWhiteBGColor;
    [self addSubview:whiteBGView];
  
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:whiteBGView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = whiteBGView.bounds;
    maskLayer.path = maskPath.CGPath;
    whiteBGView.layer.mask = maskLayer;
    
    self.statusL = [UILabel creatLabelWithTitle:@"" textColor:KMaintextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_R(13)];
    [whiteBGView addSubview:self.statusL];
    [self.statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(whiteBGView).offset(-12);
        make.top.mas_equalTo(whiteBGView).offset(12);
    }];
    //待付款   待买家付款
    //待发货   待卖家发货
    //待收货   待买家收货
    //售后     待退款
    //已完成   已完成   666字体
    
    UILabel *titleL = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    [whiteBGView addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.statusL.mas_centerY);
        make.right.mas_equalTo(self.statusL.mas_left).offset(-5);
        make.left.mas_equalTo(whiteBGView).offset(10);
        make.height.mas_equalTo(25);
    }];
    self.timeL = titleL;
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)]];
}

- (void)setModel:(OrderListRecordsModel *)model{
    _model = model;
    self.statusL.text = @"";
    self.statusL.textColor = KMaintextColor;
    
    NSString *statusS = @"";
    switch (model.orderState.integerValue) {
        case 1:{
            statusS = @"待买家付款";
        }
            break;
        case 2:{
            statusS = @"待卖家发货";
        }
            break;
        case 3:{
            statusS = @"待买家收货";
        }
            break;
        case 9:{
            statusS = @"已完成";
            self.statusL.textColor = KBlack666TextColor;
        }
            break;
        case -1:
        case -2:
        case -6:
        case -7:{
            statusS = @"订单已取消";
        }
            break;
            
        default:
            break;
    }
    /**
     //待付款   待买家付款
     //待发货   待卖家发货
     //待收货   待买家收货
     //售后     待退款
     //已完成   已完成   666字体
     */
    self.statusL.text = statusS;
    
    NSString *name = @"";
    if (model.deliveryRealName) {
        name = model.deliveryRealName;
    }
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  %@",name,model.orderTime]];
    NSRange range = NSMakeRange(0,name.length);
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_M(15) range:range];
    self.timeL.attributedText = attributeMarket;
}

- (void)tapClick{
    if (_viewClickBlock) {
        _viewClickBlock();
    }
}

@end

@interface myOrderListContentCellFootView ()

@property(nonatomic , strong)UILabel *moneyL;
@property(nonatomic , strong)UILabel *yongjinL;

@end

@implementation myOrderListContentCellFootView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)setModel:(OrderListRecordsModel *)model{
    _model = model;
    
    //待付款   已付款
    //佣金
    NSString *statusS = @"";
    NSString *moneyS = K_NotNullHolder(model.totalMoneyOrder, @"-");
    NSString *payS = [NSString stringWithFormat:@"已付款 ¥%@",moneyS];
    switch (model.orderState.integerValue) {
        case 1:{
            statusS = @"待付款";
            payS = [NSString stringWithFormat:@"待付款 ¥%@",moneyS];
        }
        default:
            break;
    }
    
    NSString *yongjinStr = @"";
    if (model.totalMoneyAgent) {
        yongjinStr = model.totalMoneyAgent;
    }else{
        yongjinStr = @"";
    }
    NSString *yongjin = [NSString stringWithFormat:@"赚积分 %@",yongjinStr];
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   %@",payS,yongjin]];
    
    NSRange rang = [attributeMarket.string rangeOfString:@"¥"];
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_M(13) range:rang];
    
    [attributeMarket addAttribute:NSForegroundColorAttributeName value:KBlack999TextColor range:NSMakeRange(0, payS.length)];
    self.moneyL.attributedText = attributeMarket;
}

- (void)creatSubViews{
    
    self.backgroundColor = KBGColor;
    
    UIView *whiteBGView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, ScreenWidth - 24, 50)];
    whiteBGView.backgroundColor = KWhiteBGColor;
    [self addSubview:whiteBGView];
  
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:whiteBGView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = whiteBGView.bounds;
    maskLayer.path = maskPath.CGPath;
    whiteBGView.layer.mask = maskLayer;
    
    UILabel *titleL = [UILabel creatLabelWithTitle:@"" textColor:KMaintextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_M(15)];
    [whiteBGView addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(whiteBGView).offset(10);
        make.right.mas_equalTo(whiteBGView).offset(-10);
        make.left.mas_equalTo(whiteBGView).offset(10);
        make.height.mas_equalTo(30);
    }];
    self.moneyL = titleL;
   
//    self.yongjinL = [UILabel creatLabelWithTitle:@"赚: ¥99" textColor:KMaintextColor textAlignment:NSTextAlignmentRight font:DIN_Medium_FONT_R(17)];
//    [whiteBGView addSubview:self.yongjinL];
//    [self.yongjinL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(25);
//        make.left.right.mas_equalTo(titleL);
//        make.top.mas_equalTo(titleL.mas_bottom).offset(8);
//    }];

    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)]];
}

- (void)tapClick{
    if (_viewClickBlock) {
        _viewClickBlock();
    }
}

@end

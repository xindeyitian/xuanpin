//
//  ReceiveSuccessViewController.m
//  SmallB
//
//  Created by zhang on 2022/5/5.
//

#import "ReceiveSuccessViewController.h"

@interface ReceiveSuccessViewController ()

@end

@implementation ReceiveSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGBA(0,0,0,0.45);
    self.tableView.backgroundColor = kRGBA(0,0,0,0.45);
    
    UIView *allView = [[UIView alloc]initWithFrame:CGRectMake(24*KScreenW_Ratio, 0, ScreenWidth - 48*KScreenW_Ratio, 320*KScreenW_Ratio)];
    allView.center = self.view.center;
    allView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:allView];
    
    UIImageView *headerV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 48*KScreenW_Ratio, 132*KScreenW_Ratio)];
    headerV.image = IMAGE_NAMED(@"coupon_head_bgimage");
    [allView addSubview:headerV];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"恭喜您领取成功" textColor:KMainBGColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(20)];
    title.frame = CGRectMake(0, 77*KScreenW_Ratio, ScreenWidth - 48*KScreenW_Ratio, 25*KScreenW_Ratio);
    [headerV addSubview:title];
    
    UILabel *subTitle = [UILabel creatLabelWithTitle:@"优惠券用于开店时抵扣使用" textColor:KMainBGColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(13)];
    subTitle.frame = CGRectMake(0, 104*KScreenW_Ratio, ScreenWidth - 48*KScreenW_Ratio, 25*KScreenW_Ratio);
    [headerV addSubview:subTitle];
    
    NSInteger num = 2;
    UIView *otherView = [[UIView alloc]initWithFrame:CGRectMake(0, 131*KScreenW_Ratio, ScreenWidth - 48*KScreenW_Ratio, num*90*KScreenW_Ratio)];
    otherView.backgroundColor = kRGB(255, 237, 221);
    [allView addSubview:otherView];
    
    for (int i =0; i < num; i ++) {
        couponInfoImgV *couponV = [[couponInfoImgV alloc]initWithFrame:CGRectMake(12*KScreenW_Ratio, 20*KScreenW_Ratio + 90*KScreenW_Ratio *i, 303*KScreenW_Ratio, 70*KScreenW_Ratio)];
        couponV.image = IMAGE_NAMED(@"coupon_bgimage");
        [otherView addSubview:couponV];
    }

    UIImageView *footV = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(otherView.frame), ScreenWidth - 48*KScreenW_Ratio, 189*KScreenW_Ratio)];
    footV.image = IMAGE_NAMED(@"coupon_foot_bgimage");
    [allView addSubview:footV];
    
    couponInfoImgV *couponV = [[couponInfoImgV alloc]initWithFrame:CGRectMake(12*KScreenW_Ratio, 20*KScreenW_Ratio, 303*KScreenW_Ratio, 70*KScreenW_Ratio)];
    couponV.image = IMAGE_NAMED(@"coupon_bgimage");
    [footV addSubview:couponV];
    
    footV.userInteractionEnabled = YES;
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"去开店" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
    btn.frame = CGRectMake(47*KScreenW_Ratio, 110*KScreenW_Ratio, 233*KScreenW_Ratio, 50*KScreenW_Ratio);
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 25;
    [footV addSubview:btn];
    
    allView.frame = CGRectMake(24*KScreenW_Ratio, 0, ScreenWidth - 48*KScreenW_Ratio, CGRectGetMaxY(footV.frame));
    allView.center = self.view.center;
}

- (void)btnClick{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end

@implementation couponInfoImgV

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    
        self.userInteractionEnabled = YES;
        [self creatSubviews];
    }
    return self;
}

- (void)setDataModel:(ReceiveCouponDataModel *)dataModel{
    _dataModel = dataModel;
    self.titleL.text = dataModel.typeName;
    self.priceL.text = [NSString stringWithFormat:@"¥%@",dataModel.moneyCouponSub];
}

- (void)creatSubviews{
    
    float width = self.frame.size.width;
    
    UILabel *couponPrice = [UILabel creatLabelWithTitle:@"" textColor:KWhiteTextColor textAlignment:NSTextAlignmentCenter font:DIN_Medium_FONT_R(25)];
    [self addSubview:couponPrice];
    [couponPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self).offset(width * (32/909.0));
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(width * (222/909.0));
    }];
    
    UILabel *couponTitle = [UILabel creatLabelWithTitle:@"" textColor:KWhiteTextColor textAlignment:NSTextAlignmentLeft font:DIN_Medium_FONT_R(15)];
    [self addSubview:couponTitle];
    [couponTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-12);
        make.left.mas_equalTo(self).offset(width * (290/909.0));
        make.height.mas_equalTo(24);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    self.titleL = couponTitle;
    self.priceL = couponPrice;
}

- (void)setPriceStr:(NSString *)priceStr{
    _priceStr = priceStr;
    
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",_priceStr]];
    NSRange range = NSMakeRange(0,1);
    [attributeMarket addAttribute:NSFontAttributeName value:DIN_Medium_FONT_R(13) range:range];
    self.priceL.attributedText = attributeMarket;
}

@end

//
//  myOrderDetailHeaderView.m
//  SmallB
//
//  Created by zhang on 2022/4/12.
//

#import "myOrderDetailHeaderView.h"
#import "OrderLogistedListViewController.h"

@interface myOrderDetailHeaderView ()

@property (nonatomic , strong)UILabel *statusL;
@property (nonatomic , strong)UILabel *instroL;
@property (nonatomic , strong)UIImageView *statusImgV;
@property (nonatomic , strong)UILabel *addressL;
@property (nonatomic , strong)UILabel *nameL;
@property (nonatomic , strong)UIView *wuliuV;
@property (nonatomic , strong)UIView *whiteV;
@property (nonatomic , strong)UIImageView *addressImage;

@property (nonatomic , strong)UIView *moreBtnView;

@end

@implementation myOrderDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:self.frame];
    imgV.image = IMAGE_NAMED(@"order_detail_header_bg");
    [self addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-24);
    }];
    
    self.statusImgV = [[UIImageView alloc]init];
    [self addSubview:self.statusImgV];
    [self.statusImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(58);
        make.right.mas_equalTo(self).offset(-21);
        make.top.mas_equalTo(self).offset(12);
    }];
    
    self.statusL = [UILabel creatLabelWithTitle:@"-" textColor:KWhiteTextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(20)];
    [self addSubview:self.statusL];
    [self.statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(28);
        make.right.mas_equalTo(self.statusImgV.mas_left).offset(-10);
        make.top.mas_equalTo(self).offset(24);
        make.left.mas_equalTo(self).offset(12);
    }];
    
    self.instroL = [UILabel creatLabelWithTitle:@"-" textColor:KWhiteTextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
    [self addSubview:self.instroL];
    [self.instroL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(21);
        make.right.mas_equalTo(self.statusImgV.mas_left).offset(-10);
        make.top.mas_equalTo(self.statusL.mas_bottom).offset(5);
        make.left.mas_equalTo(self).offset(12);
    }];
    
    UIView *whiteView = [[UIView alloc]init];
    whiteView.backgroundColor = UIColor.whiteColor;
    whiteView.clipsToBounds = YES;
    whiteView.layer.cornerRadius = 10;
    [self addSubview:whiteView];
    self.whiteV = whiteView;
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).offset(-12);
        make.left.mas_equalTo(self).offset(12);
        make.right.mas_equalTo(self).offset(-12);
        make.top.mas_equalTo(self).offset(98);
    }];
    
    UIImageView *addressIcon = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"order_detail_address_icon")];
    [whiteView addSubview:addressIcon];
    [addressIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(22);
        make.left.mas_equalTo(whiteView).offset(12);
        make.top.mas_equalTo(whiteView).offset(20);
    }];
    self.addressImage = addressIcon;
    
    UILabel *titleL = [UILabel creatLabelWithTitle:@"-" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
    [whiteView addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(addressIcon.mas_centerY);
        make.right.mas_equalTo(whiteView).offset(-12);
        make.left.mas_equalTo(addressIcon.mas_right).offset(12);
        make.height.mas_equalTo(22);
    }];
    self.nameL = titleL;
    
    self.addressL = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
    [whiteView addSubview:self.addressL];
    self.addressL.numberOfLines = 0;
    [self.addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(whiteView).offset(43);
        make.right.mas_equalTo(whiteView).offset(-12);
        make.top.mas_equalTo(titleL.mas_bottom).offset(4);
    }];
    
    UIView *wuliuView = [[UIView alloc]init];
    wuliuView.backgroundColor = UIColor.clearColor;
    [whiteView addSubview:wuliuView];
    [wuliuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(whiteView).offset(0);
        make.right.left.mas_equalTo(whiteView);
        make.height.mas_equalTo(64);
    }];
    self.wuliuV = wuliuView;
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor = KBlackLineColor;
    [wuliuView addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(wuliuView.mas_bottom).offset(-0.5);
        make.left.mas_equalTo(wuliuView).offset(12);
        make.right.mas_equalTo(wuliuView).offset(-12);
        make.height.mas_equalTo(0.5);
    }];
    UIImageView *wuliuIcon = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"order_detail_wuliu_icon")];
    [wuliuView addSubview:wuliuIcon];
    [wuliuIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(22);
        make.left.mas_equalTo(wuliuView).offset(12);
        make.bottom.mas_equalTo(lineV.mas_top).offset(-20);
    }];
    
    UILabel *wuliuL = [UILabel creatLabelWithTitle:@"查看物流" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(15)];
    [wuliuView addSubview:wuliuL];
    [wuliuL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(wuliuIcon.mas_centerY);
        make.right.mas_equalTo(wuliuView).offset(-50);
        make.left.mas_equalTo(wuliuIcon.mas_right).offset(5);
        make.height.mas_equalTo(22);
    }];
    
    UIImageView *right = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"my_right_gray")];
    [wuliuView addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(wuliuIcon.mas_centerY);
        make.right.mas_equalTo(wuliuView).offset(-12);
        make.height.mas_equalTo(20);
    }];
    wuliuView.userInteractionEnabled = YES;
    [wuliuView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)]];
    
    self.moreBtnView = [[UIView alloc]init];
    self.moreBtnView.backgroundColor = KWhiteBGColor;
    [whiteView addSubview:self.moreBtnView];
    [self.moreBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(whiteView.mas_bottom);
        make.left.mas_equalTo(whiteView).offset(12);
        make.right.mas_equalTo(whiteView).offset(-12);
        make.height.mas_equalTo(47);
    }];
    
    UIView *lineV1 = [[UIView alloc]init];
    lineV1.backgroundColor = KBlackLineColor;
    [self.moreBtnView addSubview:lineV1];
    
    [lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.moreBtnView);
        make.height.mas_equalTo(1);
    }];
    
    UIView *lineV2 = [[UIView alloc]init];
    lineV2.backgroundColor = KBlackLineColor;
    [self.moreBtnView addSubview:lineV2];
    
    [lineV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(1);
        make.centerY.mas_equalTo(self.moreBtnView.mas_centerY);
        make.centerX.mas_equalTo(self.moreBtnView.mas_centerX);
    }];
    
    BaseButton *leftBtn = [BaseButton CreateBaseButtonTitle:@"联系收货人" Target:self Action:@selector(btnClick:) Font:DEFAULT_FONT_R(15) BackgroundColor:KWhiteBGColor Color:KOrangeTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
    [self.moreBtnView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(lineV2.mas_left).offset(-5);
        make.left.mas_equalTo(self.moreBtnView).offset(5);
        make.height.mas_equalTo(40);
        make.centerY.mas_equalTo(lineV2.mas_centerY);
    }];
    
    BaseButton *rightBtn = [BaseButton CreateBaseButtonTitle:@"复制地址" Target:self Action:@selector(btnClick:) Font:DEFAULT_FONT_R(15) BackgroundColor:KWhiteBGColor Color:KMaintextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:4];
    [self.moreBtnView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineV2.mas_right).offset(5);
        make.right.mas_equalTo(self.moreBtnView).offset(-5);
        make.height.mas_equalTo(40);
        make.centerY.mas_equalTo(lineV2.mas_centerY);
    }];
}

- (void)setDetailModel:(OrderDetailModel *)detailModel{
    _detailModel = detailModel;
    
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",detailModel.deliveryRealName,detailModel.deliveryPhoneNum]];
    NSRange range = NSMakeRange(0,detailModel.deliveryRealName.length);
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_M(15) range:range];
    self.nameL.attributedText = attributeMarket;
    
    self.addressL.text = detailModel.deliveryAddress;
    self.wuliuV.hidden = !self.showWuliu;
    self.moreBtnView.hidden = !self.haveBtn;
    [self.addressImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.whiteV).offset(self.showWuliu ? 64+20:20);
    }];
    /**
     待付款  待买家付款   等待支付，剩余23时59分自动关闭  order_detail_header1
     待发货  待发货    等待卖家发货  order_detail_header3
     已发货  卖家已发货  还剩9天13小时自动确认  order_detail_header2
     已完成  已完成     交易已完成  order_detail_header4
     已取消  已取消    交易已取消  order_detail_header5
     售后    售后   退款中   order_detail_header6
     */

    NSString *statusS = @"";
    NSString *contentS = @"";
    NSString *imageName = @"";
    switch (detailModel.orderState.integerValue) {
        case 1:{
            statusS = @"待买家付款";
            contentS = @"等待支付，-自动关闭";
            if (detailModel.autoCloseTime) {
                contentS = [NSString stringWithFormat:@"等待支付，%@自动关闭",detailModel.autoCloseTime];
            }
            imageName = @"order_detail_header1";
        }
            break;
        case 2:{
            statusS = @"待发货";
            contentS = @"等待卖家发货";
            imageName = @"order_detail_header3";
        }
            break;
        case 3:{
            statusS = @"卖家已发货";
            contentS = @"-自动确认";
            if (detailModel.autoRecvRime) {
                contentS = [NSString stringWithFormat:@"%@自动确认",detailModel.autoRecvRime];
            }
            imageName = @"order_detail_header2";
        }
            break;
        case 9:{
            statusS = @"已完成";
            contentS = @"交易已完成";
            imageName = @"order_detail_header4";
        }
            break;
        case -1:
        case -2:
        case -6:
        case -7:{
            statusS = @"已取消";
            contentS = @"交易已取消";
            imageName = @"order_detail_header5";
        }
            break;
        default:
            break;
    }
    self.statusL.text = statusS;
    self.instroL.text = contentS;
    self.statusImgV.image = [UIImage imageNamed:imageName];
}

- (void)btnClick:(UIButton *)btn{
    if (btn.tag == 4) {
        [AppTool copyWithString:self.addressL.text];
    }
    if (btn.tag == 3) {
        
    }
}

- (void)tapClick{
    //wuliuView
    OrderLogistedListViewController *vc = [[OrderLogistedListViewController alloc]init];
    vc.detailModel = self.detailModel;
    [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
}

- (void)setHaveBtn:(BOOL)haveBtn{
    _haveBtn = haveBtn;
    self.moreBtnView.hidden = _haveBtn;
}

- (void)setShowWuliu:(BOOL)showWuliu{
    _showWuliu = showWuliu;
    self.wuliuV.hidden = !_showWuliu;
}

@end

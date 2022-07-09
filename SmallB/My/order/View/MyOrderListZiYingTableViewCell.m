//
//  MyOrderListZiYingTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/26.
//

#import "MyOrderListZiYingTableViewCell.h"
#import "PhoneAlertViewController.h"
#import "OrderAlertViewController.h"
#import "MyOrderLogisticsViewController.h"
#import "MyorderDetailViewController.h"

@interface MyOrderListZiYingTableViewCell ()

@property(nonatomic , strong)UIImageView *productImgV;

@property(nonatomic , strong)UIView *lineV;

@property(nonatomic , strong)UILabel *yongjinLab;
@property(nonatomic , strong)UILabel *hasSoldLab;
@property(nonatomic , strong)UILabel *allpriceLab;

@end

@implementation MyOrderListZiYingTableViewCell

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
    
    UILabel *productprice = [[UILabel alloc]init];
    productprice.font = DIN_Medium_FONT_R(13);
    productprice.textAlignment = NSTextAlignmentRight;
    productprice.textColor = KBlack333TextColor;
    productprice.text = @"¥199.9";
    [whiteBGV addSubview:productprice];
    [productprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(whiteBGV).offset(-12);
        make.top.mas_equalTo(productImgV.mas_top);
        make.height.mas_equalTo(22);
    }];
    
    UILabel *productName = [[UILabel alloc]init];
    productName.font = DEFAULT_FONT_M(13);
    productName.textAlignment = NSTextAlignmentLeft;
    productName.textColor = KBlack333TextColor;
    productName.text = @"三只松鼠坚果";
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
    
    UILabel *instrucLable = [UILabel creatLabelWithTitle:@"桶装每日坚果" textColor:KBlack666TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(11)];
    [view addSubview:instrucLable];
    [instrucLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(12);
        make.right.mas_equalTo(view).offset(-12);
        make.top.mas_equalTo(view.mas_top);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *numLable = [UILabel creatLabelWithTitle:@"X1" textColor:KBlack666TextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_R(15)];
    [whiteBGV addSubview:numLable];
    [numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(whiteBGV).offset(-12);
        make.top.mas_equalTo(productprice.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
}

@end

@interface myOrderListZiYingCellHeadView ()

@property(nonatomic , strong)UILabel *nameL;
@property(nonatomic , strong)UILabel *statusL;
@property(nonatomic , strong)UILabel *orderL;

@end

@implementation myOrderListZiYingCellHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    
    self.backgroundColor = KBGColor;
    
    UIView *whiteBGView = [[UIView alloc]initWithFrame:CGRectMake(12, 12, ScreenWidth - 24, 76+7)];
    whiteBGView.backgroundColor = KWhiteBGColor;
    [self addSubview:whiteBGView];
  
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:whiteBGView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = whiteBGView.bounds;
    maskLayer.path = maskPath.CGPath;
    whiteBGView.layer.mask = maskLayer;
    
    self.statusL = [UILabel creatLabelWithTitle:@"-" textColor:KMaintextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_R(13)];
    [whiteBGView addSubview:self.statusL];
    [self.statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.right.mas_equalTo(whiteBGView).offset(-12);
        make.top.mas_equalTo(whiteBGView).offset(12);
    }];
    //待付款   待买家付款
    //待发货   待卖家发货
    //待收货   待买家收货
    //售后     待退款
    //已完成   已完成   666字体
    
    UILabel *order = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    [whiteBGView addSubview:order];
    self.orderL = order;
    [order mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.statusL.mas_centerY);
        make.right.mas_equalTo(self.statusL.mas_left).offset(-5);
        make.left.mas_equalTo(whiteBGView).offset(12);
        make.height.mas_equalTo(22);
    }];
    
    UIView *grayV = [[UIView alloc]init];
    grayV.backgroundColor = KBGColor;
    grayV.layer.cornerRadius = 4;
    grayV.clipsToBounds = YES;
    [whiteBGView addSubview:grayV];
    [grayV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(whiteBGView).offset(-12);
        make.left.mas_equalTo(whiteBGView).offset(12);
        make.top.mas_equalTo(order.mas_bottom).offset(10);
        make.height.mas_equalTo(31);
    }];
    grayV.userInteractionEnabled = YES;
    [grayV addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chatClick)]];
    
    UILabel *titleL = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    [grayV addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(grayV.mas_centerY);
        make.left.mas_equalTo(grayV).offset(8);
        make.height.mas_equalTo(25);
    }];
    self.nameL = titleL;
    
    UIImageView *imgV = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"order_list_phone")];
    [grayV addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleL.mas_centerY);
        make.left.mas_equalTo(titleL.mas_right).offset(10);
        make.height.width.mas_equalTo(18);
    }];

    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)]];
}

- (void)setModel:(OrderListRecordsModel *)model{
    _model = model;
    
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
    self.statusL.text = statusS;
    
    self.orderL.text = [NSString stringWithFormat:@"订单编号:%@",model.orderNo];
    
    NSString *name = @"";
    NSString *phone = @"";
    if (model.deliveryRealName) {
        name = model.deliveryRealName;
    }
    if (model.deliveryPhoneNum) {
        phone = model.deliveryPhoneNum;
    }
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  %@",name,phone]];
    NSRange range = NSMakeRange(0,name.length);
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_M(15) range:range];
    self.nameL.attributedText = attributeMarket;
}

- (void)tapClick{
    if (_viewClickBlock) {
        _viewClickBlock();
    }
}

- (void)chatClick{
    PhoneAlertViewController *vc = [[PhoneAlertViewController alloc]init];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    vc.phone = self.model.deliveryPhoneNum;
    [[AppTool currentVC] presentViewController:vc animated:NO completion:nil];
}

@end

@interface myOrderListZiYingCellFootView ()

@property(nonatomic , strong)UILabel *moneyL;
@property(nonatomic , strong)UILabel *yongjinL;

@property(nonatomic , strong)BaseButton *leftBtn;
@property(nonatomic , strong)BaseButton *rightBtn;

@end

@implementation myOrderListZiYingCellFootView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    
    self.backgroundColor = KBGColor;
    
    UIView *whiteBGView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, ScreenWidth - 24, self.frame.size.height)];
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
        make.top.mas_equalTo(whiteBGView).offset(13);
        make.right.mas_equalTo(whiteBGView).offset(-10);
        make.left.mas_equalTo(whiteBGView).offset(10);
        make.height.mas_equalTo(24);
    }];
    self.moneyL = titleL;
   
    self.userInteractionEnabled = YES;
    whiteBGView.userInteractionEnabled = YES;
    
    //取消订单  发货
    BaseButton *right = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(bottomBtnClick:) Font:DEFAULT_FONT_R(13) BackgroundColor:KWhiteBGColor Color:KMaintextColor Frame:CGRectMake(ScreenWidth - 109 - 12 - 24, 54, 109, 27) Alignment:NSTextAlignmentCenter Tag:3];
    right.clipsToBounds = YES;
    right.layer.cornerRadius = 13.5;
    [whiteBGView addSubview:right];
    self.rightBtn = right;
    
    BaseButton *left = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(bottomBtnClick:) Font:DEFAULT_FONT_R(13) BackgroundColor:KWhiteBGColor Color:KMaintextColor Frame:CGRectMake(ScreenWidth - 251 - 24, 54, 122, 27) Alignment:NSTextAlignmentCenter Tag:4];
    left.clipsToBounds = YES;
    left.layer.cornerRadius = 13.5;
    [whiteBGView addSubview:left];
    self.leftBtn = left;
    
    right.layer.borderColor = KMainBGColor.CGColor;
    right.layer.borderWidth = 1;
    
    left.layer.borderColor = KMainBGColor.CGColor;
    left.layer.borderWidth = 1;
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)]];
}

- (void)setModel:(OrderListRecordsModel *)model{
    _model = model;
    //待付款   已付款
    //佣金
    NSString *moneyS = K_NotNullHolder(model.totalMoneyOrder, @"-");
    NSString *payS = [NSString stringWithFormat:@"已付款 ¥%@",moneyS];
    switch (model.orderState.integerValue) {
        case 1:{
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
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",payS]];
    NSRange rang = [attributeMarket.string rangeOfString:@"¥"];
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_M(13) range:rang];
    
    [attributeMarket addAttribute:NSForegroundColorAttributeName value:KMaintextColor range:NSMakeRange(0, payS.length)];
    self.moneyL.attributedText = attributeMarket;
    // 订单状态（1待支付默认，2待发货、3待收货，9完成，-1客户取消、-2管理员取消、-6订单超时未支付取消、-7行云订单生成失败取消
    NSInteger orderStatus = model.orderState.integerValue;
    if (orderStatus == 2) {
        //取消订单  发货
        self.leftBtn.hidden = NO;
        self.rightBtn.frame = CGRectMake(ScreenWidth - 50 - 12 - 24, 54, 50, 27);
        [self.rightBtn setTitle:@"发货" forState:UIControlStateNormal];
        self.leftBtn.frame = CGRectMake(ScreenWidth - 150 - 24, 54, 76, 27);
        [self.leftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.leftBtn setTitleColor:KBlack999TextColor forState:UIControlStateNormal];
        self.leftBtn.layer.borderColor = KBlack999TextColor.CGColor;
    }else if (orderStatus == 3) {
        //已发货  查看详情
        self.rightBtn.frame = CGRectMake(ScreenWidth - 76 - 12 - 24, 54, 76, 27);
        self.leftBtn.frame = CGRectMake(ScreenWidth - 163 - 24, 54, 63, 27);
        [self.leftBtn setTitleColor:KBlack999TextColor forState:UIControlStateNormal];
        self.leftBtn.layer.borderColor = KBlack999TextColor.CGColor;
        [self.leftBtn setTitle:@"已发货" forState:UIControlStateNormal];
        [self.rightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    }else if (orderStatus == 10) {
        //售后处理
        self.leftBtn.hidden = YES;
        self.rightBtn.frame = CGRectMake(ScreenWidth - 76 - 12 - 24, 54, 76, 27);
        [self.rightBtn setTitle:@"售后处理" forState:UIControlStateNormal];
    }
}

- (void)bottomBtnClick:(BaseButton *)btn{
    NSInteger orderStatus = self.model.orderState.integerValue;
    if (btn.tag == 4) {
        if (orderStatus == 2) {
            OrderAlertViewController *vc = [[OrderAlertViewController alloc]init];
            vc.alertType = orderAlertType_CancelOrder;
            vc.orderID = self.model.orderId;
            vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [[AppTool currentVC]  presentViewController:vc animated:NO completion:nil];
        }
    }
    if (btn.tag == 3) {
        if (orderStatus == 2) {
            MyOrderLogisticsViewController *vc = [[MyOrderLogisticsViewController alloc]init];
            vc.haveBottom = YES;
            vc.orderID = self.model.orderId;
            vc.productAry = self.model.orderGoodsListVos;
            vc.successBlock = ^{
                if (_successBlock) {
                    _successBlock();
                }
            };
            [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
        }
        if (orderStatus == 3) {
            MyorderDetailViewController *vc = [[MyorderDetailViewController alloc]init];
            vc.orderID = self.model.orderId;
            [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
        }
        if (orderStatus == 10) {
            MyorderDetailViewController *vc = [[MyorderDetailViewController alloc]init];
            vc.isShouHou = YES;
            [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)tapClick{
    if (_viewClickBlock) {
        _viewClickBlock();
    }
}

@end

//
//  MyVCInfoTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/7.
//

#import "MyVCInfoTableViewCell.h"
#import "myInfoDetailView.h"
#import "myVCOrderView.h"
#import "MyVCCollectionAndRecordsViewController.h"
#import "rightPushView.h"
#import "myOrderViewController.h"
#import "myStoreManagerViewController.h"
#import "myShimingViewController.h"
#import "myToBeSupplierViewController.h"
#import "mySetViewController.h"
#import "chatAlertViewController.h"
#import "applyStoreViewController.h"
#import "MessageViewController.h"
#import "WithdrawFirstViewController.h"
#import "MyNewOrderViewController.h"
#import "MyShouHouViewController.h"

@interface  MyVCInfoTableViewCell ()

@property(nonatomic , strong)UIImageView *userLogoImg;
@property(nonatomic , strong)UILabel *userNameL;
@property(nonatomic , strong)UIView *redView;

@end

@implementation MyVCInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews {

    UIImageView *bgImgV = [[UIImageView alloc]init];
    [bgImgV setImage:IMAGE_NAMED(@"my_info_bg")];
    [self.contentView addSubview:bgImgV];
    bgImgV.userInteractionEnabled = YES;
    [bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    self.userLogoImg = [[UIImageView alloc]init];
    self.userLogoImg.layer.cornerRadius = 35;
    self.userLogoImg.layer.masksToBounds = YES;
    self.userLogoImg.layer.borderColor = UIColor.whiteColor.CGColor;
    self.userLogoImg.layer.borderWidth = 4;
    [bgImgV addSubview:self.userLogoImg];
    [self.userLogoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgImgV).offset(14);
        make.top.mas_equalTo(bgImgV).offset(KStatusBarHeight+15);
        make.height.width.mas_equalTo(70);
    }];
    
    UIButton *setBtn = [[UIButton alloc]init];
    [setBtn setBackgroundImage:[UIImage imageNamed:@"my_set"] forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgImgV addSubview:setBtn];
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-12);
        make.top.mas_equalTo(self.userLogoImg.mas_top);
        make.height.width.mas_equalTo(22);
    }];
    
    UIButton *messageBtn = [[UIButton alloc]init];
    [messageBtn setBackgroundImage:[UIImage imageNamed:@"my_vc_message"] forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(messageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgImgV addSubview:messageBtn];
    [messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(setBtn.mas_left).offset(-12);
        make.top.mas_equalTo(self.userLogoImg.mas_top);
        make.height.width.mas_equalTo(22);
    }];
    
    self.userNameL = [[UILabel alloc]init];
    self.userNameL.font = DEFAULT_FONT_M(17);
    self.userNameL.textColor = KBlack333TextColor;
   
    [bgImgV addSubview:self.userNameL];
    [self.userNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userLogoImg.mas_right).offset(14);
        make.right.mas_equalTo(messageBtn.mas_left).offset(-10);
        make.top.mas_equalTo(self.userLogoImg.mas_top).offset(6);
        make.height.mas_equalTo(24);
    }];
    
    UIView *codeView = [[UIView alloc]init];
    codeView.backgroundColor = kRGBA(250, 119, 109, 0.2);
    [bgImgV addSubview:codeView];
    codeView.layer.cornerRadius = 12.5;
    codeView.layer.masksToBounds = YES;
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameL.mas_left);
        make.top.mas_equalTo(self.userNameL.mas_bottom).offset(12);
        make.height.mas_equalTo(25);
    }];
    
    UIImageView *codeImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"my_tuanCode"]];
    [codeView addSubview:codeImgV];
    [codeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(codeImgV.superview).offset(12);
        make.top.mas_equalTo(codeImgV.superview).offset(4);
        make.height.width.mas_equalTo(18);
    }];
    
    UILabel *codeL = [[UILabel alloc] initWithFrame:CGRectZero];
    codeL.backgroundColor = UIColor.clearColor;
    codeL.textColor = kRGB(250, 23, 45);
    codeL.font = [UIFont systemFontOfSize:13];
    codeL.text = @"我的邀请码12345345";
    [codeView addSubview:codeL];
    [codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(codeImgV.mas_right).offset(3);
        make.bottom.mas_equalTo(codeImgV.mas_bottom);
        make.height.mas_equalTo(18);
        make.right.mas_equalTo(codeL.superview).offset(-8);
    }];
    
    NSArray *titleAry = @[@"商品收藏",@"我的关注",@"浏览记录"];
    NSArray *numAry = @[@"0",@"0",@"0"];
    for (int i =0; i < titleAry.count; i ++) {
        myInfoDetailView *view = [[myInfoDetailView alloc]initWithFrame:CGRectMake(ScreenWidth/3.0*i, KStatusBarHeight + 15 + 85, ScreenWidth/3.0, 45)];
        view.backgroundColor = self.backgroundColor;
        view.tag = 110 + i ;
        view.titleString = titleAry[i];
        view.numString = numAry[i];
        view.hiddenRedView = YES;
        [bgImgV addSubview:view];
        view.viewClickBlock = ^(NSInteger index) {
            MyVCCollectionAndRecordsViewController *vc = [[MyVCCollectionAndRecordsViewController alloc]init];
            if (i == 0) {
                vc.typeIndex = vcTypeIndexProductCollection;
            }
            if (i == 1) {
                vc.typeIndex = vcTypeIndexStoreAttention;
            }
            if (i == 2) {
                vc.typeIndex = vcTypeIndexRecordList;
            }
            [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
        };
    }
    UIView *whiteBgView = [[UIView alloc]initWithFrame:CGRectMake(0, KStatusBarHeight + 160, ScreenWidth, 20)];
    whiteBgView.backgroundColor = KBGColor;
    [self addSubview:whiteBgView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:whiteBgView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = whiteBgView.bounds;
    maskLayer.path = maskPath.CGPath;
    whiteBgView.layer.mask = maskLayer;
    
    NSString *userPhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"];
    NSString *userLogo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userLogo"];
    if (userPhone.length) {
        NSString *name = [userPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        self.userNameL.text = name;
    }
    if (userLogo.length) {
        [self.userLogoImg sd_setImageWithURL:[NSURL URLWithString:userLogo] placeholderImage:KPlaceholder_DefaultImage];
    }
}

- (void)messageBtnClick{
    [[AppTool currentVC].navigationController pushViewController:[[MessageViewController alloc]init] animated:YES];
}

- (void)setBtnClick{
    [[AppTool currentVC].navigationController pushViewController:[[mySetViewController alloc]init] animated:YES];
}

- (void)setModel:(incomeStatisticsModel *)model{
    _model = model;
    
    NSString *userPhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"];
    NSString *userLogo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userLogo"];
    if (userPhone.length) {
        NSString *name = [userPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        self.userNameL.text = name;
    }
    if (userLogo.length) {
        [self.userLogoImg sd_setImageWithURL:[NSURL URLWithString:userLogo] placeholderImage:KPlaceholder_DefaultImage];
    }
    
    myInfoDetailView*view1  = [self.contentView viewWithTag:110];
    if (model.behaviorStaVo.collectGoods) {
        view1.numString = K_NotNullHolder(model.behaviorStaVo.collectGoods, 0);
    }else{
        view1.numString = @"0";
    }
   
    myInfoDetailView*view2  = [self.contentView viewWithTag:111];
    if (model.behaviorStaVo.attentionShop) {
        view2.numString = K_NotNullHolder(model.behaviorStaVo.attentionShop, 0);
    }else{
        view2.numString = @"0";
    }
    
    myInfoDetailView*view3  = [self.contentView viewWithTag:112];
    if (model.behaviorStaVo.cookies) {
        view3.numString = K_NotNullHolder(model.behaviorStaVo.cookies, 0);
    }else{
        view3.numString = @"0";
    }
}


@end


@interface  MyVCChatTableViewCell ()

@end

@implementation MyVCChatTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews {
    
    self.backgroundColor = KBGColor;
    
    UIView *whiteBGView = [[UIView alloc]init];
    whiteBGView.backgroundColor = KWhiteBGColor;
    whiteBGView.layer.cornerRadius = 8;
    whiteBGView.layer.masksToBounds = YES;
    [self.contentView addSubview:whiteBGView];
    [whiteBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 12, 0, 12));
    }];
    
    float whiteWidth = ScreenWidth - 24 - 30 ;
    NSArray *titleAry = @[@"客户管理",@"店铺管理",@"团长码",@"实名认证",@"联系客服",@"云店数据",@"客户管理",@"成为供货商"];
    titleAry = @[@"店铺管理",@"团长码",@"实名认证",@"联系客服",@"成为供货商"];
    NSArray *imgAry = @[@"my_vc_dianpu",@"my_vc_tuan",@"my_vc_shiming",@"my_vc_chat",@"my_vc_supplier"];
    for (int i =0; i < titleAry.count; i ++) {
        myVCOrderView *view = [[myVCOrderView alloc]initWithFrame:CGRectMake(whiteWidth/5.0*(i%5) + 5*(i%5+1), 16+(62+16)*(i/5), whiteWidth/5.0, 62)];
        view.titleString = titleAry[i];
        view.imageNameString = imgAry[i];
        view.imageHeight = 32;
        view.tag = 100+i;
        [whiteBGView addSubview:view];
        view.viewClickBlock = ^(NSInteger index) {
            
            UIViewController *selfVC = [AppTool currentVC];
            if (index == 0) {
                [selfVC.navigationController pushViewController:[[myStoreManagerViewController alloc]init] animated:YES];
            }
            if (index == 1) {
                [AppTool currentVC].tabBarController.selectedIndex = 2;
            }
            if (index == 4) {
                [selfVC.navigationController pushViewController:[[myToBeSupplierViewController alloc]init] animated:YES];
            }
            if (index == 2) {
                [selfVC.navigationController pushViewController:[[myShimingViewController alloc]init] animated:YES];
            }
            if (index == 3) {
                
                [THHttpManager GET:@"commons/articleInfo/getArticleInfo" parameters:@{@"articleCode":@"ServiceTel"} block:^(NSInteger returnCode, THRequestStatus status, id data) {
                    if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
                        chatAlertViewController *alertVC = [chatAlertViewController new];
                        alertVC.phoneStr = [data objectForKey:@"content"];
                        alertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
                        [selfVC presentViewController:alertVC animated:NO completion:nil];
                    }
                }];
            }
        };
    }
}

@end

@interface  MyVCOrderTableViewCell ()

@end

@implementation MyVCOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews {
    
    self.backgroundColor = KBGColor;
    
    UIView *whiteBGView = [[UIView alloc]init];
    whiteBGView.backgroundColor = KWhiteBGColor;
    whiteBGView.layer.cornerRadius = 8;
    whiteBGView.layer.masksToBounds = YES;
    [self.contentView addSubview:whiteBGView];
    [whiteBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(15, 12, 12, 12));
    }];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectZero];
    titleL.textColor = KBlack333TextColor;
    titleL.font = DEFAULT_FONT_R(13);
    [whiteBGView addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleL.superview).offset(12);
        make.top.mas_equalTo(titleL.superview).offset(12);
        make.height.mas_equalTo(24);
        make.right.mas_equalTo(titleL.superview).offset(-100);
    }];
    
    NSString *numStr = [NSString stringWithFormat:@"(共计%@笔)",@"300"];
    numStr = @"";
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"我的订单  %@",numStr]];
    NSRange range = NSMakeRange(0,4);
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_M(15) range:range];
    titleL.attributedText = attributeMarket;
    
    rightPushView *rightV = [[rightPushView alloc]init];
    rightV.titleL.text = @"全部";
    rightV.titleL.textColor = KBlack999TextColor;
    rightV.titleL.font = DEFAULT_FONT_R(12);
    rightV.imageNameString = @"my_right_gray";
    [whiteBGView addSubview:rightV];
    [rightV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(rightV.superview).offset(-12);
        make.centerY.mas_equalTo(titleL.mas_centerY);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(60);
    }];
    rightV.viewClickBlock = ^{
        MyNewOrderViewController *vc = [[MyNewOrderViewController alloc]init];
        vc.orderType = myOrderTypeWaitingAllOrder;
        [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
    };
    
    float whiteWidth = ScreenWidth - 24 - 20;
    NSArray *titleAry = @[@"待付款",@"待发货",@"待收货",@"退款/售后",@"已完成"];
    NSArray *imgAry = @[@"my_order_waitingPaid",@"my_order_toBeDelivered",@"my_order_pendingReceipt",@"my_order_refund",@"my_order_complet"];
    for (int i =0; i < titleAry.count; i ++) {
        myVCOrderView *view = [[myVCOrderView alloc]initWithFrame:CGRectMake(whiteWidth/5.0*i + 5*i, 50, whiteWidth/5.0, 52)];
        view.titleString = titleAry[i];
        view.imageNameString = imgAry[i];
        view.imageHeight = 28;
        view.tag = 100+i;
        [whiteBGView addSubview:view];
        view.viewClickBlock = ^(NSInteger index) {
            
            if (index == 3) {
                MyShouHouViewController *vc = [[MyShouHouViewController alloc]init];
    //            vc.orderType = index;
                [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
                return;
            }
            
            MyNewOrderViewController *vc = [[MyNewOrderViewController alloc]init];
//            vc.orderType = index;
            [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
        };
    }
}

@end

@interface  MyVCProfitsTableViewCell ()

@end

@implementation MyVCProfitsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews {
    
    self.backgroundColor = KBGColor;
    
    UIImageView *bgImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"my_profit_bg"]];
    bgImgV.userInteractionEnabled = YES;
    [self.contentView addSubview:bgImgV];
    [bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 12, 0, 12));
    }];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectZero];
    titleL.textColor = KWhiteTextColor;
    titleL.text = @"我的收益";
    titleL.font = DEFAULT_FONT_M(15);
    [bgImgV addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleL.superview).offset(12);
        make.top.mas_equalTo(titleL.superview).offset(12);
        make.height.mas_equalTo(23);
    }];
    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"my_money"]];
    [self.contentView addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleL.mas_right).offset(3);
        make.centerY.mas_equalTo(titleL.mas_centerY);
        make.height.width.mas_equalTo(15);
    }];
    
    rightPushView *rightV = [[rightPushView alloc]init];
    rightV.titleL.text = @"申请提现";
    rightV.titleL.textColor = KWhiteTextColor;
    rightV.titleL.font = DEFAULT_FONT_M(14);
    rightV.imageNameString = @"my_right_white";
    [bgImgV addSubview:rightV];
    rightV.viewClickBlock = ^{
        WithdrawFirstViewController *vc = [[WithdrawFirstViewController alloc]init];
        if (self.model) {
            //vc.moneyStr = K_NotNullHolder(self.model.incomeStaVo.operableIncome, 0);
            vc.moneyStr = [NSString stringWithFormat:@"%.2f",self.model.incomeStaVo.operableIncome];
        }
        [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
    };
    [rightV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bgImgV).offset(-12);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(100);
        make.centerY.mas_equalTo(titleL.mas_centerY);
    }];
    
    UIView *whiteBGView = [[UIView alloc]init];
    whiteBGView.backgroundColor = KWhiteBGColor;
    whiteBGView.layer.cornerRadius = 8;
    whiteBGView.layer.masksToBounds = YES;
    [bgImgV addSubview:whiteBGView];
    [whiteBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgImgV).offset(12);
        make.right.mas_equalTo(bgImgV).offset(-12);
        make.height.mas_equalTo(78);
        make.bottom.mas_equalTo(bgImgV.mas_bottom).offset(-23);
    }];
    
    float whiteWidth = ScreenWidth - 48 - 20;
    NSArray *titleAry = @[@"可提现金额(元)",@"店铺累计收入(元)",@"待结算收益(元)"];
    NSArray *numAry = @[@"0",@"0",@"0"];
    for (int i =0; i < titleAry.count; i ++) {
        myInfoDetailView *view = [[myInfoDetailView alloc]initWithFrame:CGRectMake(whiteWidth/3.0*i+5*(i+1), 13, whiteWidth/3.0, 52)];
        view.tag = 100 +i;
        view.titleString = titleAry[i];
        view.numString = numAry[i];
        view.hiddenRedView = YES;
        view.titleL.font = DEFAULT_FONT_R(12);
        view.titleL.textColor = KBlack666TextColor;
        view.numL.font =DIN_Medium_FONT_R(20);
        view.numL.textColor = KBlack333TextColor;
        [whiteBGView addSubview:view];
        
        UIView *lineV = [[UIView alloc]init];
        lineV.backgroundColor = kRGB(255, 218, 218);
        [whiteBGView addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(52);
            make.left.mas_equalTo(view.mas_right).offset(2);
            make.centerY.mas_equalTo(whiteBGView.mas_centerY);
        }];
        lineV.hidden = i == 2;
        view.viewClickBlock = ^(NSInteger index) {
//            [[AllNoticePopUtility shareInstance] popViewWithTitle:titleAry[i] AndType:success AnddataBlock:^{
//
//            }];
        };
    }
}

- (void)withDrawBtnClick{
    [[AllNoticePopUtility shareInstance] popViewWithTitle:@"提现" AndType:success AnddataBlock:^{
        
    }];
}

- (void)setModel:(incomeStatisticsModel *)model{
    _model = model;
    
    myInfoDetailView*view1  = [self.contentView viewWithTag:100];
    //view1.numString = K_NotNullHolder(model.incomeStaVo.operableIncome, 0);
    view1.numString = [NSString stringWithFormat:@"%.2f",model.incomeStaVo.operableIncome];
    
    myInfoDetailView*view2  = [self.contentView viewWithTag:101];
    view2.numString = K_NotNullHolder(model.incomeStaVo.totalIncome, 0);;
    
    myInfoDetailView*view3  = [self.contentView viewWithTag:102];
    view3.numString = K_NotNullHolder(model.incomeStaVo.pendingIncome, 0);
}

@end


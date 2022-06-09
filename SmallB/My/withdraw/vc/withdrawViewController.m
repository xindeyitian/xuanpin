//
//  withdrawViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/12.
//

#import "withdrawViewController.h"
#import "withdrawResultViewController.h"
#import "withdrawRecordViewController.h"
#import "BingdingTableViewController.h"
#import "ThirdBingDingViewController.h"

@interface withdrawViewController ()<UINavigationControllerDelegate>

@property (nonatomic , strong)UITextField *moneyField;
@property (nonatomic , strong)withdrawTypeView *zhifubaoView;
@property (nonatomic , strong)withdrawTypeView *weixinView;

@property (nonatomic , strong)UIView *headerView;
@property (nonatomic , strong)UITextField *withdrawField;

@property (nonatomic , strong)UILabel *moneyL;

@end

@implementation withdrawViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self getMoney];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-10);
    }];
 
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 325)];
    imgV.image = IMAGE_NAMED(@"withdraw_header_img");
    imgV.userInteractionEnabled = YES;
    [self.view addSubview:imgV];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"提现" textColor:KWhiteTextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(18)];
    [imgV addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgV).offset(KStatusBarHeight);
        make.right.mas_equalTo(imgV).offset(-50);
        make.left.mas_equalTo(imgV).offset(50);
        make.height.mas_equalTo(44);
    }];
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(btnClick:) Font:DEFAULT_FONT_R(15) BackgroundColor:UIColor.clearColor Color:KBlack333TextColor Frame:CGRectMake(12, KStatusBarHeight + 2, 40, 40) Alignment:NSTextAlignmentCenter Tag:1];
    [btn setImage:IMAGE_NAMED(@"bar_back") forState:UIControlStateNormal];
    [imgV addSubview:btn];
    
    UILabel *instro = [UILabel creatLabelWithTitle:@"可提现金额（元）" textColor:KWhiteTextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(12)];
    [imgV addSubview:instro];
    [instro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(29);
        make.right.mas_equalTo(imgV).offset(-50);
        make.left.mas_equalTo(imgV).offset(50);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *money = [UILabel creatLabelWithTitle:@"" textColor:KWhiteTextColor textAlignment:NSTextAlignmentCenter font:DIN_Medium_FONT_R(45)];
    [imgV addSubview:money];
    self.moneyL = money;
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(instro.mas_bottom).offset(5);
        make.right.mas_equalTo(imgV).offset(-12);
        make.left.mas_equalTo(imgV).offset(12);
        make.height.mas_equalTo(55);
    }];
    
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",self.moneyStr]];
    NSRange range = NSMakeRange(0,1);
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_M(30) range:range];
    money.attributedText = attributeMarket;
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, KStatusBarHeight + 164 + 359)];
    self.headerView.backgroundColor = UIColor.clearColor;
    [self.headerView addSubview:imgV];
    
    [self contentView];
    [self getContent];
    [self getBindingState];
}

- (void)getMoney{
    [THHttpManager GET:@"user/UserStatistics/queryIncomeSta" parameters:@{} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            if ([data objectForKey:@"operableIncome"]) {
                self.moneyStr = [NSString stringWithFormat:@"%.2f",[[data objectForKey:@"operableIncome"] floatValue]];
                NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",self.moneyStr]];
                [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_M(30) range:NSMakeRange(0,1)];
                self.moneyL.attributedText = attributeMarket;
            }
        }
    }];
}

- (void)getBindingState{
    [self startLoadingHUD];
    [THHttpManager GET:@"shop/shopUser/bindingState" parameters:@{} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            [self stopLoadingHUD];
            if ([data isKindOfClass:[NSDictionary class]] && returnCode == 200) {
                NSString *bindAli = [NSString stringWithFormat:@"%@",K_NotNullHolder([data objectForKey:@"bindAli"], @"")];
                NSString *bindWechat = [NSString stringWithFormat:@"%@",K_NotNullHolder([data objectForKey:@"bindWechat"], @"")];
                
                self.zhifubaoView.bindingBtn.hidden = bindAli.integerValue == 1;
                self.weixinView.bindingBtn.hidden = bindWechat.integerValue == 1;
            }
        }
    }];
}

- (void)getContent{
    [THHttpManager GET:@"commons/articleInfo/getArticleInfo" parameters:@{@"articleCode":@"ShopWithdrawBalance"} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            NSString *content = @"";
            if ([data objectForKey:@"content"]) {
                id contentS = [data objectForKey:@"content"];
                if (![contentS isEqual:[NSNull null]]) {
                    content = [data objectForKey:@"content"];
                }
                CGFloat lableHeight = [content sizeWithLabelWidth:(ScreenWidth - 48) font:DEFAULT_FONT_R(13)].height+1;
                UIView *contentV = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , ScreenWidth, lableHeight + 51+12+12)];
                contentV.backgroundColor = KBGColor;
                
                UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(12, 12, ScreenWidth - 24, lableHeight + 51+12)];
                whiteView.backgroundColor = KWhiteBGColor;
                whiteView.clipsToBounds = YES;
                whiteView.layer.cornerRadius = 8;
                [contentV addSubview:whiteView];
                
                UILabel *title = [UILabel creatLabelWithTitle:@"提现说明" textColor:KBlack666TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(15)];
                title.frame = CGRectMake(12, 20, ScreenWidth - 48, 23);
                [whiteView addSubview:title];
                
                UILabel *contentL = [UILabel creatLabelWithTitle:content textColor:KBlack999TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
                contentL.numberOfLines = 0;
                contentL.frame = CGRectMake(12, 51, ScreenWidth - 48, lableHeight);
                [whiteView addSubview:contentL];
                
                self.tableView.tableFooterView = contentV;
            }
        }
    }];
}

- (void)contentView{
    
    UIView *contentWhiteView = [[UIView alloc]initWithFrame:CGRectMake(12, KStatusBarHeight + 164, ScreenWidth - 24, 359)];
    contentWhiteView.backgroundColor = KWhiteBGColor;
    contentWhiteView.clipsToBounds = YES;
    contentWhiteView.layer.cornerRadius = 8;
    [self.view addSubview:contentWhiteView];
    [self.headerView addSubview:contentWhiteView];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"提现金额" textColor:KBlack666TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    [contentWhiteView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentWhiteView).offset(20);
        make.right.mas_equalTo(contentWhiteView).offset(-12);
        make.left.mas_equalTo(contentWhiteView).offset(12);
        make.height.mas_equalTo(23);
    }];
    
    UILabel *money = [UILabel creatLabelWithTitle:@"¥" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DIN_Medium_FONT_R(30)];
    money.frame = CGRectMake(12, 63, 20, 50);
    [contentWhiteView addSubview:money];
    
    //CGRectMake(ScreenWidth - 24 - 76, 0, 64, 24)
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"全部提现" Target:self Action:@selector(btnClick:) Font:DEFAULT_FONT_R(15) BackgroundColor:UIColor.clearColor Color:KMaintextColor Frame:CGRectMake(ScreenWidth - 24 - 24, 0, 12, 24) Alignment:NSTextAlignmentCenter Tag:2];
    btn.centerY = money.centerY;
    btn.hidden = YES;
    [contentWhiteView addSubview:btn];
    
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectZero];
    field.placeholder = @"请输入金额";
    field.keyboardType = UIKeyboardTypeNumberPad;
    field.font = DEFAULT_FONT_R(30);
    [contentWhiteView addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(money.mas_centerY);
        make.left.mas_equalTo(money.mas_right).offset(5);
        make.right.mas_equalTo(btn.mas_left).offset(-10);
        make.height.mas_equalTo(40);
    }];
    self.moneyField = field;
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor = KBlackLineColor;
    lineV.frame = CGRectMake(12, 116, ScreenWidth - 48, 1);
    [contentWhiteView addSubview:lineV];
    
    UILabel *type = [UILabel creatLabelWithTitle:@"提现方式" textColor:KBlack666TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    [contentWhiteView addSubview:type];
    [type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineV.mas_bottom).offset(40);
        make.right.mas_equalTo(contentWhiteView).offset(-12);
        make.left.mas_equalTo(contentWhiteView).offset(12);
        make.height.mas_equalTo(23);
    }];
    
    BaseButton *withdrawBtn = [BaseButton CreateBaseButtonTitle:@"申请提现" Target:self Action:@selector(btnClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
    withdrawBtn.clipsToBounds = YES;
    withdrawBtn.layer.cornerRadius = 25;
    [contentWhiteView addSubview:withdrawBtn];
    [withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineV.mas_bottom).offset(172);
        make.right.mas_equalTo(contentWhiteView).offset(-12);
        make.left.mas_equalTo(contentWhiteView).offset(12);
        make.height.mas_equalTo(50);
    }];
    
//    BaseButton *recordBtn = [BaseButton CreateBaseButtonTitle:@"历史提现记录" Target:self Action:@selector(btnClick:) Font:DEFAULT_FONT_R(13) BackgroundColor:UIColor.clearColor Color:KBlack666TextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:4];
//    [self.view addSubview:recordBtn];
//    [recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(contentWhiteView.mas_bottom).offset(12);
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.height.mas_equalTo(21);
//        make.width.mas_equalTo(80);
//    }];
    
    for (int i =0; i < 2; i ++) {

        BOOL zhifubao = (i == 0);
        withdrawTypeView *view = [[withdrawTypeView alloc]initWithFrame:CGRectMake(0, 181 + 48*i, ScreenWidth - 24, 48)];
        view.lineView.hidden = !zhifubao;
        view.iconImgV.image = zhifubao? IMAGE_NAMED(@"withdraw_record_zhifubao") : IMAGE_NAMED(@"withdraw_record_weixin");
        view.typeL.text = zhifubao ? @"支付宝提现":@"微信提现";
        view.selected = zhifubao;
        view.bindingBtn.hidden = YES;
        if ( i == 0) {
            self.zhifubaoView = view;
        }else{
            self.weixinView = view;
        }
        [contentWhiteView addSubview:view];
        view.viewClickBlock = ^{
            if (i == 0) {
                self.zhifubaoView.selected = YES;
                self.weixinView.selected = NO;
            }else{
                self.zhifubaoView.selected = NO;
                self.weixinView.selected = YES;
            }
        };
    }
    self.tableView.tableHeaderView = self.headerView;
}

- (void)withdrawOperation{
    
    [self startLoadingHUD];
    //提现方式1微信、2支付宝、3银行卡
    CJWeakSelf()
    [THHttpManager FormatPOST:@"user/shopWithdraw/applyWithdraw" parameters:@{@"moneyValue":self.moneyField.text,@"accountType":self.zhifubaoView.selected ? @"2":@"1"} dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        CJStrongSelf()
        [self stopLoadingHUD];
        if (returnCode == 200) {
            withdrawResultViewController *vc = [[withdrawResultViewController alloc]init];
            vc.money = self.moneyField.text;
            vc.typeStr = self.zhifubaoView.selected ? @"支付宝":@"微信";
            vc.viewBlock = ^{
                [self getMoney];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
}

- (void)btnClick:(BaseButton *)btn{
    if (btn.tag == 1) {//返回
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag == 2){//全部提现
        self.moneyField.text = @"199.9";
    }else if (btn.tag == 3){//申请提现
        if (!self.zhifubaoView.bindingBtn.hidden && self.zhifubaoView.selected) {
            [self showMessageWithString:@"请先绑定支付宝"];
            return;
        }
        if (!self.weixinView.bindingBtn.hidden && self.weixinView.selected) {
            [self showMessageWithString:@"请先绑定微信"];
            return;
        }
        if (self.moneyField.text.length == 0) {
            [self showMessageWithString:@"请输入提现金额"];
            return;
        }
        if ([self.moneyField.text integerValue]  > [self.moneyStr integerValue]) {
            [self showMessageWithString:@"请输入正确的提现金额"];
            return;
        }
        if ([self.moneyField.text integerValue] % 100 !=0) {
            [self showMessageWithString:@"请输入整百提现金额"];
            return;
        }
        [self withdrawOperation];
    }else if (btn.tag == 4){//提现记录
        withdrawRecordViewController *vc = [[withdrawRecordViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}

@end


@interface withdrawTypeView ()

@end

@implementation withdrawTypeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    UIImageView *image = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"withdraw_record_zhifubao")];
    [self addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(18);
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self).offset(12);
    }];
    self.iconImgV = image;
    
    UILabel *title = [UILabel creatLabelWithTitle:@"支付宝提现" textColor:KBlack666TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(image.mas_top).offset(-2);
        make.left.mas_equalTo(image.mas_right).offset(10);
        make.height.mas_equalTo(22);
    }];
    self.typeL = title;
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = KBlackLineColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-1);
        make.left.mas_equalTo(self).offset(12);
        make.right.mas_equalTo(self).offset(-12);
        make.height.mas_equalTo(1);
    }];
    self.lineView = line;
    
    UIImageView *rightImage = [[UIImageView alloc]initWithImage:KPlaceholder_DefaultImage];
    [self addSubview:rightImage];
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(18);
        make.centerY.equalTo(image.mas_centerY);
        make.right.equalTo(self).offset(-12);
    }];
    self.rightImgV = rightImage;

    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)]];
    
    self.bindingBtn = [BaseButton CreateBaseButtonTitle:@"去绑定" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_R(12) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:22];
    self.bindingBtn.layer.cornerRadius = 8;
    self.bindingBtn.clipsToBounds = YES;
    [self addSubview:self.bindingBtn];
    [self.bindingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(52);
        make.height.mas_equalTo(25);
        make.centerY.equalTo(title.mas_centerY);
        make.left.equalTo(title.mas_right).offset(10);
    }];
}

- (void)tapClick{
    if (_viewClickBlock) {
        _viewClickBlock();
    }
}

- (void)btnClick{
    ThirdBingDingViewController *vc = [[ThirdBingDingViewController alloc]init];
    [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
}

-(void)setSelected:(BOOL)selected{
    _selected = selected;
    self.rightImgV.image = _selected ? IMAGE_NAMED(@"choosed") : IMAGE_NAMED(@"choose");
}

- (void)setRightImgVName:(NSString *)rightImgVName{
    self.rightImgV.image = IMAGE_NAMED(rightImgVName);
}

@end

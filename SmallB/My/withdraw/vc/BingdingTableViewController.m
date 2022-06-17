//
//  BingdingTableViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/15.
//

#import "BingdingTableViewController.h"
#import "BaseFieldTableViewCell.h"
#import "BasePhoneCodeTableViewCell.h"
#import "BingdingFailViewController.h"
#import <AFServiceSDK/AFServiceSDK.h>
#import "WXApi.h"
#import "BasePhoneTableViewCell.h"
#import "BaseCommonPhoneCell.h"

@interface BingdingTableViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , copy) NSString*phone;
@property (nonatomic , copy) NSString*code;

@property (nonatomic , copy) NSString*openID;
@property (nonatomic , copy) NSString*realName;

@property (nonatomic , copy) NSString*accountNo;

@end

@implementation BingdingTableViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    self.navigationItem.title = self.index == 0 ? @"绑定支付宝": @"绑定微信";
    self.phone = @"";
    self.code = @"";
    self.openID = @"";
    self.realName = @"";
    self.accountNo = @"";
    NSString *userPhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"];
    if (userPhone.length) {
        self.phone = userPhone;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxLoginSuccess:)  name:@"wxLoginSuccess" object:nil];
    
    self.view.backgroundColor = KWhiteBGColor;
    self.tableView.backgroundColor = KWhiteBGColor;
    [self.tableView registerClass:[BaseFieldTableViewCell class] forCellReuseIdentifier:[BaseFieldTableViewCell description]];
    [self.tableView registerClass:[BasePhoneCodeTableViewCell class] forCellReuseIdentifier:[BasePhoneCodeTableViewCell description]];
    [self.tableView registerClass:[BasePhoneTableViewCell class] forCellReuseIdentifier:[BasePhoneTableViewCell description]];
    [self.tableView registerClass:[BaseCommonPhoneCell class] forCellReuseIdentifier:[BaseCommonPhoneCell description]];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    UIView *headerView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
    headerView.backgroundColor = KWhiteBGColor;
    self.tableView.tableHeaderView = headerView;
    
    [self creatFirstFooterView];
}

- (void)creatFirstFooterView{
    UIView *footerView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 58)];
    footerView.backgroundColor = KWhiteBGColor;
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:self.index == 0 ?@"确定绑定":@"获取微信信息" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_M(17) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectMake(12, 8, ScreenWidth - 24, 50) Alignment:NSTextAlignmentCenter Tag:1];
    btn.layer.cornerRadius = 25;
    btn.clipsToBounds = YES;
    [footerView addSubview:btn];
    self.tableView.tableFooterView = footerView;
}

- (void)creatSecondFooterViewWithLogo:(NSString *)logoUrl name:(NSString *)name{
    UIView *footerView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 58+190)];
    footerView.backgroundColor = KWhiteBGColor;

    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2.0-51, 26, 102, 102)];
    image.clipsToBounds = YES;
    image.layer.cornerRadius = 4;
    if (logoUrl.length) {
        [image sd_setImageWithURL:[NSURL URLWithString:logoUrl]];
    }
    [footerView addSubview:image];

    UILabel *title = [UILabel creatLabelWithTitle:@"微信昵称" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(15)];
    title.frame = CGRectMake(12, 142, ScreenWidth - 24, 25);
    title.text = self.index == 0 ? @"支付宝昵称": @"微信昵称";
    if (name.length) {
        title.text = name;
    }
    [footerView addSubview:title];

    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"确定绑定" Target:self Action:@selector(bingDingBtnClick) Font:DEFAULT_FONT_M(17) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    btn.layer.cornerRadius = 25;
    btn.clipsToBounds = YES;
    [footerView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(footerView).offset(12);
        make.right.mas_equalTo(footerView).offset(-12);
        make.bottom.mas_equalTo(footerView).offset(-12);
        make.height.mas_equalTo(50);
    }];
    self.tableView.tableFooterView = footerView;
}

- (void)bingDingBtnClick{
    [self startLoadingHUD];
    //accountNo   收款银行账户/支付宝账号/微信openid
    //accountType 1微信 2支付宝 3银行卡
    //realName
    NSDictionary *dica;
    if (self.index == 0) {
        dica = @{@"accountNo":self.accountNo,@"accountType":[NSString stringWithFormat:@"%ld",2 - self.index],@"realName":self.realName,@"phoneNum":self.phone,@"verificationCode":self.code};
    }else{
        dica = @{@"accountNo":self.openID,@"accountType":[NSString stringWithFormat:@"%ld",2 - self.index],@"phoneNum":self.phone,@"verificationCode":self.code,@"realName":self.realName};
    }
    [THHttpManager FormatPOST:@"user/shopWithdraw/saveWithdrawWay" parameters:dica dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200) {
            if (_viewBlock) {
                _viewBlock();
            }
            [self showSuccessMessageWithString:@"绑定成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

-(void)wxLoginSuccess:(NSNotification*)notification{
    
    NSDictionary * dictionary = notification.object;
    //获取code
    [THHttpManager AliGET:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",weChatAppID,weChatAppSecret,dictionary[@"code"]] parameters:@{} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            self.openID = [data objectForKey:@"openid"];
            [THHttpManager AliGET:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",[data objectForKey:@"access_token"],self.openID] parameters:@{} block:^(NSInteger returnCode, THRequestStatus status, id data) {
                if ([data isKindOfClass:[NSDictionary class]]) {
                    self.tableView.tableHeaderView = nil;
                    NSString *logo = @"";
                    NSString *nickname = @"";
                    if ([data objectForKey:@"headimgurl"]) {
                        logo = K_NotNullHolder([data objectForKey:@"headimgurl"], @"");
                    }
                    if ([data objectForKey:@"nickname"]) {
                        nickname = K_NotNullHolder([data objectForKey:@"nickname"], @"");
                    }
                    [self creatSecondFooterViewWithLogo:logo name:nickname];
                }
            }];
        }
    }];
}

- (void)getAliData{
    
    NSString *url = @"https://authweb.alipay.com/auth?auth_type=PURE_OAUTH_SDK&app_id=2021003130655095&scope=auth_user&state=init";  //登陆授权或别的需要跳转到支付宝完成操作的Url
    NSDictionary *params = @{kAFServiceOptionBizParams: @{
                                     @"url": url//@""
                                     },
                             kAFServiceOptionCallbackScheme: @"XLXPinAPP",
                             };
    
    [AFServiceCenter callService:AFServiceAuth withParams:params andCompletion:^(AFAuthServiceResponse *response) {
        NSLog(@"授权结果:%@", response.result);
        if ([response.result isKindOfClass:[NSDictionary class]]) {
            NSString *auth_code = K_NotNullHolder([response.result objectForKey:@"auth_code"], @"");
            //@"https://openapi.alipay.com/gateway.do?timestamp=2022-01-01 08:08:08&method=alipay.system.oauth.token&app_id=2021003130655095&sign_type=RSA2&sign=234&version=1.0&charset=GBK&grant_type=authorization_code&code=%@",auth_code]
            NSDictionary *dica = @{@"timestamp":@"2022-01-01 08:08:08",
                                   @"method":@"alipay.system.oauth.token",
                                   @"app_id":@"2021003130655095",
                                   @"sign_type":@"RSA2",
                                   @"sign":@"234",
                                   @"version":@"1.0",
                                   @"charset":@"GBK",
                                   @"grant_type":@"GBK",
                                   @"charset":@"GBK",
            };
            [THHttpManager AliGET:[NSString stringWithFormat:@"https://openapi.alipay.com/gateway.do?timestamp=2022-01-01 08:08:08&method=alipay.system.oauth.token&app_id=2021003130655095&sign_type=RSA2&sign=234&version=1.0&charset=GBK&grant_type=authorization_code&code=%@",auth_code] parameters:@{} block:^(NSInteger returnCode, THRequestStatus status, id data) {
                
            }];
        }
    }];
}

- (void)getWeiXinData{
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq* req =[[SendAuthReq alloc]init];
        req.scope = @"snsapi_userinfo";
        req.state = @"123";
        [WXApi sendReq:req completion:^(BOOL success) {
            
        }];
    }else{
        [self showMessageWithString:@"请先安装微信"];
    }
}

- (void)btnClick{
    
    if (self.phone.length == 0) {
        [self showMessageWithString:@"请输入手机号"];
        return;
    }
    if (self.code.length == 0) {
        [self showMessageWithString:@"请输入验证码"];
        return;
    }
    if (self.realName.length == 0) {
        [self showMessageWithString:@"请输入真实姓名"];
        return;
    }
    if (self.index == 1) {
        [self getWeiXinData];
    }else{
        if (self.accountNo.length == 0) {
            [self showMessageWithString:@"请输入支付宝提现账户"];
            return;
        }
        [self bingDingBtnClick];
    }
    return;
    BingdingFailViewController *alertVC = [BingdingFailViewController new];
    alertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self  presentViewController:alertVC animated:NO completion:nil];
}

#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.index == 1 ? 3 : 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        BaseCommonPhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseCommonPhoneCell description]];
        cell.contentView.backgroundColor = KWhiteBGColor;
        cell.BGView.backgroundColor = kRGB(245, 245, 245);
        NSString *userPhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"];
        if (userPhone.length) {
            self.phone = userPhone;
        }
        return cell;
    }
    
    if (indexPath.section == 1) {
        BasePhoneCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BasePhoneCodeTableViewCell description]];
        cell.phoneType = self.index == 0 ? @"9":@"10";
        cell.fieldT.placeholder = @"请输入验证码";
        cell.contentView.backgroundColor = KWhiteBGColor;
        cell.bgView.backgroundColor = KWhiteBGColor;
        cell.phone = self.phone;
        cell.viewBlock = ^(NSString * _Nonnull content) {
            self.code = content;
        };
        return cell;
    }
    BaseFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseFieldTableViewCell description]];
    cell.fieldT.placeholder = indexPath.section == 2 ? @"请输入真实姓名" : @"请输入支付宝提现账户";
    cell.fieldT.clearButtonMode = UITextFieldViewModeWhileEditing;
    cell.contentView.backgroundColor = KWhiteBGColor;
    cell.bgView.backgroundColor = kRGB(245, 245, 245);
    cell.viewBlock = ^(NSString * _Nonnull content) {
        if (indexPath.section == 2) {
            self.realName = content;
        }else{
            self.accountNo = content;
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
    view.backgroundColor = KWhiteBGColor;
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    SetIOS13;
    [navigationController setNavigationBarHidden:NO animated:YES];
}

@end




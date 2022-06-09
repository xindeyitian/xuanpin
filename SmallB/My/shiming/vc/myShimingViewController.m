//
//  myShimingViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import "myShimingViewController.h"
#import "myOrderListContentViewController.h"

@interface myShimingViewController ()<UINavigationControllerDelegate,JXCategoryViewDelegate,JXCategoryListContainerViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;//菜单标题view
@property (nonatomic, strong) JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, copy)NSString *phone;
@property (nonatomic, strong)UIButton *chooseButton;
@property (nonatomic, copy)NSString *nameStr;
@property (nonatomic, copy)NSString *idCardNum;
@property (nonatomic, copy)NSString *phoneCode;

@end

@implementation myShimingViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.phone = @"";
    self.nameStr = @"";
    self.idCardNum = @"";
    self.phoneCode = @"";

    self.navigationController.delegate = self;
    self.navigationItem.title = @"实名认证";
    
    self.view.backgroundColor = KBGColor;
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(12);
        } else {
            make.top.equalTo(self.view).offset(KNavBarHeight).offset(12);
        }
    }];
    self.needPullDownRefresh = YES;
    [self getShimingInfo];
}

- (void)loadNewData{
    [super loadNewData];
    [self getShimingInfo];
}

- (void)getShimingInfo{
    if (!self.tableView.mj_header.isRefreshing) {
        [self startLoadingHUD];
    }
    [THHttpManager POST:@"shop/shopIdcardAuth/queryIdCard" parameters:@{} dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        [self.tableView.mj_header endRefreshing];
        if ([data isKindOfClass:[NSDictionary class]] && returnCode == 200) {
            [self creatHeaderViewWithData:data];
            [self creatFooterView];
        }else{
            [self creatHeaderView];
            [self creatFooterView];
        }
    }];
}

- (void)creatHeaderViewWithData:(NSDictionary *)dica{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 181+12)];
    headerView.backgroundColor = KBGColor;
    
    UIView *whiteV = [[UIView alloc]init];
    whiteV.backgroundColor = KWhiteBGColor;
    whiteV.layer.cornerRadius = 8;
    whiteV.clipsToBounds = YES;
    [headerView addSubview:whiteV];
    [whiteV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(headerView).insets(UIEdgeInsetsMake(0, 12, 0, 12));
    }];
    
    NSArray *titleAry = @[@"姓名",@"身份证号"];
    NSArray *imageAry = @[@"my_shiming_name",@"my_shiming_card"];
    float maxY = .0f;
    for (int i =0; i < 2; i ++) {
        
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(12, 22+81*i, 18, 18)];
        imgV.image = IMAGE_NAMED(imageAry[i]);
        [whiteV addSubview:imgV];
        
        UILabel *title = [UILabel creatLabelWithTitle:titleAry[i] textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
        title.frame = CGRectMake(34, 20 + 81*i, ScreenWidth - 24 - 46, 24);
        [whiteV addSubview:title];
        
        UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(34, 40+80*i, ScreenWidth - 24 - 46, 40)];
        field.placeholder = [NSString stringWithFormat:@"请输入%@",titleAry[i]];
        field.font = DEFAULT_FONT_R(15);
        field.userInteractionEnabled = NO;
        [whiteV addSubview:field];
        if ([dica objectForKey:@"realName"] && i == 0) {
            field.text = [dica objectForKey:@"realName"];
        }
        if ([dica objectForKey:@"idCard"] && i == 1) {
            field.text = [dica objectForKey:@"idCard"];
        }
    
        if (i == 1) {
            maxY = field.frame.origin.y + 40;
        }
    }
    headerView.frame = CGRectMake(0, 0, ScreenWidth, maxY + 12 + 16);
    self.tableView.tableHeaderView = headerView;
}

- (void)creatHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 500)];
    headerView.backgroundColor = KBGColor;
    
    UIView *whiteV = [[UIView alloc]init];
    whiteV.backgroundColor = KWhiteBGColor;
    whiteV.layer.cornerRadius = 8;
    whiteV.clipsToBounds = YES;
    [headerView addSubview:whiteV];
    [whiteV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(headerView).insets(UIEdgeInsetsMake(0, 12, 0, 12));
    }];
    //姓名或身份证填写错误，请重填！
    //身份证绑定成功
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"提交实名认证" Target:self Action:@selector(submitClick) Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    btn.layer.cornerRadius = 22;
    btn.clipsToBounds = YES;
    [whiteV addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(whiteV).offset(88);
        make.right.mas_equalTo(whiteV).offset(-88);
        make.bottom.mas_equalTo(whiteV).offset(-13);
        make.height.mas_equalTo(44);
    }];
    
    NSArray *titleAry = @[@"姓名",@"身份证号",@"手机号码",@"验证码"];
    NSArray *imageAry = @[@"my_shiming_name",@"my_shiming_card",@"my_shiming_phone",@"my_shiming_code"];
    float maxY = .0f;
    for (int i =0; i < 4; i ++) {
        
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(12, 22+81*i, 18, 18)];
        imgV.image = IMAGE_NAMED(imageAry[i]);
        [whiteV addSubview:imgV];
        
        UILabel *title = [UILabel creatLabelWithTitle:titleAry[i] textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
        title.frame = CGRectMake(34, 20 + 81*i, ScreenWidth - 24 - 46, 24);
        [whiteV addSubview:title];
         
        UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(34, 40+80*i, ScreenWidth - 24 - 46, 40)];
        field.placeholder = [NSString stringWithFormat:@"请输入%@",titleAry[i]];
        field.font = DEFAULT_FONT_R(15);
        field.delegate = self;
        field.tag = 111 +i;
        [whiteV addSubview:field];
        if (i == 3) {
            field.frame = CGRectMake(34, 40+80*i, ScreenWidth - 24 - 46 - 120, 40);
            BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"获取验证码" Target:self Action:@selector(codeClick:) Font:DEFAULT_FONT_R(12) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
            btn.clipsToBounds = YES;
            btn.layer.cornerRadius = 16;
            [whiteV addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(field.mas_top).offset(-14);
                make.right.mas_equalTo(whiteV).offset(-12);
                make.height.mas_equalTo(32);
                make.width.mas_equalTo(90);
            }];
            
            field.keyboardType = UIKeyboardTypeNumberPad;
        }else{
            if (i == 2) {
                NSString *userPhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"];
                if (userPhone.length) {
                    self.phone = userPhone;
                    field.text = userPhone;
                    field.userInteractionEnabled = NO;
                }
                field.keyboardType = UIKeyboardTypeNumberPad;
            }
        }
        
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(34, 80*i+80, ScreenWidth - 70, 1)];
        lineV.backgroundColor = KBlackLineColor;
        [whiteV addSubview:lineV];
        if (i == 3) {
            maxY = lineV.frame.origin.y + 1;
        }
    }
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(12, maxY + 27, ScreenWidth -88, 30)];
    [button setImage:IMAGE_NAMED(@"choose") forState:UIControlStateNormal];
    [button setImage:IMAGE_NAMED(@"choosed") forState:UIControlStateSelected];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:button];
    self.chooseButton = button;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"已阅读并同意《供应链用户服务协议》" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#999999"]}];
    
    [text setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],
                          NSForegroundColorAttributeName : KMaintextColor} range:NSMakeRange(6, 11)];
    [button.titleLabel setAttributedText:text];
    [button setAttributedTitle:text forState:UIControlStateNormal];
    
    [button.titleLabel yb_addAttributeTapActionWithRanges:@[NSStringFromRange(NSMakeRange(6, 11))] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
        YinsiFuwuViewController * pvc = [[YinsiFuwuViewController alloc] init];
        pvc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:pvc animated:YES completion:nil];
    }];
    
    headerView.frame = CGRectMake(0, 0, ScreenWidth, maxY + 12 + 114);
    self.tableView.tableHeaderView = headerView;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 111) {
        self.nameStr = textField.text;
    }
    if (textField.tag == 112) {
        self.idCardNum = textField.text;
    }
    if (textField.tag == 113) {
        self.phone = textField.text;
    }
    if (textField.tag == 114) {
        self.phoneCode = textField.text;
    }
}

- (void)btnClick:(UIButton *)btn{
    btn.selected =  !btn.selected;
}

- (void)codeClick:(BaseButton *)sender{
    if (self.phone == 0) {
        [self showMessageWithString:@"请输入手机号"];
        return;
    }
    if (self.phone.length != 11) {
        [self showMessageWithString:@"请输入正确的手机号"];
        return;
    }
    [self startLoadingHUD];
    NSString *phone = [self.phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    [THHttpManager GET:[NSString stringWithFormat:@"%@",@"system/login/sendPhoneCode"] parameters:@{@"phoneNumber":phone,@"type":@"3"} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200) {
            __block int timeout=60;
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [sender setTitle:@"重新获取" forState:UIControlStateNormal];
                        [sender setBackgroundColor:[UIColor colorWithHexString:@"FA776D" alpha:1.0]];
                        sender.enabled = YES;
                    });
                }else{
                    int seconds = timeout;
                    NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [sender setBackgroundColor:[UIColor colorWithHexString:@"FA776D" alpha:0.45]];
                        sender.enabled = NO;
                        [sender setTitle:[NSString stringWithFormat:@"%@ 秒后",strTime] forState:UIControlStateNormal];
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }];
}

- (void)submitClick{
    
    if (self.nameStr.length == 0) {
        [self showMessageWithString:@"请输入姓名"];
        return;
    }
    if (self.idCardNum.length == 0) {
        [self showMessageWithString:@"请输入身份证号"];
        return;
    }
    if (self.phone.length == 0) {
        [self showMessageWithString:@"请输入手机号"];
        return;
    }
    if (self.phoneCode.length == 0) {
        [self showMessageWithString:@"请输入验证码"];
        return;
    }
    if (!self.chooseButton.selected) {
        [self showMessageWithString:@"请阅读并同意《供应链用户服务协议》"];
        return;
    }
    [self startLoadingHUD];
    NSDictionary *dataDic = @{@"idCard":self.idCardNum,
                              @"phoneNum":self.phone,
                              @"realName":self.nameStr,
                              @"verificationCode":self.phoneCode,
    };
    NSDictionary *dica = @{@"shopIdcardAuth":dataDic};
    [THHttpManager POST:@"shop/shopIdcardAuth/authIdCard" parameters:dataDic dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200) {
            [self showSuccessMessageWithString:@"实名认证成功"];
            if (_shimingSuccessBlock) {
                _shimingSuccessBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)creatFooterView{
    
    [THHttpManager GET:@"commons/articleInfo/getArticleInfo" parameters:@{@"articleCode":@"AuthIdCard"} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            NSString *contentStr = @"";
            if ([data objectForKey:@"content"]) {
                id contentS = [data objectForKey:@"content"];
                if (![contentS isEqual:[NSNull null]]) {
                    contentStr = [data objectForKey:@"content"];
                }
            }
            float height = [contentStr sizeWithLabelWidth:ScreenWidth - 48 font:DEFAULT_FONT_R(13)].height+1;
            
            UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, height +51 + 24)];
            footerView.backgroundColor = KBGColor;
            self.tableView.tableFooterView = footerView;
            
            UIView *whiteV = [[UIView alloc]init];
            whiteV.backgroundColor = KWhiteBGColor;
            whiteV.layer.cornerRadius = 8;
            whiteV.clipsToBounds = YES;
            [footerView addSubview:whiteV];
            [whiteV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(footerView).insets(UIEdgeInsetsMake(12, 12, 0, 12));
            }];
            
            UILabel *title = [UILabel creatLabelWithTitle:@"实名认证说明" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(15)];
            title.frame = CGRectMake(0, 20, ScreenWidth - 24, 24);
            [whiteV addSubview:title];
            
            UILabel *content = [UILabel creatLabelWithTitle:contentStr textColor:KBlack999TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(13)];
            [whiteV addSubview:content];
            content.numberOfLines = 0;
            [content mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(whiteV).offset(12);
                make.right.mas_equalTo(whiteV).offset(-12);
                make.top.mas_equalTo(title.mas_bottom).offset(8);
                make.bottom.mas_equalTo(whiteV).offset(-12);
            }];
        }
    }];
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



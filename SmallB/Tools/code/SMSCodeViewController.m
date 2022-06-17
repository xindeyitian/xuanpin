//
//  SMSCodeViewController.m
//  ObjectiveCTools
//
//  Created by aidong on 2020/10/13.
//  Copyright © 2020 姬友大人. All rights reserved.
//

#import "SMSCodeViewController.h"
#import "SMSCodeInputView.h"
#import "UserDetailInfoModel.h"
#import "MainTabarViewController.h"
#import "CouponChooseViewController.h"

@interface SMSCodeViewController ()

@property (strong, nonatomic) SMSCodeInputView *inputView;
@property (strong, nonatomic) UILabel *codeL;

@end

@implementation SMSCodeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, KStatusBarHeight + 7, 30, 30)];
    [backBtn setBackgroundImage:IMAGE_NAMED(@"back") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backOperation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"输入验证码" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(24)];
    title.frame = CGRectMake(50, KNavBarHeight + 61, ScreenWidth - 100, 33);
    [self.view addSubview:title];
    
    UILabel *subTitle = [UILabel creatLabelWithTitle:[NSString stringWithFormat:@"验证码已经发送至 +86 %@",self.phoneStr] textColor:KBlack999TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    subTitle.frame = CGRectMake(50, KNavBarHeight + 94, ScreenWidth - 100, 17);
    [self.view addSubview:subTitle];

    self.inputView = [[SMSCodeInputView alloc] initWithFrame:CGRectMake(50, KNavBarHeight + 141, [UIScreen mainScreen].bounds.size.width - 100, 57)];
    [self.view addSubview:self.inputView];
    CJWeakSelf()
    self.inputView.viewBlock = ^{
        CJStrongSelf()
        [self.inputView resignFirstResponder];
        [self loginRequest];
    };
    
    UILabel *code = [UILabel creatLabelWithTitle:@"60 秒后重新获取验证码" textColor:KMaintextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    code.frame = CGRectMake(50, KNavBarHeight + 238, ScreenWidth - 100, 33);
    [self.view addSubview:code];
    self.codeL = code;
    
    self.view.userInteractionEnabled = YES;
    [code addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(codeOperation)]];
    //[self sendCode];
}

- (void)loginRequest{
    //
    [self startLoadingHUD];
    CJWeakSelf()
    [THHttpManager GET:@"system/login/loginForCode" parameters:@{@"phoneNumber":self.phoneStr,@"verificationCode":self.inputView.codeText} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        CJStrongSelf()
        [self stopLoadingHUD];
        if (returnCode == 200) {
            [self.inputView resignFirstResponder];
            if ([data isKindOfClass:[NSDictionary class]]) {
                UserDetailInfoModel *model = [UserDetailInfoModel mj_objectWithKeyValues:data];
                if (model.token) {
                    [AppTool saveToLocalToken:model.token];
                    [[NSUserDefaults standardUserDefaults]  setValue:@"2" forKey:@"login"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                if (model.LoginUserVo.avatar) {
                    [AppTool saveToLocalDataWithValue:model.LoginUserVo.avatar key:@"userLogo"];
                }
                if (model.LoginUserVo.phoneNum) {
                    [AppTool saveToLocalDataWithValue:model.LoginUserVo.phoneNum key:@"userPhone"];
                }
                if (model.LoginUserVo.storeDisplayType) {
                    [AppTool setCurrentLevalWithData:model.LoginUserVo.storeDisplayType];
                }
                if (model.LoginUserVo.djlsh) {
                    [AppTool saveToLocalDataWithValue:model.LoginUserVo.djlsh key:@"userID"];
                }
                if (model.LoginUserVo.shopId) {
                    [AppTool saveToLocalDataWithValue:model.LoginUserVo.shopId key:@"shopID"];
                }
//                    [UserDefaults setObject:model.LoginUserVo  forKey:K_BaseModel];
//                    [UserDefaults synchronize];
                    
                MainTabarViewController * tab = [[MainTabarViewController alloc]init];
                [UIApplication sharedApplication].delegate.window.rootViewController = tab;
            }
        }
    }];
}

- (void)sendCode{
    [self startLoadingHUD];
    //类型:1注册发送短信,2登录发送短信
    [THHttpManager GET:[NSString stringWithFormat:@"%@",@"system/login/sendPhoneCode"] parameters:@{@"phoneNumber":self.phoneStr,@"type":@"2"} block:^(NSInteger returnCode, THRequestStatus status, id data) {
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
                        self.codeL.text = @"重新获取";
                        self.codeL.userInteractionEnabled = YES;
                    });
                }else{
                    int seconds = timeout;
                    NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.codeL.text = [NSString stringWithFormat:@"%@ 秒后重新获取验证码",strTime];
                        self.codeL.userInteractionEnabled = NO;
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }];
}

- (void)codeOperation{
    [self sendCode];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.inputView becomeFirstResponder];
}

- (void)backOperation{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SetIOS13;
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}

@end

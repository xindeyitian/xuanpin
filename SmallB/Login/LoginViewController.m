//
//  LoginViewController.m
//  SeaEgret
//
//  Created by MAC on 2021/4/14.
//

#import "LoginViewController.h"
#import "RegistOrForgetViewController.h"
#import "MainTabarViewController.h"
#import "LSTPopViewqqtopView.h"
#import "SMSCodeViewController.h"
#import "CouponChooseViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>{
    NSInteger i;
}
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UIButton    *loginBtn;
@property (weak, nonatomic) IBOutlet UIView *infoView;

@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;

@end

@implementation LoginViewController
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KWhiteBGColor;
    self.infoView.backgroundColor = KViewBGColor;
    i = 0;
    [UserDefaults setObject:@"0" forKey:@"isAgree"];
    self.userNameTF.delegate = self;
    self.userNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.userNameTF addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textfieldEditChange:) name:@"UITextFieldTextDidChangeNotification" object:self.userNameTF];
}
- (void)initView{
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSParagraphStyleAttributeName : style}];
    self.userNameTF.attributedPlaceholder = attributedString;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并同意《小莲云仓用户入驻协议》" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#999999"]}];
    
    [text setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],
                          NSForegroundColorAttributeName : KMaintextColor} range:NSMakeRange(7, 12)];
    [self.agreeBtn.titleLabel setAttributedText:text];
    [self.agreeBtn setAttributedTitle:text forState:UIControlStateNormal];
    [self.agreeBtn setImage:IMAGE_NAMED(@"choose") forState:UIControlStateNormal];
    [self.agreeBtn setImage:IMAGE_NAMED(@"choosed") forState:UIControlStateSelected];
    
    [self.agreeBtn.titleLabel yb_addAttributeTapActionWithRanges:@[NSStringFromRange(NSMakeRange(7, 12))] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
        YinsiFuwuViewController * pvc = [[YinsiFuwuViewController alloc] init];
        pvc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:pvc animated:YES completion:nil];
    }];
}
- (void)textFieldDidEditing:(UITextField *)textField{
    
    if (textField == self.userNameTF) {
        if (textField.text.length > i) {
            if (textField.text.length == 4 || textField.text.length == 9 ) {
                //输入
                NSMutableString * str = [[NSMutableString alloc] initWithString:textField.text];
                [str insertString:@" " atIndex:(textField.text.length-1)];
                textField.text = str;
            }if (textField.text.length >= 13 ) {
                //输入完成
                textField.text = [textField.text substringToIndex:13];
                //[textField resignFirstResponder];
            }
                i = textField.text.length;
        }else if (textField.text.length < i){
            //删除
            if (textField.text.length == 4 || textField.text.length == 9) {
                textField.text = [NSString stringWithFormat:@"%@",textField.text];
                textField.text = [textField.text substringToIndex:(textField.text.length-1)];
            }
            i = textField.text.length;
        }
    }
}
- (void)textfieldEditChange:(NSNotification *)not{
    
    UITextField *textField = not.object;
    textField.font = textField.text.length ? DIN_Medium_FONT_R(24):DEFAULT_FONT_M(15);
    
    if (textField.text.length >= 13){
        textField.text = [textField.text substringToIndex:13];
        [self changeBtnType:YES];
    }else{
        [self changeBtnType:NO];
    }
}
- (void)changeBtnType:(BOOL )type{
    if (type) {
        [self.loginBtn setBackgroundColor:[UIColor colorWithHexString:@"FA776D" alpha:1.0]];
    }else{
        [self.loginBtn setBackgroundColor:[UIColor colorWithHexString:@"FA776D" alpha:0.45]];
    }
}

- (IBAction)wechatLogin:(UIButton *)sender {
    
    
}
- (IBAction)zPayLogin:(UIButton *)sender {
    
    
}
- (IBAction)agreeDelegate:(id)sender {
    
    self.agreeBtn.selected = !self.agreeBtn.selected;
//    [self.agreeBtn setImage:IMAGE_NAMED(@"choosed") forState:UIControlStateNormal];
//    [UserDefaults setObject:@"1" forKey:@"isAgree"];
}
- (IBAction)login:(id)sender {
     if (!self.agreeBtn.selected) {
         shakeView(self.agreeBtn.layer);
         [self showMessageWithString:@"请阅读并同意隐私政策"];
     }else{
         if (self.userNameTF.text.length != 13) {
             [self showMessageWithString:@"请输入手机号"];
             return;
         }
         [self checkPhoneNum];
     }
}

- (void)checkPhoneNum{
    
    [self startLoadingHUD];
    NSString *phone = [self.userNameTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [THHttpManager GET:@"system/login/checkPhoneNum" parameters:@{@"phoneNumber":phone} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 10015) {
            RegistOrForgetViewController *vc = [[RegistOrForgetViewController alloc] init];
            vc.phoneStr = self.userNameTF.text;
            vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
            CJWeakSelf()
            vc.currentVCBlock = ^(NSString *string) {
                CJStrongSelf()
                self.userNameTF.text = string;
            };
            [self presentViewController:vc animated:YES completion:nil];
        }else{
            SMSCodeViewController *vc =  [[SMSCodeViewController alloc]init];
            vc.phoneStr = phone;
            vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self presentViewController:vc animated:YES completion:nil];
        }
    }];
}

- (IBAction)regist:(id)sender {
    RegistOrForgetViewController *vc = [[RegistOrForgetViewController alloc] init];;
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    CJWeakSelf()
    vc.currentVCBlock = ^(NSString *string) {
        CJStrongSelf()
        self.userNameTF.text = string;
    };
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}
@end

//
//  RegistOrForgetViewController.m
//  SeaEgret
//
//  Created by MAC on 2021/4/14.
//

#import "RegistOrForgetViewController.h"
#import "MainTabarViewController.h"

@interface RegistOrForgetViewController (){
    
    NSString *_location;
    NSInteger i;

}
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (weak, nonatomic) IBOutlet UITextField *smsTF;

@property (weak, nonatomic) IBOutlet LCountdownButton *smsBtn;

@property (weak, nonatomic) IBOutlet UITextField *invitationTF;

@property (weak, nonatomic) IBOutlet UIButton *locationBtn;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;

@property (strong, nonatomic)BRProvinceModel *provinceModel;
@property (strong, nonatomic)BRCityModel *cityModel;
@property (strong, nonatomic)BRAreaModel *areaModel;
@property (weak, nonatomic) IBOutlet UIView *areaView;

@end

@implementation RegistOrForgetViewController
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    i=0;
    self.titleLable.text = @"注册";
    [UserDefaults setObject:@"0" forKey:@"isAgree"];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"请输手机号" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSParagraphStyleAttributeName : style}];
    self.phoneTF.attributedPlaceholder = attributedString;
    self.phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.phoneTF addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange:) name:@"UITextFieldTextDidChangeNotification" object:self.phoneTF];
   
    NSMutableParagraphStyle *style1 = [[NSMutableParagraphStyle alloc] init];
    NSAttributedString *attributedString1 = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSParagraphStyleAttributeName : style1}];
    self.smsTF.attributedPlaceholder = attributedString1;
    [self.smsTF addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    
    NSMutableParagraphStyle *style2 = [[NSMutableParagraphStyle alloc] init];
    NSAttributedString *attributedString2 = [[NSAttributedString alloc] initWithString:@"请输入邀请码(非必填)" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSParagraphStyleAttributeName : style2}];
    self.invitationTF.attributedPlaceholder = attributedString2;

    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并同意《用户服务协议》《隐私协议》" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#999999"]}];
    [text setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],
                          NSForegroundColorAttributeName : KMaintextColor} range:NSMakeRange(7, 14)];
    self.agreeBtn.titleLabel.attributedText = text;
    [self.agreeBtn setAttributedTitle:text forState:UIControlStateNormal];
    
    [self.agreeBtn.titleLabel yb_addAttributeTapActionWithRanges:@[NSStringFromRange(NSMakeRange(7, 8)),NSStringFromRange(NSMakeRange(15, 6))] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
        YinsiFuwuViewController * pvc = [[YinsiFuwuViewController alloc] init];
        pvc.agreeType = index == 0 ? PrivacyAgreementTypeUser : PrivacyAgreementTypePrivacyAgreement;
        pvc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:pvc animated:YES completion:nil];
    }];
    [self.agreeBtn setImage:IMAGE_NAMED(@"choose") forState:UIControlStateNormal];
    [self.agreeBtn setImage:IMAGE_NAMED(@"choosed") forState:UIControlStateSelected];
    [self.sureBtn setBackgroundColor:[UIColor colorWithHexString:@"FA776D" alpha:1.0]];
    self.sureBtn.enabled = YES;
    if (self.phoneStr.length) {
        self.phoneTF.text = self.phoneStr;
        [self.smsBtn setBackgroundColor:[UIColor colorWithHexString:@"FA776D" alpha:1.0]];
        self.smsBtn.enabled = YES;
    }
}
- (void)textFieldDidEditing:(UITextField *)textField{
    
    if (textField == self.phoneTF) {
        if (textField.text.length > i) {
            if (textField.text.length == 4 || textField.text.length == 9 ) {
                //输入
                NSMutableString * str = [[NSMutableString alloc] initWithString:textField.text];
                [str insertString:@" " atIndex:(textField.text.length-1)];
                textField.text = str;
            }if (textField.text.length >= 13 ) {
                //输入完成
                textField.text = [textField.text substringToIndex:13];
                [textField resignFirstResponder];
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
    if (textField == self.smsTF){
        
        if (textField.text.length >= 4){
            textField.text = [textField.text substringToIndex:4];
        }
    }
}
- (void)textFieldChange:(NSNotification *)not{
    
    UITextField *tf = not.object;
    if (self.phoneTF == tf) {
        
        if (tf.text.length >= 13){
            
            tf.text = [tf.text substringToIndex:13];
            [self.smsBtn setBackgroundColor:[UIColor colorWithHexString:@"FA776D" alpha:1.0]];
            self.smsBtn.enabled = YES;
        }else{
            
            [self.smsBtn setBackgroundColor:[UIColor colorWithHexString:@"FA776D" alpha:0.45]];
            self.smsBtn.enabled = NO;
        }
    }else if (self.smsTF == tf){
        
        if (tf.text.length >= 4){
            tf.text = [tf.text substringToIndex:4];
        }
    }else if (self.invitationTF == tf){
        
    }
}
- (IBAction)getSmsCode:(LCountdownButton *)sender {
    
    NSString *phone = [self.phoneTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self startLoadingHUD];
    [THHttpManager GET:[NSString stringWithFormat:@"%@",@"system/login/sendPhoneCode"] parameters:@{@"phoneNumber":phone,@"type":@"1"} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200) {
            __block int timeout=120;
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
- (IBAction)chooseLocationClick:(id)sender {
    [self choose];
}

- (IBAction)chooseLocation:(id)sender {
    [self choose];
}

- (void)choose{
    [self.view endEditing:YES];
    CJWeakSelf()
    BRAddressPickerView *pickView = [[BRAddressPickerView alloc] initWithPickerMode:BRAddressPickerModeArea];
    pickView.resultBlock = ^(BRProvinceModel * _Nullable province, BRCityModel * _Nullable city, BRAreaModel * _Nullable area) {
        CJStrongSelf()
        self.provinceModel = province;
        self.cityModel = city;
        self.areaModel = area;
        
        [self.locationBtn setTitle:NSStringFormat(@"%@-%@-%@",province.name,city.name,area.name) forState:UIControlStateNormal];
        self.locationBtn.titleLabel.font = DIN_Medium_FONT_R(18);
        [self.locationBtn setTitleColor:KBlack333TextColor forState:UIControlStateNormal];
        self->_location = self.locationBtn.titleLabel.text;
    };
    [pickView show];
}

- (IBAction)registOrChangePassword:(id)sender {

    //注册
    if (self.phoneTF.text.length != 13) {
        [self showMessageWithString:@"请输入手机号"];
        return;
    }
    if (self.smsTF.text.length != 4) {
        [self showMessageWithString:@"请输入验证码"];
        return;
    }

    if (!self.agreeBtn.selected) {
        shakeView(self.agreeBtn.layer);
        [self showMessageWithString:@"请阅读并同意隐私政策"];
        return;
    }
    
    [self startLoadingHUD];
    NSString *phone = [self.phoneTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSDictionary *dica = @{
                           @"areaName": self.areaModel.name ?  self.areaModel.name : @"",
                           @"cityId": self.cityModel.code ?  self.cityModel.code : @"",
                           @"cityName": self.cityModel.name ?  self.cityModel.name : @"",
                           @"phoneNum": phone,
                           @"provinceId": self.provinceModel.code ?  self.provinceModel.code : @"",
                           @"provinceName": self.provinceModel.name ?  self.provinceModel.name : @"",
                           @"verificationCode": self.smsTF.text,@"inviteCode":self.invitationTF.text,
                           @"areaId": [NSString stringWithFormat:@"%@",self.areaModel.code] ,
    };
    CJWeakSelf()
    [THHttpManager POST:[NSString stringWithFormat:@"%@",@"system/login/register"] parameters:dica dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        CJStrongSelf()
        [self stopLoadingHUD];
        if (returnCode == 200) {
            if (self.currentVCBlock) {
                self.currentVCBlock(self.phoneTF.text);
            }
            [self dismissViewControllerAnimated:NO  completion:nil];
        }
    }];
}
- (IBAction)agreeProtocol:(id)sender {
    self.agreeBtn.selected = !self.agreeBtn.selected;
}

@end

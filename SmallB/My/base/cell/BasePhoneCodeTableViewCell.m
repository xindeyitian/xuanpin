//
//  BasePhoneCodeTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/15.
//

#import "BasePhoneCodeTableViewCell.h"

@implementation BasePhoneCodeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatBaseSubViews];
    }
    return self;
}

- (void)creatBaseSubViews{
    
    self.contentView.backgroundColor = KWhiteBGColor;
    self.separatorLineView.hidden = YES;

    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = KBGLightColor;
    bgView.clipsToBounds = YES;
    bgView.layer.cornerRadius = 12;
    [self.contentView addSubview:bgView];
    [bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 12, 0, 137));
    }];
    self.BGView = bgView;
    
    UILabel *lable = [UILabel creatLabelWithTitle:@"验证码" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    [bgView addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView).offset(15);
        make.top.bottom.mas_equalTo(bgView);
        make.width.mas_equalTo(50*KScreenW_Ratio);
    }];
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"获取验证码" Target:self Action:@selector(codeClick:)  Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    btn.layer.cornerRadius = 12;
    btn.clipsToBounds = YES;
    //btn.alpha = 0.5;
    [self.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.width.mas_equalTo(117);
        make.height.mas_equalTo(52);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    self.fieldT = [[UITextField alloc]init];
    self.fieldT.font = DEFAULT_FONT_R(15);
    self.fieldT.placeholder = @"请输入验证码";
    self.fieldT.backgroundColor = UIColor.clearColor;
    self.fieldT.delegate = self;
    self.fieldT.keyboardType = UIKeyboardTypeNumberPad;
    [self.fieldT addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:self.fieldT];
    [self.fieldT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lable.mas_right).offset(10);
        make.top.mas_equalTo(bgView).offset(5);
        make.bottom.mas_equalTo(bgView).offset(-5);
        make.right.mas_equalTo(btn.mas_left).offset(-6);
    }];
}

- (void)textFieldDidEditing:(UITextField *)field{
   
    if (_viewBlock) {
        _viewBlock(field.text);
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
//    if (_viewBlock) {
//        _viewBlock(textField.text);
//    }
}

- (void)codeClick:(BaseButton *)sender{
    THBaseViewController *vc = (THBaseViewController *)AppTool.currentVC;
    NSString *userPhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"];
    
    if (userPhone.length == 0) {
        [vc showMessageWithString:@"请输入手机号"];
        return;
    }
    if (userPhone.length != 11) {
        [vc showMessageWithString:@"请输入正确的手机号"];
        return;
    }
    [vc startLoadingHUD];
    NSString *phone = [self.phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    [THHttpManager GET:[NSString stringWithFormat:@"%@",@"system/login/sendPhoneCode"] parameters:@{@"phoneNumber":phone,@"type":self.phoneType} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [vc stopLoadingHUD];
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

@end



//
//  PhoneHadLogoutAlertViewController.m
//  SmallB
//
//  Created by zhang on 2022/6/30.
//

#import "PhoneHadLogoutAlertViewController.h"

@interface PhoneHadLogoutAlertViewController ()

@end

@implementation PhoneHadLogoutAlertViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(187*KScreenW_Ratio);
    }];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"小莲温馨提示" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:BOLD_FONT_R(18)];
    [self.bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(24*KScreenW_Ratio);
        make.height.mas_equalTo(26*KScreenW_Ratio);
        make.left.right.mas_equalTo(self.bgView);
    }];
    
    UILabel *content = [UILabel creatLabelWithTitle:@"当前手机号已注销，无法注册登录！" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(15)];
    [self.bgView addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(16*KScreenW_Ratio);
        make.height.mas_equalTo(28*KScreenW_Ratio);
        make.left.right.mas_equalTo(self.bgView);
    }];
    
    BaseButton *cancel = [BaseButton CreateBaseButtonTitle:@"我知道了" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_M(15) BackgroundColor:UIColor.whiteColor Color:KMaintextColor Frame:CGRectMake(0, 0, 0, 0) Alignment:NSTextAlignmentCenter Tag:22];
    [self.bgView addSubview:cancel];
    cancel.clipsToBounds = YES;
    cancel.layer.cornerRadius = 22*KScreenW_Ratio;
    cancel.layer.borderColor = KMainBGColor.CGColor;
    cancel.layer.borderWidth = 1;
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-26*KScreenW_Ratio);
        make.height.mas_equalTo(44*KScreenW_Ratio);
        make.width.mas_equalTo(181*KScreenW_Ratio);
        make.left.mas_equalTo(self.bgView).offset(73*KScreenW_Ratio);
    }];
}

- (void)btnClick{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end

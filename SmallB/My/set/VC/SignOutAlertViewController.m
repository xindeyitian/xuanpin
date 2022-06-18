//
//  SignOutAlertViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/26.
//

#import "SignOutAlertViewController.h"

@interface SignOutAlertViewController ()

@end

@implementation SignOutAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(170));
    }];

    UILabel *warning = [UILabel creatLabelWithTitle:@"确定退出登录？" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(15)];
    warning.numberOfLines = 0;
    [self.bgView addSubview:warning];
    [warning mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(30);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(self.bgView).offset(14);
        make.right.mas_equalTo(self.bgView).offset(-14);
    }];

    BaseButton *cancelBtn = [BaseButton CreateBaseButtonTitle:@"取消" Target:self Action:@selector(confirmClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:UIColor.clearColor Color:KMaintextColor Frame:CGRectMake(0, 0, 0, 0) Alignment:NSTextAlignmentCenter Tag:22];
    [self.bgView addSubview:cancelBtn];
    cancelBtn.clipsToBounds = YES;
    cancelBtn.layer.cornerRadius = 22;
    cancelBtn.layer.borderColor = KMainBGColor.CGColor;
    cancelBtn.layer.borderWidth = 1;
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-26);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(143*KScreenW_Ratio);
        make.left.mas_equalTo(self.bgView).offset(12);
    }];
    
    BaseButton *confirmBtn = [BaseButton CreateBaseButtonTitle:@"确认" Target:self Action:@selector(confirmClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:KBGColor Color:KBlack333TextColor Frame:CGRectMake(0, 0, 0, 0) Alignment:NSTextAlignmentCenter Tag:23];
    [self.bgView addSubview:confirmBtn];
    confirmBtn.clipsToBounds = YES;
    confirmBtn.layer.cornerRadius = 22;
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-26);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(143*KScreenW_Ratio);
        make.right.mas_equalTo(self.bgView).offset(-12);
    }];
}

- (void)confirmClick:(BaseButton *)btn{
    if (btn.tag == 22) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    if (btn.tag == 23) {
        LoginViewController * tab = [[LoginViewController alloc]init];
        [UIApplication sharedApplication].delegate.window.rootViewController = tab;
    }
}

@end


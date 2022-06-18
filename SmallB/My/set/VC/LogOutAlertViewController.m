//
//  LogOutAlertViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import "LogOutAlertViewController.h"
#import "LoginViewController.h"

@interface LogOutAlertViewController ()

@end

@implementation LogOutAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIView *iconView = [[UIView alloc]init];
    iconView.backgroundColor = UIColor.clearColor;
    [self.bgView addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(28);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.height.mas_equalTo(26);
    }];
    
    UIImageView *imgV = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"logout_warning")];
    [iconView addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.left.mas_equalTo(iconView);
        make.top.mas_equalTo(iconView).offset(1);
    }];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"用户注销" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(18)];
    [iconView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconView);
        make.height.mas_equalTo(26);
        make.left.mas_equalTo(imgV.mas_right).offset(5);
        make.right.mas_equalTo(iconView.mas_right);
    }];
    
    UILabel *warning = [UILabel creatLabelWithTitle:@"账户注销后，您的平台个人数据将全部清空，且当前手机号无法再次注册，是否确认注销？" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    warning.numberOfLines = 0;
    [self.bgView addSubview:warning];
    [warning mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconView).offset(30);
        make.height.mas_equalTo(80);
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
        [self logout];
    }
}

- (void)logout{
    
    [self startLoadingHUD];
 
    [THHttpManager POST:@"shop/shopUser/logout" parameters:@{} dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200) {
            [self showSuccessMessageWithString:@"注销成功"];
            [AppTool cleanLocalToken];
            [AppTool cleanLocalDataInfo];
            LoginViewController * tab = [[LoginViewController alloc]init];
            [UIApplication sharedApplication].delegate.window.rootViewController = tab;
        }
    }];
}

@end

//
//  withdrawFailAlertViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/13.
//

#import "withdrawFailAlertViewController.h"

@interface withdrawFailAlertViewController ()

@end

@implementation withdrawFailAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.left.mas_equalTo(self.view).offset(24);
        make.right.mas_equalTo(self.view).offset(-24);
    }];
    
    UIView *iconView = [[UIView alloc]init];
    iconView.backgroundColor = UIColor.clearColor;
    [self.bgView addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(28);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.height.mas_equalTo(26);
    }];
    
    UIImageView *imgV = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"withdraw_fail_alert")];
    [iconView addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.left.mas_equalTo(iconView);
        make.top.mas_equalTo(iconView).offset(1);
    }];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"提现失败" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(18)];
    [iconView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconView);
        make.height.mas_equalTo(26);
        make.left.mas_equalTo(imgV.mas_right).offset(5);
        make.right.mas_equalTo(iconView.mas_right);
    }];
    
    BaseButton *confirmBtn = [BaseButton CreateBaseButtonTitle:@"确认" Target:self Action:@selector(confirmClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectMake(0, 0, 0, 0) Alignment:NSTextAlignmentCenter Tag:20];
    [self.bgView addSubview:confirmBtn];
    confirmBtn.clipsToBounds = YES;
    confirmBtn.layer.cornerRadius = 22;
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-26);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(174);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
    }];
    
    UILabel *warning = [UILabel creatLabelWithTitle:self.content textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    warning.numberOfLines = 0;
    [self.bgView addSubview:warning];
    [warning mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconView.mas_bottom).offset(34);
        make.bottom.mas_equalTo(confirmBtn.mas_top).offset(-50);
        make.left.mas_equalTo(self.bgView).offset(14);
        make.right.mas_equalTo(self.bgView).offset(-14);
    }];
}

- (void)confirmClick:(BaseButton *)btn{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end

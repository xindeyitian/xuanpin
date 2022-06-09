//
//  CleanAlertViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/25.
//

#import "CleanAlertViewController.h"

@interface CleanAlertViewController ()

@end

@implementation CleanAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(187));
    }];
    
    UIView *iconView = [[UIView alloc]init];
    iconView.backgroundColor = UIColor.clearColor;
    [self.bgView addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(24);
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
    
    UILabel *title = [UILabel creatLabelWithTitle:@"提示" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(18)];
    [iconView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconView);
        make.height.mas_equalTo(26);
        make.left.mas_equalTo(imgV.mas_right).offset(5);
        make.right.mas_equalTo(iconView.mas_right);
    }];
    
    UILabel *warning = [UILabel creatLabelWithTitle:@"确定清除缓存吗？" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(15)];
    warning.numberOfLines = 0;
    [self.bgView addSubview:warning];
    [warning mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconView.mas_bottom).offset(15);
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
        make.width.mas_equalTo(143);
        make.left.mas_equalTo(self.bgView).offset(12);
    }];
    
    BaseButton *confirmBtn = [BaseButton CreateBaseButtonTitle:@"立即清除" Target:self Action:@selector(confirmClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:KBGColor Color:KBlack333TextColor Frame:CGRectMake(0, 0, 0, 0) Alignment:NSTextAlignmentCenter Tag:23];
    [self.bgView addSubview:confirmBtn];
    confirmBtn.clipsToBounds = YES;
    confirmBtn.layer.cornerRadius = 22;
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-26);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(143);
        make.right.mas_equalTo(self.bgView).offset(-12);
    }];
}

- (void)confirmClick:(BaseButton *)btn{
    if (btn.tag == 22) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    if (btn.tag == 23) {
        if (_viewBlock) {
            _viewBlock();
        }
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

@end

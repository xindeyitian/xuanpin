//
//  PhoneAlertViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/26.
//

#import "PhoneAlertViewController.h"

@interface PhoneAlertViewController ()

@end

@implementation PhoneAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UILabel *title = [UILabel creatLabelWithTitle:@"顾客联系电话" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(18)];
    [self.bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(28);
        make.height.mas_equalTo(26);
        make.left.right.mas_equalTo(self.bgView);
    }];
    
    UILabel *phone = [UILabel creatLabelWithTitle:self.phone textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(25)];
    [self.bgView addSubview:phone];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(33);
        make.height.mas_equalTo(30);
        make.left.right.mas_equalTo(self.bgView);
    }];
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"拨打电话" Target:self Action:@selector(btnClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectMake(0, 0, 0, 0) Alignment:NSTextAlignmentCenter Tag:22];
    [self.bgView addSubview:btn];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 22;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-26);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(143);
        make.right.mas_equalTo(self.bgView).offset(-12);
    }];
    
    BaseButton *cancel = [BaseButton CreateBaseButtonTitle:@"取消" Target:self Action:@selector(btnClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:KBGColor Color:KBlack666TextColor Frame:CGRectMake(0, 0, 0, 0) Alignment:NSTextAlignmentCenter Tag:23];
    [self.bgView addSubview:cancel];
    cancel.clipsToBounds = YES;
    cancel.layer.cornerRadius = 22;
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-26);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(143);
        make.left.mas_equalTo(self.bgView).offset(12);
    }];
}

- (void)btnClick:(UIButton *)btn{
    if (btn.tag == 22) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    if (btn.tag == 23) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

@end

//
//  BingdingAlertViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/26.
//

#import "BingdingAlertViewController.h"

@interface BingdingAlertViewController ()

@end

@implementation BingdingAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(202);
    }];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"未认证" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(18)];
    [self.bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(28);
        make.height.mas_equalTo(26);
        make.left.right.mas_equalTo(self.bgView);
    }];
    
    UILabel *phone = [UILabel creatLabelWithTitle:@"请先实名认证后再进行操作！" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(15)];
    [self.bgView addSubview:phone];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(18);
        make.height.mas_equalTo(26);
        make.left.right.mas_equalTo(self.bgView);
    }];
    
    BaseButton *cancel = [BaseButton CreateBaseButtonTitle:@"取消" Target:self Action:@selector(btnClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:KBGColor Color:KBlack333TextColor Frame:CGRectMake(0, 0, 0, 0) Alignment:NSTextAlignmentCenter Tag:22];
    [self.bgView addSubview:cancel];
    cancel.clipsToBounds = YES;
    cancel.layer.cornerRadius = 22;
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-26);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(143);
        make.left.mas_equalTo(self.bgView).offset(12);
    }];
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"去认证" Target:self Action:@selector(btnClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectMake(0, 0, 0, 0) Alignment:NSTextAlignmentCenter Tag:23];
    [self.bgView addSubview:btn];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 22;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-26);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(143);
        make.right.mas_equalTo(self.bgView).offset(-12);
    }];
}

- (void)btnClick:(BaseButton *)btn{
    [self dismissViewControllerAnimated:NO completion:nil];
    if (_btnClickBlock && btn.tag == 23) {
        _btnClickBlock(1);
    }
}

@end

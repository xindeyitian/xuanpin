//
//  ShopWindowDeleteAlertVC.m
//  SmallB
//
//  Created by zhang on 2022/7/8.
//

#import "ShopWindowDeleteAlertVC.h"

@interface ShopWindowDeleteAlertVC ()

@end

@implementation ShopWindowDeleteAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(138);
    }];
    UILabel *title = [UILabel creatLabelWithTitle:@"是否确认删除商品？" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(17)];
    [self.bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(24);
        make.height.mas_equalTo(30);
        make.left.right.mas_equalTo(self.bgView);
    }];
    
    BaseButton *cancelBtn = [BaseButton CreateBaseButtonTitle:@"取消" Target:self Action:@selector(confirmClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:KBGColor Color:KBlack333TextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:22];
    [self.bgView addSubview:cancelBtn];
    cancelBtn.clipsToBounds = YES;
    cancelBtn.layer.cornerRadius = 22;
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-20);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(143);
        make.left.mas_equalTo(self.bgView).offset(12);
    }];
    
    BaseButton *confirmBtn = [BaseButton CreateBaseButtonTitle:@"确认" Target:self Action:@selector(confirmClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:23];
    [self.bgView addSubview:confirmBtn];
    confirmBtn.clipsToBounds = YES;
    confirmBtn.layer.cornerRadius = 22;
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-20);
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
        if (_confirmBtnClickBlock) {
            _confirmBtnClickBlock();
        }
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

@end

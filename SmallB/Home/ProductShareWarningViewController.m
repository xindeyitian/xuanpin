//
//  PproductShareWarningViewController.m
//  SmallB
//
//  Created by zhang on 2022/7/19.
//

#import "ProductShareWarningViewController.h"

@interface ProductShareWarningViewController ()

@end

@implementation ProductShareWarningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(202);
    }];
    UILabel *title = [UILabel creatLabelWithTitle:@"分享商品" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(18)];
    [self.bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(24);
        make.height.mas_equalTo(28);
        make.left.right.mas_equalTo(self.bgView);
    }];
    
    UILabel *content = [UILabel creatLabelWithTitle:@"分享商品需先加入您的店铺橱窗中上架销售，是否确认加入橱窗？" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(15)];
    content.numberOfLines = 0;
    [self.bgView addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(68);
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(self.bgView).offset(12);
        make.right.mas_equalTo(self.bgView).offset(-12);
    }];
    
    BaseButton *cancelBtn = [BaseButton CreateBaseButtonTitle:@"取消" Target:self Action:@selector(confirmClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:KBGColor Color:KBlack333TextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:22];
    [self.bgView addSubview:cancelBtn];
    cancelBtn.clipsToBounds = YES;
    cancelBtn.layer.cornerRadius = 22;
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-20);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(143*KScreenW_Ratio);
        make.left.mas_equalTo(self.bgView).offset(12);
    }];
    
    BaseButton *confirmBtn = [BaseButton CreateBaseButtonTitle:@"确认加入橱窗" Target:self Action:@selector(confirmClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:23];
    [self.bgView addSubview:confirmBtn];
    confirmBtn.clipsToBounds = YES;
    confirmBtn.layer.cornerRadius = 22;
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-20);
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
        if (_confirmBlock) {
            _confirmBlock();
        }
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
@end

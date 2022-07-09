//
//  ApplySupplierSuccessAlertViewController.m
//  SmallB
//
//  Created by zhang on 2022/7/5.
//

#import "ApplySupplierSuccessAlertViewController.h"

@interface ApplySupplierSuccessAlertViewController ()

@end

@implementation ApplySupplierSuccessAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(267*KScreenW_Ratio);
        make.left.mas_equalTo(self.view).offset(24*KScreenW_Ratio);
        make.right.mas_equalTo(self.view).offset(-24*KScreenW_Ratio);
    }];
    
    UIImageView *topImage = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"apply_success")];
    [self.bgView addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView.mas_centerX);
        make.height.width.mas_equalTo(84*KScreenW_Ratio);
        make.top.equalTo(self.bgView).offset(12*KScreenW_Ratio);
    }];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"审核通过!" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(17)];
    [self.bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topImage.mas_bottom).offset(5*KScreenW_Ratio);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.left.mas_equalTo(self.bgView).offset(12);
        make.height.mas_equalTo(25*KScreenW_Ratio);
    }];
    
    UILabel *subTitle = [UILabel creatLabelWithTitle:@"请用电脑登录供货商后台管理\n-" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(15)];
    subTitle.numberOfLines = 2;
    [self.bgView addSubview:subTitle];
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(12*KScreenW_Ratio);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.left.mas_equalTo(self.bgView).offset(12);
        make.height.mas_equalTo(54*KScreenW_Ratio);
    }];
    if (self.contentS.length) {
        subTitle.text = [NSString stringWithFormat:@"请用电脑登录供货商后台管理\n%@",self.contentS];
    }
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"我知道了" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 22*KScreenW_Ratio;
    [self.bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-26);
        make.right.mas_equalTo(self.bgView).offset(-30);
        make.left.mas_equalTo(self.bgView).offset(30);
        make.height.mas_equalTo(44*KScreenW_Ratio);
    }];
}

- (void)btnClick{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end


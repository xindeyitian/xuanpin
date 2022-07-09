//
//  ApplySupplierFailAlertViewController.m
//  SmallB
//
//  Created by zhang on 2022/7/5.
//

#import "ApplySupplierFailAlertViewController.h"
#import "myToBeSupplierViewController.h"

@interface ApplySupplierFailAlertViewController ()

@end

@implementation ApplySupplierFailAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(249*KScreenW_Ratio);
        make.left.mas_equalTo(self.view).offset(24*KScreenW_Ratio);
        make.right.mas_equalTo(self.view).offset(-24*KScreenW_Ratio);
    }];
    
    UIImageView *topImage = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"my_store_fail_alert")];
    [self.bgView addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView.mas_centerX);
        make.height.width.mas_equalTo(84*KScreenW_Ratio);
        make.top.equalTo(self.bgView).offset(12*KScreenW_Ratio);
    }];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"供货商审核信息失败！" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(17)];
    [self.bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topImage.mas_bottom).offset(5*KScreenW_Ratio);
        make.right.mas_equalTo(self.bgView).offset(-12*KScreenW_Ratio);
        make.left.mas_equalTo(self.bgView).offset(12*KScreenW_Ratio);
        make.height.mas_equalTo(25*KScreenW_Ratio);
    }];
    
    UILabel *subTitle = [UILabel creatLabelWithTitle:@"您可以补全供货商资料，重新提交！" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(15)];
    [self.bgView addSubview:subTitle];
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(12*KScreenW_Ratio);
        make.right.mas_equalTo(self.bgView).offset(-12*KScreenW_Ratio);
        make.left.mas_equalTo(self.bgView).offset(12*KScreenW_Ratio);
        make.height.mas_equalTo(28*KScreenW_Ratio);
    }];

    BaseButton *applyBtn = [BaseButton CreateBaseButtonTitle:@"补全资料" Target:self Action:@selector(btnClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:4];
    applyBtn.clipsToBounds = YES;
    applyBtn.layer.cornerRadius = 22*KScreenW_Ratio;
    [self.bgView addSubview:applyBtn];
    [applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-26*KScreenW_Ratio);
        make.right.mas_equalTo(self.bgView).offset(-12*KScreenW_Ratio);
        make.height.mas_equalTo(44*KScreenW_Ratio);
        make.width.mas_equalTo(143*KScreenW_Ratio);
    }];
    
    BaseButton *cancelBtn = [BaseButton CreateBaseButtonTitle:@"取消" Target:self Action:@selector(btnClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:kRGB(238, 238, 238) Color:KBlack666TextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
    cancelBtn.clipsToBounds = YES;
    cancelBtn.layer.cornerRadius = 22*KScreenW_Ratio;
    [self.bgView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-26*KScreenW_Ratio);
        make.left.mas_equalTo(self.bgView).offset(12*KScreenW_Ratio);
        make.height.mas_equalTo(44*KScreenW_Ratio);
        make.width.mas_equalTo(143*KScreenW_Ratio);
    }];
}

- (void)btnClick:(BaseButton *)btn{
    if (btn.tag == 4) {
        [self dismissViewControllerAnimated:NO completion:^{
            myToBeSupplierViewController *vc = [[myToBeSupplierViewController alloc]init];
            [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
        }];
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

@end

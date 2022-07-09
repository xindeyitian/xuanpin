//
//  OpenStoreAlertViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/16.
//

#import "OpenStoreAlertViewController.h"
#import "MainTabarViewController.h"

@interface OpenStoreAlertViewController ()

@end

@implementation OpenStoreAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(274);
    }];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"withdraw_result_success")];
    [self.bgView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(20);
        make.width.height.mas_equalTo(50);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
    }];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"申请已提交，请等待审核！" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(17)];
    [self.bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(78);
        make.height.mas_equalTo(30);
        make.left.right.mas_equalTo(self.bgView);
    }];
    
    UILabel *subTitle = [UILabel creatLabelWithTitle:@"客服会与您核实开店信息，\n请注意接听电话！" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(13)];
    subTitle.numberOfLines = 0;
    [self.bgView addSubview:subTitle];
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(18);
        make.left.mas_equalTo(self.bgView).offset(12);
        make.right.mas_equalTo(self.bgView).offset(-12);
    }];
    
    BaseButton *confirmBtn = [BaseButton CreateBaseButtonTitle:@"我已知晓" Target:self Action:@selector(confirmClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:23];
    [self.bgView addSubview:confirmBtn];
    confirmBtn.clipsToBounds = YES;
    confirmBtn.layer.cornerRadius = 22;
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-26);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(174);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
    }];
}

- (void)confirmClick:(BaseButton *)btn{
    [[NSUserDefaults standardUserDefaults]  setValue:@"1" forKey:@"login"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [AppTool cleanLocalToken];
    
    LoginViewController *tabBarVC = [LoginViewController new];
    [UIApplication sharedApplication].delegate.window.rootViewController = tabBarVC;
}

@end

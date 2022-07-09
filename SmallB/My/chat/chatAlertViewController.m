//
//  chatAlertViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import "chatAlertViewController.h"

@interface chatAlertViewController ()

@end

@implementation chatAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UILabel *title = [UILabel creatLabelWithTitle:@"客服联系电话" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(18)];
    [self.bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(28);
        make.height.mas_equalTo(26);
        make.left.right.mas_equalTo(self.bgView);
    }];
    
    UILabel *phone = [UILabel creatLabelWithTitle:self.phoneStr textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(25)];
    [self.bgView addSubview:phone];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(33);
        make.height.mas_equalTo(30);
        make.left.right.mas_equalTo(self.bgView);
    }];
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"拨打电话" Target:self Action:@selector(phoneClick) Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectMake(0, 0, 0, 0) Alignment:NSTextAlignmentCenter Tag:22];
    [self.bgView addSubview:btn];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 22;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-26);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(174);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
    }];
}

- (void)phoneClick{
    
    [self dismissViewControllerAnimated:NO completion:^{
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.phoneStr];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }];
}

@end

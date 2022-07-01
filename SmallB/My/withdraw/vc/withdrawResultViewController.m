//
//  withdrawResultViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/13.
//

#import "withdrawResultViewController.h"

@interface withdrawResultViewController ()<UINavigationControllerDelegate>

@end

@implementation withdrawResultViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_viewBlock) {
        _viewBlock();
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.delegate = self;
    self.navigationItem.title = @"结果详情";
    self.view.backgroundColor = KBGColor;
    
    UIView *whiteV = [[UIView alloc]init];
    whiteV.backgroundColor = KWhiteBGColor;
    whiteV.clipsToBounds = YES;
    whiteV.layer.cornerRadius = 8;
    [self.view addSubview:whiteV];
    
    [whiteV mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(12);
        } else {
            make.top.mas_equalTo(self.view).offset(KNavBarHeight).offset(12);
        }
        make.left.equalTo(self.view).offset(12);
        make.right.equalTo(self.view).offset(-12);
        make.height.mas_equalTo(369);
    }];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"withdraw_result_success")];
    [whiteV addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(whiteV.mas_centerX);
        make.height.width.mas_equalTo(64);
        make.top.equalTo(whiteV).offset(44);
    }];
    
    UILabel *type = [UILabel creatLabelWithTitle:@"提现申请成功，等待处理" textColor:KBlack666TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(17)];
    [whiteV addSubview:type];
    [type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(image.mas_bottom).offset(24);
        make.right.mas_equalTo(whiteV).offset(-12);
        make.left.mas_equalTo(whiteV).offset(12);
        make.height.mas_equalTo(24);
    }];
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor = KBlackLineColor;
    [whiteV addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(type.mas_bottom).offset(35);
        make.right.mas_equalTo(whiteV).offset(-12);
        make.left.mas_equalTo(whiteV).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    float maxY = 217;
    for (int i = 0; i < 2; i ++ ) {
        UILabel *left = [UILabel creatLabelWithTitle:i == 0? @"提现积分":@"提现方式" textColor:KBlack666TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
        left.frame = CGRectMake(12, maxY + (23+12)*i, 70, 23);
        [whiteV addSubview:left];
        
        UILabel *right = [UILabel creatLabelWithTitle:i == 0? [NSString stringWithFormat:@"¥%@",self.money]:self.typeStr textColor:KBlack333TextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_R(17)];
        right.frame = CGRectMake(90, maxY + (23+12)*i, ScreenWidth - 36 - 90, 23);
        [whiteV addSubview:right];
    }
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"完成" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_M(17) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 25;
    [whiteV addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(whiteV.mas_bottom).offset(-20);
        make.right.mas_equalTo(whiteV).offset(-12);
        make.left.mas_equalTo(whiteV).offset(12);
        make.height.mas_equalTo(50);
    }];
}

- (void)btnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    SetIOS13;
    [navigationController setNavigationBarHidden:NO animated:YES];
}

@end

//
//  CategorySearchNavView.m
//  SmallB
//
//  Created by zhang on 2022/4/18.
//

#import "CategorySearchNavView.h"
#import "SearchListViewController.h"

@implementation CategorySearchNavView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    self.backgroundColor = KWhiteBGColor;
    
    BaseButton *backBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(back) Font:DEFAULT_FONT_R(10) Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1 BackgroundImage:@"back" HeightLightBackgroundImage:@"back"];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(44);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self).offset(KStatusBarHeight);
    }];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(44, KStatusBarHeight + 7, ScreenWidth - 44 - 52, 30)];
    view.backgroundColor = KWhiteBGColor;
    view.clipsToBounds = YES;
    view.layer.cornerRadius = 6;
    view.layer.borderColor = KMainBGColor.CGColor;
    view.layer.borderWidth = 1;
    [self addSubview:view];
    
    BaseButton *search = [BaseButton CreateBaseButtonTitle:@"搜索" Target:self Action:@selector(search) Font:DEFAULT_FONT_R(15) Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1 BackgroundImage:@"" HeightLightBackgroundImage:@""];
    [search setTitleColor:KMaintextColor forState:UIControlStateNormal];
    [self addSubview:search];
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(44);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(KStatusBarHeight);
    }];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"放大镜_black")];
    [view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.left.mas_equalTo(view).offset(12);
        make.top.mas_equalTo(view).offset(5);
    }];
    
    UILabel *searchL = [UILabel creatLabelWithTitle:@"手机" textColor:KBlack999TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
    [view addSubview:searchL];
    [searchL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).offset(3);
        make.left.mas_equalTo(image.mas_right).offset(10);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(100);
    }];
    
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)]];
}

-(void)tapClick{
    [[AppTool currentVC].navigationController pushViewController:[[SearchListViewController alloc] init] animated:YES];
}

- (void)search{
    [[AppTool currentVC].navigationController pushViewController:[[SearchListViewController alloc] init] animated:YES];
}

- (void)back{
    [[AppTool currentVC].navigationController popViewControllerAnimated:YES];
}

@end

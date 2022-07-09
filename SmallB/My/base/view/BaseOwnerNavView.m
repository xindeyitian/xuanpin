//
//  BaseOwnerNavView.m
//  SmallB
//
//  Created by zhang on 2022/4/14.
//

#import "BaseOwnerNavView.h"

@implementation BaseOwnerNavView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSub];
    }
    return  self;
}

- (void)creatSub{
    self.userInteractionEnabled = YES;
    self.backBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_R(15) BackgroundColor:UIColor.clearColor Color:KBlack333TextColor Frame:CGRectMake(0, KStatusBarHeight + 2, 40, 40) Alignment:NSTextAlignmentCenter Tag:1];
    [self.backBtn setImage:IMAGE_NAMED(@"bar_back") forState:UIControlStateNormal];
    [self addSubview:self.backBtn];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(18)];
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backBtn.mas_centerY);
        make.right.mas_equalTo(self).offset(-50);
        make.left.mas_equalTo(self).offset(50);
        make.height.mas_equalTo(30);
    }];
    self.titleL = title;
}

-(void)btnClick{
    if (_backOperation) {
        _backOperation();
    }
    [[AppTool currentVC].navigationController popViewControllerAnimated:YES];
}

@end

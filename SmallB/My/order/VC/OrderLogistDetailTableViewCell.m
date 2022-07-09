//
//  OrderLogistDetailTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/7/7.
//

#import "OrderLogistDetailTableViewCell.h"

@implementation OrderLogistDetailTableViewCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    
    self.contentView.backgroundColor = KWhiteBGColor;
    
    UILabel *title = [UILabel creatLabelWithTitle:@"标题" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(17)];
    [self.contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(14);
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.left.mas_equalTo(self.contentView).offset(105);
        make.height.mas_equalTo(24);
    }];
    
    UILabel *subTitle = [UILabel creatLabelWithTitle:@"全球未来机场计划是指未来游客在海外机场全球未来机场计划是指未来游客在海外机场全球未来机场计划是指未来游客在海外机场" textColor:KBlack999TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    subTitle.numberOfLines = 0;
    [self.contentView addSubview:subTitle];
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom);
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.left.mas_equalTo(self.contentView).offset(105);
        make.bottom.mas_equalTo(self.contentView).offset(-12);
    }];
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor = KBGLightColor;
    [self.contentView addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.left.mas_equalTo(self.contentView).offset(105);
        make.bottom.mas_equalTo(self.contentView).offset(-1);
    }];
    
    UIView *cycle = [[UIView alloc]init];
    cycle.backgroundColor = KWhiteBGColor;
    cycle.clipsToBounds = YES;
    cycle.layer.cornerRadius = 5;
    cycle.layer.borderColor = kRGB(229,229,229).CGColor;
    cycle.layer.borderWidth = 1;
    [self.contentView addSubview:cycle];
    [cycle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(10);
        make.centerY.mas_equalTo(title.mas_centerY);
        make.left.mas_equalTo(self.contentView).offset(83);
    }];
    
    UIView *topLine = [[UIView alloc]init];
    topLine.backgroundColor = kRGB(229,229,229);
    [self.contentView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.left.mas_equalTo(self.contentView).offset(88);
        make.top.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(cycle.mas_top).offset(-5);
    }];
    self.topLineView = topLine;
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = kRGB(229,229,229);
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.left.mas_equalTo(self.contentView).offset(88);
        make.bottom.mas_equalTo(self.contentView);
        make.top.mas_equalTo(cycle.mas_bottom).offset(5);
    }];
    self.bottomLineView = bottomLine;
    
    UILabel *day = [UILabel creatLabelWithTitle:@"29" textColor:KBlack333TextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_R(17)];
    [self.contentView addSubview:day];
    [day mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(12);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(65);
        make.centerY.mas_equalTo(title.mas_centerY);
    }];

    
    UILabel *time = [UILabel creatLabelWithTitle:@"2019-08" textColor:KBlack999TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    [self.contentView addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(12);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(65);
        make.top.mas_equalTo(day.mas_bottom);
    }];
}

@end

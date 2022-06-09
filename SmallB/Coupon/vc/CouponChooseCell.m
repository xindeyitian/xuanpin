//
//  CouponChooseCell.m
//  SmallB
//
//  Created by zhang on 2022/4/21.
//

#import "CouponChooseCell.h"

@implementation CouponChooseCell

-(void)k_creatSubViews{
    [super k_creatSubViews];
    
    self.bgView.layer.borderColor = KBGColor.CGColor;
    self.bgView.layer.borderWidth = 1;
    self.bgView.clipsToBounds = YES;
    self.bgView.layer.cornerRadius = 8;
    
    self.contentView.backgroundColor = KWhiteBGColor;
    self.separatorLineView.hidden = YES;
    
    UIImageView *image = [[UIImageView alloc]init];
    [self.bgView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(46);
        make.top.equalTo(self.bgView).offset(12);
        make.left.equalTo(self.bgView).offset(12);
    }];
    self.iconImgV = image;
    
    UIImageView *right = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"choose")];
    [self.bgView addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(20);
        make.top.equalTo(self.bgView).offset(12);
        make.right.equalTo(self.bgView).offset(-15);
    }];
    self.rightImgV = right;
    
    UILabel *type = [UILabel creatLabelWithTitle:@"0门槛创业开店者" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(15)];
    [self.bgView addSubview:type];
    [type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(image.mas_top);
        make.right.mas_equalTo(right.mas_left).offset(-12);
        make.left.mas_equalTo(image.mas_right).offset(12);
        make.height.mas_equalTo(24);
    }];
    self.titleL = type;
    
    UILabel *title = [UILabel creatLabelWithTitle:@"开店推广您的品牌产品" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
    [self.bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(type.mas_bottom).offset(4);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.left.mas_equalTo(image.mas_right).offset(12);
        make.height.mas_equalTo(20);
    }];
    self.subTitleL = title;
    
    UILabel *subTitle = [UILabel creatLabelWithTitle:@"共享平台流量、提供私域电商解决方案" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
    [self.bgView addSubview:subTitle];
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(4);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.left.mas_equalTo(image.mas_right).offset(12);
        make.height.mas_equalTo(20);
    }];
    self.contentTitleL = subTitle;
}

-(void)setIsSelect:(BOOL)isSelect{
    self.rightImgV.image = isSelect ? IMAGE_NAMED(@"choosed") : IMAGE_NAMED(@"choose");
}

@end

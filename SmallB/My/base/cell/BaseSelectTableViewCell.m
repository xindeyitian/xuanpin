//
//  BaseSelectTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/16.
//

#import "BaseSelectTableViewCell.h"

@implementation BaseSelectTableViewCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    
    UIImageView *image = [[UIImageView alloc]init];
    [self.bgView addSubview:image];
    self.leftImgV = image;
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(12);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.height.width.mas_equalTo(20);
    }];
    
    UIImageView *right = [[UIImageView alloc]init];
    [self.bgView addSubview:right];
    self.rightImgV = right;
    
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.height.width.mas_equalTo(20);
    }];
    
    UILabel *subTitle = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_R(15)];
    [self.bgView addSubview:subTitle];
    self.subTitleL = subTitle;
  
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(right.mas_left).offset(-10);
        make.height.mas_equalTo(25);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
    }];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"优惠券" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    [self.bgView addSubview:title];
    self.titleL = title;
  
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(image.mas_right).offset(12);
        make.right.mas_equalTo(subTitle.mas_left).offset(-10);
        make.height.mas_equalTo(25);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
    }];
}

- (void)setHiddenLeft:(BOOL)hiddenLeft{
    self.leftImgV.hidden = YES;
    [self.titleL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(12);
        make.right.mas_equalTo(self.subTitleL.mas_left).offset(-10);
        make.height.mas_equalTo(25);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
    }];
}

@end

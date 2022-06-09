//
//  ProductDetailGuiGeCell.m
//  SmallB
//
//  Created by zhang on 2022/4/25.
//

#import "ProductDetailGuiGeCell.h"

@implementation ProductDetailGuiGeCell

-(void)k_creatSubViews{
    [super k_creatSubViews];
    
    UILabel *left = [UILabel creatLabelWithTitle:@"品牌" textColor:KBlack666TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    [self.contentView addSubview:left];
    
    UILabel *right = [UILabel creatLabelWithTitle:@"品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌品牌" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    [self.contentView addSubview:right];
    right.numberOfLines = 0;
    
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(12);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(60);
        make.centerY.mas_equalTo(right.mas_centerY);
    }];
    
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(12);
        make.bottom.mas_equalTo(self.contentView).offset(-12);
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.left.mas_equalTo(left.mas_right).offset(12);
    }];

    UIView *linV = [[UIView alloc]init];
    linV.backgroundColor = KBGColor;
    [self.contentView addSubview:linV];
    [linV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView).offset(-1);
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.left.mas_equalTo(right.mas_left);
        make.height.mas_equalTo(1);
    }];
}

@end

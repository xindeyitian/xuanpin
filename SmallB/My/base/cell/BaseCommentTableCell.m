//
//  BaseCommentTableCell.m
//  SmallB
//
//  Created by zhang on 2022/4/12.
//

#import "BaseCommentTableCell.h"

@interface BaseCommentTableCell ()

@end

@implementation BaseCommentTableCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    self.leftL = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    [self.bgView addSubview:self.leftL];
    
    self.rightL = [UILabel creatLabelWithTitle:@"" textColor:KBlack666TextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_R(15)];
    [self.bgView addSubview:self.rightL];
    
    [self.leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.bgView);
        make.left.mas_equalTo(self.bgView).offset(12);
    }];
    
    [self.rightL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.bgView);
        make.right.mas_equalTo(self.bgView).offset(-12);
    }];
}

@end

@implementation BaseCommentRightTableCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    
    self.rightImgV = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"my_right_gray")];
    [self.contentView addSubview:self.rightImgV];
    
    [self.rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(18);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.bgView).offset(-12);
    }];
  
    [self.rightL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.bgView);
        make.right.mas_equalTo(self.rightImgV.mas_left).offset(-8);
    }];
}

@end

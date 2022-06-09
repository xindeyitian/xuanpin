//
//  CategoryLeftTableCell.m
//  SmallB
//
//  Created by zhang on 2022/4/18.
//

#import "CategoryLeftTableCell.h"

@implementation CategoryLeftTableCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
    [self.contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(24);
        make.left.mas_equalTo(self.contentView).offset(12);
    }];
    self.titleLabel = title;
}

@end

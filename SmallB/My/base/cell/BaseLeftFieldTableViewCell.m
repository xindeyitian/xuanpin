//
//  BaseLeftFieldTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/7/7.
//

#import "BaseLeftFieldTableViewCell.h"

@implementation BaseLeftFieldTableViewCell

-(void)k_creatSubViews{
    [super k_creatSubViews];
    
    self.bgView.layer.cornerRadius = 0;
    self.bgView.userInteractionEnabled = YES;
    
    UILabel *title = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    [self.bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.left.mas_equalTo(self.bgView).offset(12);
        make.height.mas_equalTo(24);
        make.width.mas_greaterThanOrEqualTo(20);
    }];
    self.leftL = title;
    
    [title setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.fieldT setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.fieldT mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(title.mas_right).offset(10);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.bottom.mas_equalTo(self.bgView).offset(-5);
        make.top.mas_equalTo(self.bgView).offset(5);
    }];
}

- (void)setHavRightImgV:(BOOL)havRightImgV{
    self.rightImgV.hidden = !havRightImgV;
    [self.fieldT mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).offset(havRightImgV ? -34 : -12);
    }];
    self.fieldT.userInteractionEnabled = !havRightImgV;
}

@end

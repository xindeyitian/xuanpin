//
//  OrderLogistedListTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/7/7.
//

#import "OrderLogistedListTableViewCell.h"

@interface OrderLogistedListTableViewCell ()

@property (nonatomic , strong)UIImageView *rightImgV;

@end

@implementation OrderLogistedListTableViewCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    
    self.contentView.backgroundColor = KBGLightColor;
    
    UIView *bgV = [[UIView alloc]init];
    bgV.backgroundColor = KWhiteBGColor;
    bgV.clipsToBounds = YES;
    bgV.layer.cornerRadius = 8;
    [self.contentView addSubview:bgV];
    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.self.contentView).offset(12);
        make.left.mas_equalTo(self.self.contentView).offset(12);
        make.right.mas_equalTo(self.self.contentView).offset(-12);
        make.bottom.mas_equalTo(self.self.contentView);
    }];
    
    self.rightImgV = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"my_right_gray")];
    [bgV addSubview:self.rightImgV];
    
    [self.rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.centerY.mas_equalTo(bgV.mas_centerY);
        make.right.mas_equalTo(bgV).offset(-12);
    }];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"中通快递" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(15)];
    [bgV addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgV).offset(12);
        make.right.mas_equalTo(self.rightImgV.mas_left).offset(-10);
        make.left.mas_equalTo(bgV).offset(12);
        make.height.mas_equalTo(24);
    }];
    
    UILabel *logistNo = [UILabel creatLabelWithTitle:@"物流单号：354678908765490765" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
    [bgV addSubview:logistNo];
    [logistNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(8);
        make.right.mas_equalTo(self.rightImgV.mas_left).offset(-10);
        make.left.mas_equalTo(bgV).offset(12);
        make.height.mas_equalTo(21);
    }];
    
    UILabel *time = [UILabel creatLabelWithTitle:@"2022-03-03 15:00" textColor:KBlack999TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    [bgV addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logistNo.mas_bottom).offset(2);
        make.right.mas_equalTo(self.rightImgV.mas_left).offset(-10);
        make.left.mas_equalTo(bgV).offset(12);
        make.height.mas_equalTo(20);
    }];
}

@end

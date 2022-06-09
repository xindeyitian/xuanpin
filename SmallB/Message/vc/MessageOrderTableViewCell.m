//
//  MessageOrderTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/24.
//

#import "MessageOrderTableViewCell.h"

@interface MessageOrderTableViewCell ()

@end

@implementation MessageOrderTableViewCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    
    UIImageView *image = [[UIImageView alloc]init];
    [self.bgView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(12);
        make.top.equalTo(self.bgView).offset(12);
        make.height.width.mas_equalTo(50);
    }];
    
    UILabel *time = [UILabel creatLabelWithTitle:@"2022.04.05" textColor:KBlack999TextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_R(12)];
    [self.bgView addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(image.mas_top);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.height.mas_equalTo(24);
    }];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"订单号374787573857订单号374787573857订单号374787573857" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(15)];
    [self.bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(image.mas_top);
        make.right.mas_equalTo(time.mas_left).offset(-5);
        make.left.mas_equalTo(image.mas_right).offset(12);
        make.height.mas_equalTo(24);
    }];
    
    UIView *red = [[UIView alloc]init];
    red.backgroundColor = UIColor.redColor;
    red.clipsToBounds = YES;
    red.layer.cornerRadius = 3.5;
    [self.bgView addSubview:red];
    [red mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(image.mas_bottom).offset(-7);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.height.width.mas_equalTo(7);
    }];
    
    UILabel *content = [UILabel creatLabelWithTitle:@"亲，您有一笔新的订单请查看！" textColor:KBlack666TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
    [self.bgView addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(image.mas_bottom);
        make.right.mas_equalTo(red.mas_left).offset(-5);
        make.left.mas_equalTo(title.mas_left);
        make.height.mas_equalTo(21);
    }];
}

@end

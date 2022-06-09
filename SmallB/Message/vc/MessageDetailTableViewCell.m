//
//  MessageDetailTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/24.
//

#import "MessageDetailTableViewCell.h"

@implementation MessageDetailTableViewCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    

    UILabel *title = [UILabel creatLabelWithTitle:@"系统消息标题标题标题" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(15)];
    title.numberOfLines = 0;
    [self.bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(20);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.left.mas_equalTo(self.bgView).offset(12);
    }];
    
    UILabel *time = [UILabel creatLabelWithTitle:@"2020.03.03 13:05" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(12)];
    [self.bgView addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(4);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.left.mas_equalTo(self.bgView).offset(12);
        make.height.mas_equalTo(20);
    }];

    UILabel *content = [UILabel creatLabelWithTitle:@"消息正文文，消息正文文，消息正文文消息正文文消息正文文消息正文文消息正文文消息正文文，消息正文文消息正文文消息正文文消息正文文消息正文文消息正文文，消息正文文，消息正文文消息正文文消息正文文消息正文文消息正文文消息正文文，消息正文文消息正文文消息正文文消息正文文消息正文文消息正文文，消息正文文，消息正文文消息正文文消息正文文消息正文文消息正文文消息正文文，消息正文文消息正文文消息正文文消息正文文消息正文文消息正文文，消息正文文，消息正文文消息正文文消息正文文消息正文文消息正文文消息正文文，消息正文文消息正文文消息正文文消息正文文消息正文文" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
    content.numberOfLines = 0;
    [self.bgView addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(time.mas_bottom).offset(12);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-20);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.left.mas_equalTo(self.bgView).offset(12);
    }];
}

@end



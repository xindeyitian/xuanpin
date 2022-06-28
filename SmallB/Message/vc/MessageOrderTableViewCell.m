//
//  MessageOrderTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/24.
//

#import "MessageOrderTableViewCell.h"

@interface MessageOrderTableViewCell ()

@property (nonatomic , strong)UIImageView *titleImg;
@property (nonatomic , strong)UILabel *timeL;
@property (nonatomic , strong)UILabel *titleL;
@property (nonatomic , strong)UIView *redV;
@property (nonatomic , strong)UILabel *contentL;

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
    self.titleImg = image;
    
    UILabel *time = [UILabel creatLabelWithTitle:@"" textColor:KBlack999TextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_R(12)];
    [self.bgView addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(image.mas_top);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.height.mas_equalTo(24);
    }];
    self.titleL = time;
    
    UILabel *title = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(15)];
    [self.bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(image.mas_top);
        make.right.mas_equalTo(time.mas_left).offset(-5);
        make.left.mas_equalTo(image.mas_right).offset(12);
        make.height.mas_equalTo(24);
    }];
    self.titleL = title;
    
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
    self.redV = red;
    
    UILabel *content = [UILabel creatLabelWithTitle:@"" textColor:KBlack666TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
    [self.bgView addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(image.mas_bottom);
        make.right.mas_equalTo(red.mas_left).offset(-5);
        make.left.mas_equalTo(title.mas_left);
        make.height.mas_equalTo(21);
    }];
    self.contentL = content;
}

- (void)setModel:(MagicBoxMessageListModel *)model{
    _model = model;
    [self.titleImg sd_setImageWithURL:[NSURL URLWithString:model.msgUrl]];
    self.titleL.text = model.msgTitle;
    self.contentL.text = model.msgContent;
    self.timeL.text = [AppTool changeTimeStampFormate:model.createTime];
    self.redV.hidden = model.readSign;
}

@end

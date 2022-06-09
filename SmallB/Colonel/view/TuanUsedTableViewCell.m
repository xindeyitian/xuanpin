//
//  TuanUsedTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/18.
//

#import "TuanUsedTableViewCell.h"

@interface TuanUsedTableViewCell ()

@property (nonatomic , strong)UILabel *codeL;
@property (nonatomic , strong)UILabel *startTimeL;
@property (nonatomic , strong)UILabel *endTimeL;

@end

@implementation TuanUsedTableViewCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"tuan_code_left_imae")];
    [self.contentView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(24);
        make.height.width.mas_equalTo(22);
        make.top.equalTo(self.contentView).offset(14);
    }];
    
    UILabel *code = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    [self.contentView addSubview:code];
    self.codeL = code;
    [code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(image.mas_top);
        make.left.mas_equalTo(image.mas_right).offset(4);
        make.right.mas_equalTo(self.contentView).offset(-24);
        make.height.mas_equalTo(24);
    }];
    
    UILabel *startTime = [UILabel creatLabelWithTitle:@"" textColor:KBlack999TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    [self.contentView addSubview:startTime];
    self.startTimeL = startTime;
    [startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(code.mas_bottom);
        make.left.mas_equalTo(code.mas_left);
        make.right.mas_equalTo(self.contentView).offset(-24);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *endTime = [UILabel creatLabelWithTitle:@"" textColor:KBlack999TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    [self.contentView addSubview:endTime];
    self.endTimeL = endTime;
    [endTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(startTime.mas_bottom).offset(4);
        make.left.mas_equalTo(code.mas_left);
        make.right.mas_equalTo(self.contentView).offset(-24);
        make.height.mas_equalTo(20);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = KBlackLineColor;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView).offset(-0.5);
        make.left.mas_equalTo(self.contentView).offset(24);
        make.right.mas_equalTo(self.contentView).offset(-24);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)setModel:(TaunCodeDataModel *)model{
    _model = model;
    self.codeL.text = [NSString stringWithFormat:@"%@",model.codeNum];
    if (model.beginTime) {
        self.startTimeL.text = [NSString stringWithFormat:@"生效时间:%@",model.beginTime];
    }else{
        self.startTimeL.text = [NSString stringWithFormat:@"生效时间:%@",@""];
    }
    if (model.expireTime) {
        self.endTimeL.text = [NSString stringWithFormat:@"过期时间:%@",model.expireTime];
    }else{
        self.endTimeL.text = [NSString stringWithFormat:@"过期时间:%@",@""];
    }
}

@end


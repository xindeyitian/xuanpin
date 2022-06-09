//
//  MingXiTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/25.
//

#import "MingXiTableViewCell.h"

@interface MingXiTableViewCell ()

@property(nonatomic, strong)UILabel *titleL;
@property(nonatomic, strong)UILabel *moneyL;
@property(nonatomic, strong)UILabel *timeL;
@property(nonatomic, strong)UILabel *orderL;

@end

@implementation MingXiTableViewCell

- (void)setModel:(MingXiRecordListModel *)model{
    _model = model;
    self.titleL.text = model.goodsName;
    self.moneyL.text = [NSString stringWithFormat:@"+%@",model.moneyChange];
    self.timeL.text = model.changeTime;
    self.orderL.text = [NSString stringWithFormat:@"订单号:%@",model.orderNo];;
}

- (void)k_creatSubViews{
    [super k_creatSubViews];
    
    UILabel *money = [UILabel creatLabelWithTitle:@"" textColor:KMaintextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_M(18)];
    [self.bgView addSubview:money];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    title.numberOfLines = 0;
    [self.bgView addSubview:title];
    self.titleL = title;
    self.moneyL = money;
    
    [money setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [title setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(21);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.centerY.mas_equalTo(title.mas_centerY);
    }];

    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(21);
        make.right.mas_equalTo(money.mas_left).offset(-12);
        make.left.mas_equalTo(self.bgView).offset(12);
    }];
    
    UILabel *time = [UILabel creatLabelWithTitle:@"" textColor:KBlack999TextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_R(12)];
    [self.bgView addSubview:time];
    self.timeL = time;
    
    UILabel *order = [UILabel creatLabelWithTitle:@"" textColor:KBlack999TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    [self.bgView addSubview:order];
    self.orderL = order;
    
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(4);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-20);
    }];
    
    [order mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(4);
        make.left.mas_equalTo(self.bgView).offset(12);
        make.right.mas_equalTo(time.mas_left).offset(-12);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-20);
    }];
}

@end

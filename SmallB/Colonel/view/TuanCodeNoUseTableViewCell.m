//
//  TuanCodeNoUseTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/18.
//

#import "TuanCodeNoUseTableViewCell.h"
#import "TuanCodeShareViewController.h"

@interface TuanCodeNoUseTableViewCell ()

@property (nonatomic , strong)UILabel *codeL;
@property (nonatomic , strong)UILabel *timeL;

@end

@implementation TuanCodeNoUseTableViewCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"tuan_code_left_imae")];
    [self.contentView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(24);
        make.height.width.mas_equalTo(22);
        make.top.equalTo(self.contentView).offset(14);
    }];
    
    BaseButton *share = [[BaseButton alloc]init];
    [share setImage:IMAGE_NAMED(@"tuanCode_home_share_btn") forState:UIControlStateNormal];
    [share addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:share];
    [share mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(image.mas_top);
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.height.width.mas_equalTo(22);
    }];
    
    BaseButton *fuzhiBtn = [BaseButton CreateBaseButtonTitle:@"复制" Target:self Action:@selector(copyBtnClick) Font:DEFAULT_FONT_R(12) BackgroundColor:kRGBA(74, 154, 255,0.11) Color:kRGB(74, 154, 255) Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
    fuzhiBtn.clipsToBounds = YES;
    fuzhiBtn.layer.cornerRadius =4;
    [self.contentView addSubview:fuzhiBtn];
    [fuzhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(image.mas_top);
        make.right.mas_equalTo(share.mas_left).offset(-12);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(32);
    }];
    
    UILabel *code = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    [self.contentView addSubview:code];
    self.codeL = code;
    [code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(image.mas_top);
        make.left.mas_equalTo(image.mas_right).offset(4);
        //make.right.mas_equalTo(fuzhiBtn.mas_left).offset(-4);
        make.height.mas_equalTo(24);
    }];
    
    UILabel *status = [UILabel creatLabelWithTitle:@"审核中" textColor:KOrangeTextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    status.hidden = YES;
    [self.contentView addSubview:status];
    [status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(code.mas_top).offset(1);
        make.left.mas_equalTo(code.mas_right).offset(4);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(40);
    }];
    
    UILabel *time = [UILabel creatLabelWithTitle:@"" textColor:KBlack999TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    [self.contentView addSubview:time];
    self.timeL = time;
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(code.mas_bottom).offset(4);
        make.left.mas_equalTo(code.mas_left).offset(4);
        make.right.mas_equalTo(fuzhiBtn.mas_left).offset(-4);
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
    if (model.buyTime) {
        self.timeL.text = [NSString stringWithFormat:@"购买时间:%@",model.beginTime];
    }else{
        self.timeL.text = [NSString stringWithFormat:@"购买时间:%@",@""];
    }
}

- (void)copyBtnClick{
    NSString *copyStr= [NSString stringWithFormat:@"%@",self.model.codeNum];
    [AppTool copyWithString:copyStr];
    [XHToast showCenterWithText:[NSString stringWithFormat:@"团长码:%@\n\n复制成功",copyStr]];
}

- (void)shareBtnClick{
    UIViewController *selfVC = [AppTool currentVC];
    TuanCodeShareViewController *alertVC = [TuanCodeShareViewController new];
    alertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    alertVC.model = self.model;
    [selfVC  presentViewController:alertVC animated:NO completion:nil];
}

@end

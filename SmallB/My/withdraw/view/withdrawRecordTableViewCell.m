//
//  withdrawRecordTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/13.
//

#import "withdrawRecordTableViewCell.h"
#import "rightPushView.h"
#import "withdrawFailAlertViewController.h"

@interface withdrawRecordTableViewCell ()

@property (nonatomic , strong)UIImageView *imageV;
@property (nonatomic , strong)UILabel *titleL;
@property (nonatomic , strong)UILabel *applyL;
@property (nonatomic , strong)UILabel *arrivaL;
@property (nonatomic , strong)UILabel *statusL;
@property (nonatomic , strong)UILabel *moneyL;
@property (nonatomic , strong)rightPushView *rightView;


@end

@implementation withdrawRecordTableViewCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    
    [self.separatorLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(39);
    }];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:nil];
    [self.bgView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(18);
        make.top.equalTo(self.bgView).offset(20);
        make.left.equalTo(self.bgView).offset(12);
    }];
    self.imageV = image;
    
    UILabel *title = [UILabel creatLabelWithTitle:@"" textColor:KBlack666TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    [self.bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(image.mas_top).offset(-2);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.left.mas_equalTo(image.mas_right).offset(10);
        make.height.mas_equalTo(22);
    }];
    self.titleL = title;
    
    UILabel *status = [UILabel creatLabelWithTitle:@"" textColor:kRGB(0, 181, 120) textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_R(15)];
    [self.bgView addSubview:status];
    [status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_top);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.height.mas_equalTo(22);
    }];
    self.statusL = status;
    status.hidden = YES;
    
    UILabel *money = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_M(18)];
    [self.bgView addSubview:money];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-21);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.height.mas_equalTo(25);
    }];
    self.moneyL = money;
    
    UILabel *apply = [UILabel creatLabelWithTitle:@"" textColor:KBlack999TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    [self.bgView addSubview:apply];
    [apply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(8);
        make.left.mas_equalTo(title.mas_left);
        make.right.mas_equalTo(money.mas_left).offset(-10);
        make.height.mas_equalTo(19);
    }];
    self.applyL = apply;
    
    UILabel *time = [UILabel creatLabelWithTitle:@"" textColor:KBlack999TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    [self.bgView addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(apply.mas_bottom).offset(2);
        make.left.mas_equalTo(title.mas_left);
        make.right.mas_equalTo(money.mas_left).offset(-10);
        make.height.mas_equalTo(19);
    }];
    self.arrivaL = time;
    
    rightPushView *view = [[rightPushView alloc]initWithFrame:CGRectMake(ScreenWidth - 24 - 85*KScreenW_Ratio, 20, 85*KScreenW_Ratio, 34)];
    view.titleL.text = @"提现失败";
    view.titleL.textColor = kRGB(250, 23, 45);
    view.imageNameString = @"withdraw_record_fail";
    view.imageHeight = 18;
    [self.bgView addSubview:view];
    view.viewClickBlock = ^{
        UIViewController *selfVC = [AppTool currentVC];
        withdrawFailAlertViewController *alertVC = [withdrawFailAlertViewController new];
        alertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        alertVC.content = self.model.dealDesc;
        [selfVC  presentViewController:alertVC animated:NO completion:nil];
    };
    self.rightView = view;
}

- (void)setModel:(WithdrawRecordListModel *)model{
    _model = model;
   
    self.applyL.text = [NSString stringWithFormat:@"申请时间: %@",model.applyTime];
    self.titleL.text = model.withdrawName;
    if (model.arrivalTime) {
        self.arrivaL.text = [NSString stringWithFormat:@"到账时间: %@",model.arrivalTime];
    }else{
        self.arrivaL.text = [NSString stringWithFormat:@"到账时间: %@",@""];
    }
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",model.moneyValue]];
    NSRange range = NSMakeRange(model.moneyValue.length,1);
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_M(15) range:range];
    self.moneyL.attributedText = attributeMarket;
    

    //支付宝提现  withdraw_record_zhifubao
    //微信提现 withdraw_record_weixin
    
    //accountType   微信  支付宝  银行卡
    
    switch (model.accountType.integerValue) {
        case 1:
            self.imageV.image = IMAGE_NAMED(@"withdraw_record_weixin");
            break;
        case 2:
            self.imageV.image = IMAGE_NAMED(@"withdraw_record_zhifubao");
            break;
        case 3:
            self.imageV.image = IMAGE_NAMED(@"withdraw_record_card");
            break;
            
        default:
            break;
    }
    
    //0待审核 1已处理 -1提现失败 dealSign
 
    //提现成功  rgba(0, 181, 120, 1)
    //提现失败  rgba(250, 23, 45, 1)
    //申请中  rgba(255, 203, 50, 1)
    self.rightView.hidden = YES;
    self.statusL.hidden = NO;
    switch (model.dealSign.integerValue) {
        case 0:{
            self.statusL.text = @"申请中";
            self.statusL.textColor = kRGB(255, 203, 50);
        }
            break;
        case 1:
        case 9:{
            self.statusL.text = @"提现成功";
            self.statusL.textColor = kRGB(0, 181, 120);
        }
            break;
        case -1:{
            self.statusL.text = @"提现失败";
            self.statusL.textColor = kRGB(250, 23, 45);
            self.rightView.hidden = NO;
            self.statusL.hidden = YES;
        }
            break;
            
        default:
            break;
    }
}

@end

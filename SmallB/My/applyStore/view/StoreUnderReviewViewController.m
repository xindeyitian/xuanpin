//
//  StoreUnderReviewViewController.m
//  SmallB
//
//  Created by zhang on 2022/6/16.
//

#import "StoreUnderReviewViewController.h"

@interface StoreUnderReviewViewController ()

@end

@implementation StoreUnderReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(274*KScreenW_Ratio);
        make.left.mas_equalTo(self.view).offset(24*KScreenW_Ratio);
        make.right.mas_equalTo(self.view).offset(-24*KScreenW_Ratio);
    }];
    
    UIImageView *topImage = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"my_store_underReview_alert")];
    [self.bgView addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView.mas_centerX);
        make.height.width.mas_equalTo(84*KScreenW_Ratio);
        make.top.equalTo(self.bgView).offset(12*KScreenW_Ratio);
    }];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"小莲云仓正在审核中，请等待审核！" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(17)];
    [self.bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topImage.mas_bottom).offset(5*KScreenW_Ratio);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.left.mas_equalTo(self.bgView).offset(12);
        make.height.mas_equalTo(25*KScreenW_Ratio);
    }];
    
    UILabel *subTitle = [UILabel creatLabelWithTitle:@"客服会与您核实开店信息，\n请注意接听电话！" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(15)];
    subTitle.numberOfLines = 2;
    [self.bgView addSubview:subTitle];
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(12*KScreenW_Ratio);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.left.mas_equalTo(self.bgView).offset(12);
        make.height.mas_equalTo(54*KScreenW_Ratio);
    }];
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"去留莲忘返APP逛逛" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 22*KScreenW_Ratio;
    [self.bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-26);
        make.right.mas_equalTo(self.bgView).offset(-30);
        make.left.mas_equalTo(self.bgView).offset(30);
        make.height.mas_equalTo(44*KScreenW_Ratio);
    }];
}

- (void)btnClick{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"LLWF:walkAround"]]];
}

@end

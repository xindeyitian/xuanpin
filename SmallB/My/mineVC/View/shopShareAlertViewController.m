//
//  shopShareAlertViewController.m
//  SmallB
//
//  Created by zhang on 2022/6/16.
//

#import "shopShareAlertViewController.h"

@interface shopShareAlertViewController ()

@end

@implementation shopShareAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)creatSubViews{
    [super creatSubViews];
    [self.BGWhiteV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(433*KScreenW_Ratio);
        make.width.mas_equalTo(314*KScreenW_Ratio);
    }];
    //my_applyStore_share  邀请开店
    //my_share_shop  分享店铺
    UIImageView *image = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"my_share_shop")];
    [self.BGWhiteV addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(326*KScreenW_Ratio);
        make.width.mas_equalTo(314*KScreenW_Ratio);
        make.left.top.equalTo(self.BGWhiteV);
    }];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"优选好货～" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(15)];
    [self.BGWhiteV addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(image.mas_bottom).offset(30*KScreenW_Ratio);
        make.right.mas_equalTo(self.BGWhiteV).offset(-100);
        make.left.mas_equalTo(self.BGWhiteV).offset(16);
        make.height.mas_equalTo(24*KScreenW_Ratio);
    }];
    
    UILabel *subTitle = [UILabel creatLabelWithTitle:@"扫描注册-下载APP-参与活动" textColor:KMaintextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    [self.BGWhiteV addSubview:subTitle];
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(5*KScreenW_Ratio);
        make.right.mas_equalTo(self.BGWhiteV).offset(-100);
        make.left.mas_equalTo(self.BGWhiteV).offset(16);
        make.height.mas_equalTo(20*KScreenW_Ratio);
    }];
    
    UIImageView *codeImage = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"")];
    [self.BGWhiteV addSubview:codeImage];
    [codeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(76*KScreenW_Ratio);
        make.right.equalTo(self.BGWhiteV).offset(-12);
        make.top.equalTo(image.mas_bottom).offset(16*KScreenW_Ratio);
    }];
    codeImage.image = [AppTool createQRImageWithString:@"这里是分享店铺"];
    
    self.titleS = @"分享店铺";
    self.descriptionS = @"这里是分享店铺";
    self.webpageUrlS = @"这里是分享店铺url";
    
    if (self.isOpenShop) {
        image.image = IMAGE_NAMED(@"my_applyStore_share");
        
        title.text = @"开云店，享百万积分！";
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(image.mas_bottom).offset(13*KScreenW_Ratio);
        }];
        
        subTitle.text = @"扫描注册-下载APP-参与活动";
        [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(title.mas_bottom).offset(5*KScreenW_Ratio);
        }];
        
        UILabel *codeTitle = [UILabel creatLabelWithTitle:@"邀请码：" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
        [self.BGWhiteV addSubview:codeTitle];
        [codeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(subTitle.mas_bottom).offset(8*KScreenW_Ratio);
            make.right.mas_equalTo(self.BGWhiteV).offset(-100);
            make.left.mas_equalTo(self.BGWhiteV).offset(16);
            make.height.mas_equalTo(23*KScreenW_Ratio);
        }];
        NSString *inviteCode = [AppTool getLocalDataWithKey:@"inviteCode"];
        if (inviteCode.length) {
            codeTitle.text = [NSString stringWithFormat:@"邀请码：%@",inviteCode];
        }
        codeImage.image = [AppTool createQRImageWithString:@"这里是邀请开店"];
    
        self.titleS = @"邀请开店";
        self.descriptionS = @"这里是邀请开店";
        self.webpageUrlS = @"这里是邀请开店url";
    }
}

@end

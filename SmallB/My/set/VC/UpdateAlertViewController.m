//
//  UpdateAlertViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/26.
//

#import "UpdateAlertViewController.h"

@interface UpdateAlertViewController ()

@end

@implementation UpdateAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.height.mas_equalTo(367*KScreenW_Ratio);
        make.left.mas_equalTo(self.view).offset(24*KScreenW_Ratio);
        make.right.mas_equalTo(self.view).offset(-24*KScreenW_Ratio);
    }];
    
    UIImageView *bgV = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"update_version")];
    bgV.userInteractionEnabled = YES;
    [self.bgView addSubview:bgV];
    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.bgView);
    }];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"有新版本啦！" textColor:KWhiteTextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(25)];
    [bgV addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgV).offset(30*KScreenW_Ratio);
        make.right.mas_equalTo(bgV).offset(-20*KScreenW_Ratio);
        make.left.mas_equalTo(bgV).offset(20*KScreenW_Ratio);
        make.height.mas_equalTo(36*KScreenW_Ratio);
    }];
    
    UILabel *subTitle = [UILabel creatLabelWithTitle:@"最新版本" textColor:KWhiteTextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(15)];
    [bgV addSubview:subTitle];
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(6*KScreenW_Ratio);
        make.left.mas_equalTo(bgV).offset(20*KScreenW_Ratio);
        make.height.mas_equalTo(21*KScreenW_Ratio);
    }];
    
    UILabel *versionL = [UILabel creatLabelWithTitle:@"-" textColor:KMaintextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(15)];
    versionL.backgroundColor = KWhiteBGColor;
    versionL.clipsToBounds = YES;
    versionL.layer.cornerRadius = 11*KScreenW_Ratio;
    
    [bgV addSubview:versionL];
    [versionL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(subTitle.mas_centerY);
        make.left.mas_equalTo(subTitle.mas_right).offset(8*KScreenW_Ratio);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(22*KScreenW_Ratio);
    }];
    
    UILabel *descrL = [UILabel creatLabelWithTitle:@"更新描述：" textColor:KMaintextColor textAlignment:NSTextAlignmentLeft font:BOLD_FONT_R(17)];
    [bgV addSubview:descrL];
    [descrL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgV).offset(137*KScreenW_Ratio);
        make.left.mas_equalTo(bgV).offset(23*KScreenW_Ratio);
        make.height.mas_equalTo(25*KScreenW_Ratio);
    }];
    
    UILabel *contentL = [UILabel creatLabelWithTitle:@"-" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    contentL.numberOfLines = 0;
    [bgV addSubview:contentL];
    [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(descrL.mas_bottom).offset(13*KScreenW_Ratio);
        make.left.mas_equalTo(bgV).offset(23*KScreenW_Ratio);
        make.height.mas_lessThanOrEqualTo(110*KScreenW_Ratio-30*KScreenW_Ratio);
    }];
    
    UILabel *timeL = [UILabel creatLabelWithTitle:@"-" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    [bgV addSubview:timeL];
    [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentL.mas_bottom).offset(8*KScreenW_Ratio);
        make.left.mas_equalTo(bgV).offset(23*KScreenW_Ratio);
        make.height.mas_equalTo(22*KScreenW_Ratio);
    }];
    
    if (self.model) {
        timeL.text = [NSString stringWithFormat:@"发布时间：%@",self.model.createTime];
        contentL.text = self.model.versionDesc;
        
        NSString *version = [self.model.versionCode componentsSeparatedByString:@"supply_ios_"].lastObject;
        
        float width = [version sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:DEFAULT_FONT_R(15), NSFontAttributeName, nil]].width+1;
        versionL.text = version;
        [versionL mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width + 20*KScreenW_Ratio);
        }];
    }

    BaseButton *cancelBtn = [BaseButton CreateBaseButtonTitle:@"取消" Target:self Action:@selector(confirmClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:KBGColor Color:KBlack666TextColor Frame:CGRectMake(0, 0, 0, 0) Alignment:NSTextAlignmentCenter Tag:22];
    [bgV addSubview:cancelBtn];
    cancelBtn.clipsToBounds = YES;
    cancelBtn.layer.cornerRadius = 22;
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bgV.mas_bottom).offset(-26*KScreenW_Ratio);
        make.height.mas_equalTo(44*KScreenW_Ratio);
        make.width.mas_equalTo(143*KScreenW_Ratio);
        make.left.mas_equalTo(self.bgView).offset(12*KScreenW_Ratio);
    }];
    
    BaseButton *confirmBtn = [BaseButton CreateBaseButtonTitle:@"立即升级" Target:self Action:@selector(confirmClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectMake(0, 0, 0, 0) Alignment:NSTextAlignmentCenter Tag:23];
    [bgV addSubview:confirmBtn];
    confirmBtn.clipsToBounds = YES;
    confirmBtn.layer.cornerRadius = 22;
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bgV.mas_bottom).offset(-26*KScreenW_Ratio);
        make.height.mas_equalTo(44*KScreenW_Ratio);
        make.width.mas_equalTo(143*KScreenW_Ratio);
        make.right.mas_equalTo(self.bgView).offset(-12*KScreenW_Ratio);
    }];
}

- (void)confirmClick:(BaseButton *)btn{
    if (btn.tag == 22) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    if (btn.tag == 23) {
        [AppTool openAppStore];
    }
}

@end


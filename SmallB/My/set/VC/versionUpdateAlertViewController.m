//
//  versionUpdateAlertViewController.m
//  SmallB
//
//  Created by zhang on 2022/7/5.
//

#import "versionUpdateAlertViewController.h"

@interface versionUpdateAlertViewController ()

@end

@implementation versionUpdateAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.height.equalTo(@(367));
        make.left.mas_equalTo(self.view).offset(24*KScreenW_Ratio);
        make.right.mas_equalTo(self.view).offset(-24*KScreenW_Ratio);
    }];
    
    UIImageView *bgV = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"update_version")];
    bgV.userInteractionEnabled = YES;
    [self.bgView addSubview:bgV];
    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.bgView);
    }];
}

@end

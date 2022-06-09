//
//  ProductDeatilInfoTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/24.
//

#import "ProductDeatilInfoTableViewCell.h"

@implementation ProductDeatilInfoTableViewCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    self.separatorLineView.hidden = YES;
    
    self.leftL.textColor = KBlack999TextColor;
    self.leftL.font = DEFAULT_FONT_R(13);
    self.rightL.textAlignment = NSTextAlignmentLeft;
    self.rightL.textColor = KBlack333TextColor;
    self.rightL.font = DEFAULT_FONT_R(13);
    
    UIImageView *image = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"my_right_gray")];
    [self.bgView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.width.height.mas_equalTo(16);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
    }];
    self.rightImgV = image;
    
    [self.leftL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.bgView);
        make.left.mas_equalTo(self.bgView).offset(12);
    }];
    
    [self.rightL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.bgView);
        make.right.mas_equalTo(image.mas_left).offset(-12);
    }];
}

@end

@implementation ProductDeatilInfoBiaoQianTableViewCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    self.separatorLineView.hidden = YES;

    self.rightL.hidden = self.rightImgV.hidden = YES;
    
    NSArray *titleAry = @[@" 假一赔十",@" 100%正品",@" 放心承诺"];
    for (int i =0; i <3; i ++) {
        BaseButton *btn = [BaseButton CreateBaseButtonTitle:titleAry[i] Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_R(13) BackgroundColor:KWhiteBGColor Color:KBlack333TextColor Frame:CGRectMake(60+90*i, 0, 85*KScreenW_Ratio, 40) Alignment:NSTextAlignmentCenter Tag:11];
        [btn setImage:IMAGE_NAMED(@"product_detail_select_normal") forState:UIControlStateNormal];
        [btn setImage:IMAGE_NAMED(@"product_detail_select_normal") forState:UIControlStateHighlighted];
        [self addSubview:btn];
    } 
}

- (void)btnClick{
    
}

@end

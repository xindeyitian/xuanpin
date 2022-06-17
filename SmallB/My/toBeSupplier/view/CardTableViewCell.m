//
//  CardTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/13.
//

#import "CardTableViewCell.h"

@implementation CardTableViewCell

-(void)k_creatSubViews{
    [super k_creatSubViews];
    
    self.contentView.backgroundColor = KWhiteBGColor;
    self.imageAry = [NSMutableArray arrayWithObjects:@"1",@"1",@"1",nil];
    
    UILabel *shouchiTitle = [UILabel creatLabelWithTitle:@"本人手持身份证" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(17)];
    [self.contentView addSubview:shouchiTitle];
    [shouchiTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(12);
        make.left.mas_equalTo(self.contentView).offset(12);
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.height.mas_equalTo(25);
    }];
    
    CardImgView *shouchiImgaV = [[CardImgView alloc]init];
    shouchiImgaV.addBtn.tag = 111;
    [shouchiImgaV.addBtn setBackgroundImage:IMAGE_NAMED(@"card_shouchi_btn") forState:UIControlStateNormal];
    [shouchiImgaV.addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:shouchiImgaV];
    [shouchiImgaV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(shouchiTitle.mas_bottom).offset(12);
        make.left.mas_equalTo(self.contentView).offset(12);
        make.height.mas_equalTo(128);
        make.width.mas_equalTo(198);
    }];
    
    UILabel *cardTitle = [UILabel creatLabelWithTitle:@"上传身份证正反面" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(17)];
    [self.contentView addSubview:cardTitle];
    [cardTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(shouchiImgaV.mas_bottom).offset(23);
        make.left.mas_equalTo(self.contentView).offset(12);
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.height.mas_equalTo(25);
    }];
    
    UILabel *subTitle = [UILabel creatLabelWithTitle:@"(要求：拍摄清晰，露出四个边角，请勿压边拍摄，避免反光)" textColor:kRGB(250, 119, 109) textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    //subTitle.numberOfLines = 0;
    [self.contentView addSubview:subTitle];
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cardTitle.mas_bottom).offset(2);
        make.left.mas_equalTo(self.contentView).offset(12);
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.height.mas_equalTo(20);
    }];
    
    CardImgView *cardZheng = [[CardImgView alloc]init];
    cardZheng.addBtn.tag = 112;
    [cardZheng.addBtn setBackgroundImage:IMAGE_NAMED(@"card_zheng_btn") forState:UIControlStateNormal];
    [cardZheng.addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cardZheng];
    [cardZheng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(subTitle.mas_bottom).offset(12);
        make.left.mas_equalTo(self.contentView).offset(12);
        make.height.mas_equalTo(128);
        make.width.mas_equalTo(198);
    }];
    
    UILabel *zheng = [UILabel creatLabelWithTitle:@"上传身份证正面" textColor:KBlack999TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(12)];
    [self.contentView addSubview:zheng];
    [zheng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cardZheng.mas_bottom).offset(12);
        make.left.mas_equalTo(self.contentView).offset(12);
        make.width.mas_equalTo(198);
        make.height.mas_equalTo(20);
    }];
    
    CardImgView *cardFan = [[CardImgView alloc]init];
    cardFan.addBtn.tag = 113;
    [cardFan.addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cardFan.addBtn setBackgroundImage:IMAGE_NAMED(@"card_fan_btn") forState:UIControlStateNormal];
    [self.contentView addSubview:cardFan];
    [cardFan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(zheng.mas_bottom).offset(12);
        make.left.mas_equalTo(self.contentView).offset(12);
        make.height.mas_equalTo(128);
        make.width.mas_equalTo(198);
    }];
    
    UILabel *fan = [UILabel creatLabelWithTitle:@"上传身份证反面" textColor:KBlack999TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(12)];
    [self.contentView addSubview:fan];
    [fan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cardFan.mas_bottom).offset(12);
        make.left.mas_equalTo(self.contentView).offset(12);
        make.width.mas_equalTo(198);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(self.contentView).offset(-12);
    }];
}

- (void)setImageAry:(NSMutableArray *)imageAry{
    _imageAry = imageAry;
    if (self.isEdit) {
        UIButton *shouchi = [self viewWithTag:111];
        UIButton *zheng = [self viewWithTag:112];
        UIButton *fan = [self viewWithTag:113];
        if ([_imageAry[0] isKindOfClass:[NSString class]]) {
            [shouchi sd_setImageWithURL:[NSURL URLWithString:_imageAry[0]] forState:UIControlStateNormal];
            [shouchi sd_setImageWithURL:[NSURL URLWithString:_imageAry[0]] forState:UIControlStateHighlighted];
        }else{
            [shouchi setImage:_imageAry[0] forState:UIControlStateNormal];
        }
        if ([_imageAry[1] isKindOfClass:[NSString class]]) {
            [zheng sd_setImageWithURL:[NSURL URLWithString:_imageAry[1]] forState:UIControlStateNormal];
            [zheng sd_setImageWithURL:[NSURL URLWithString:_imageAry[1]] forState:UIControlStateHighlighted];
        }else{
            [zheng setImage:_imageAry[1] forState:UIControlStateNormal];
        }
        if ([_imageAry[2] isKindOfClass:[NSString class]]) {
            [fan sd_setImageWithURL:[NSURL URLWithString:_imageAry[2]] forState:UIControlStateNormal];
            [fan sd_setImageWithURL:[NSURL URLWithString:_imageAry[2]] forState:UIControlStateHighlighted];
        }else{
            [fan setImage:_imageAry[2] forState:UIControlStateNormal];
        }
    }
}

- (void)btnClick:(BaseButton *)btn{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.naviTitleColor = [UIColor whiteColor];
    imagePickerVc.barItemTextColor = [UIColor whiteColor];
   
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (photos.count) {
            [btn setBackgroundImage:photos[0] forState:UIControlStateNormal];
            if (btn.tag == 111) {
                self.shouchiImage = photos[0];
                [self.imageAry replaceObjectAtIndex:0 withObject:photos[0]];
            }
            if (btn.tag == 112) {
                self.zhengImage = photos[0];
                [self.imageAry replaceObjectAtIndex:1 withObject:photos[0]];
            }
            if (btn.tag == 113) {
                self.fanImage = photos[0];
                [self.imageAry replaceObjectAtIndex:2 withObject:photos[0]];
            }
            if (_viewBlock) {
                _viewBlock(self.imageAry);
            }
        }
    }];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [[AppTool currentVC] presentViewController:imagePickerVc animated:YES completion:nil];
}

@end


@implementation CardImgView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{

    self.userInteractionEnabled = YES;
    self.image = IMAGE_NAMED(@"card_info_shouchi_bg");
    self.addBtn = [[BaseButton alloc]initWithFrame:CGRectZero];
    self.addBtn.clipsToBounds = YES;
    self.addBtn.layer.cornerRadius = 4;
    [self addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(7, 7, 7, 7));
    }];
}

@end

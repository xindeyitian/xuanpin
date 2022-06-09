//
//  mySetTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import "mySetTableViewCell.h"

@interface mySetTableViewCell ()

@property (nonatomic , strong)UILabel *titleL;
@property (nonatomic , strong)UIImageView *rightImgV;

@end

@implementation mySetTableViewCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    
    self.contentView.backgroundColor = KViewBGColor;
    
    self.titleL = [UILabel creatLabelWithTitle:@"234" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    [self.bgView addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(12);
        make.top.height.mas_equalTo(self.bgView);
    }];
    
    self.rightImgV = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"my_right_gray")];
    [self.bgView addSubview:self.rightImgV];
    [self.rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(18);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.centerY.mas_equalTo(self.titleL.mas_centerY);
    }];
    
    self.contentL = [UILabel creatLabelWithTitle:@"234" textColor:KBlack333TextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_R(15)];
    [self.bgView addSubview:self.contentL];
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).offset(-35);
        make.top.height.mas_equalTo(self.bgView);
        make.left.mas_equalTo(self.titleL.mas_right).offset(5);
    }];
}

- (void)setModel:(mySetDataModel *)model{
    _model = model;
    self.titleL.text = model.titleStr;
    self.rightImgV.hidden = model.hiddenRightImgV;
    self.contentL.text = model.detailStr;
    [self.contentL mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).offset(model.hiddenRightImgV ? -12 : -35);
    }];
    if (model.detailStr.length) {
        self.contentL.text = model.detailStr;
        self.contentL.textColor = KBlack333TextColor;
    }else{
        self.contentL.text = model.placerHolderStr;
        self.contentL.textColor = KBlack666TextColor;
    }
    if (model.detailColor) {
        self.contentL.textColor = model.detailColor;
    }
}

@end

@interface mySetTableHeaderView ()

@end

@implementation mySetTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    self.backgroundColor = kRGB(238, 238, 238);
    
    UIImageView *imgV = [[UIImageView alloc]initWithImage:nil];
    imgV.clipsToBounds = YES;
    imgV.layer.cornerRadius = 51;
    [self addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(102);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    self.userLogo = imgV;
    NSString *userLogo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userLogo"];
    if (userLogo.length) {
        [self.userLogo sd_setImageWithURL:[NSURL URLWithString:userLogo] placeholderImage:KPlaceholder_DefaultImage];
    }
    
    UILabel *titleL = [UILabel creatLabelWithTitle:@"点击修改头像" textColor:KBlack999TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(12)];
    [self addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(24);
        make.left.right.mas_equalTo(self);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self).offset(-12);
    }];
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)]];
}

- (void)tapClick{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.naviTitleColor = [UIColor whiteColor];
    imagePickerVc.barItemTextColor = [UIColor whiteColor];

    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (photos.count) {
            if (_selectImageBlock) {
                _selectImageBlock(photos[0]);
            }
            self.userLogo.image = photos[0];
        }
        CJWeakSelf()
        THBaseViewController *vc = (THBaseViewController *)[AppTool currentVC];
        [vc startLoadingHUD];
        [AppTool uploadImages:@[photos[0]] isAsync:YES callback:^(BOOL success, NSString * _Nonnull msg, NSArray<NSString *> * _Nonnull keys) {
            CJStrongSelf();
            [vc stopLoadingHUD];
            if (_uploadImageBlock) {
                _uploadImageBlock([NSString stringWithFormat:@"%@/%@",msg,[keys firstObject]]);
            }
        }];
    }];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [[AppTool currentVC] presentViewController:imagePickerVc animated:YES completion:nil];
}

@end

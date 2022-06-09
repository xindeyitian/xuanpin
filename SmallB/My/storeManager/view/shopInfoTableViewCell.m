//
//  shopInfoTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/15.
//

#import "shopInfoTableViewCell.h"

@interface shopInfoTableViewCell ()

@property (nonatomic , strong)UIImageView *logoImgV;

@end

@implementation shopInfoTableViewCell

-(void)k_creatSubViews{
    [super k_creatSubViews];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"店铺LOGO" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(15)];
    title.frame = CGRectMake(24, 0, ScreenWidth - 110, 23);
    [self addSubview:title];
    
    UILabel *subTitle = [UILabel creatLabelWithTitle:@"好的招牌能让人眼前一亮" textColor:KBlack999TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    subTitle.frame = CGRectMake(24, 27, ScreenWidth - 110, 23);
    [self addSubview:subTitle];
    
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 103, 0, 50, 50)];
    logo.image = IMAGE_NAMED(@"shop_logo_image");
    logo.clipsToBounds = YES;
    logo.layer.cornerRadius = 4;
    [self addSubview:logo];
    self.logoImgV = logo;
    
    UIImageView *right = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 48, 13, 24, 24)];
    right.image = IMAGE_NAMED(@"my_right_gray");
    [self addSubview:right];
    
    self.contentView.userInteractionEnabled = YES;
    [self.contentView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)]];
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
            self.logoImgV.image = photos[0];
        }
    }];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [[AppTool currentVC] presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)setSelectImage:(UIImage *)selectImage{
    self.logoImgV.image = selectImage;
}

- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    [self.logoImgV sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
}

@end

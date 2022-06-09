//
//  ShopInstroTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/15.
//

#import "ShopInstroTableViewCell.h"

@implementation ShopInstroTableViewCell

-(void)k_creatSubViews{
    [super k_creatSubViews];
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setBackgroundImage:IMAGE_NAMED(@"shop_add_photot_image") forState:UIControlStateNormal];
    [btn setBackgroundImage:IMAGE_NAMED(@"shop_add_photot_image") forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 4;
    btn.clipsToBounds = YES;
    [self.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 24, 0, 24));
    }];
    self.addBtn = btn;
    
    UIButton *deleteBtn = [[UIButton alloc]init];
    [deleteBtn setImage:IMAGE_NAMED(@"supplier_add_photo_delete") forState:UIControlStateNormal];
    [btn addSubview:deleteBtn];
    [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(btn).offset(-4);
        make.top.mas_equalTo(btn).offset(4);
        make.height.width.mas_equalTo(18);
    }];
    deleteBtn.hidden = YES;
    self.deleteB = deleteBtn;
}

- (void)addBtnClick{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.naviTitleColor = [UIColor whiteColor];
    imagePickerVc.barItemTextColor = [UIColor whiteColor];
   CJWeakSelf()
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (photos.count) {
            CJStrongSelf()
            if (_selectImageBlock) {
                _selectImageBlock(photos[0]);
            }
            [self.addBtn setBackgroundImage:photos[0] forState:UIControlStateNormal];
            [self.addBtn setBackgroundImage:photos[0] forState:UIControlStateHighlighted];
        }
    }];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [[AppTool currentVC] presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)setSelectImage:(UIImage *)selectImage{
    [self.addBtn setImage:selectImage forState:UIControlStateNormal];
    [self.addBtn setImage:selectImage forState:UIControlStateHighlighted];
}

- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    [self.addBtn sd_setImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateNormal];
    [self.addBtn sd_setImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateHighlighted];
}

- (void)deleteBtnClick{
    
}

@end

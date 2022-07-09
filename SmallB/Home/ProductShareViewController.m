//
//  ProductShareViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/22.
//

#import "ProductShareViewController.h"
#import "WXApi.h"

@interface ProductShareViewController ()

@end

@implementation ProductShareViewController

- (void)creatSubViews{
    [super creatSubViews];
    [self.BGWhiteV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(390*KScreenW_Ratio);
        make.width.mas_equalTo(262*KScreenW_Ratio);
    }];
    UIImageView *productImg = [[UIImageView alloc]init];
    productImg.frame = CGRectMake(12*KScreenW_Ratio, 12*KScreenW_Ratio, 238*KScreenW_Ratio, 238*KScreenW_Ratio);
    [self.BGWhiteV addSubview:productImg];
    [productImg sd_setImageWithURL:[NSURL URLWithString:self.model.goodsThumb] placeholderImage:nil];

    UILabel *titleL = [UILabel creatLabelWithTitle:self.model.goodsName textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
    titleL.frame = CGRectMake(12*KScreenW_Ratio, 258*KScreenW_Ratio, 238*KScreenW_Ratio, 40*KScreenW_Ratio);
    titleL.numberOfLines = 2;
    [self.BGWhiteV addSubview:titleL];

    UILabel *priceL = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DIN_Regular_FONT_R(11)];
    priceL.frame = CGRectMake(12*KScreenW_Ratio, 298*KScreenW_Ratio, 248*KScreenW_Ratio, 33);
    [self.BGWhiteV addSubview:priceL];

    NSString *price = [NSString stringWithFormat:@"¥%@ ¥%@",self.model.salePrice,self.model.marketPrice];
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:price];
    NSRange range = NSMakeRange(0,1);
    [attributeMarket addAttribute:NSFontAttributeName value:DIN_Medium_FONT_R(18) range:range];
    [attributeMarket addAttribute:NSFontAttributeName value:DIN_Medium_FONT_R(18) range:NSMakeRange(1,self.model.salePrice.length)];

    NSRange PriceRange = NSMakeRange(price.length-self.model.marketPrice.length-1,self.model.marketPrice.length+1);
    [attributeMarket setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:PriceRange];
    [attributeMarket addAttribute:NSForegroundColorAttributeName value:KBlack999TextColor range:PriceRange];
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_R(11) range:PriceRange];

    if ([self.model.salePrice containsString:@"."]) {
        NSString *first = [self.model.salePrice componentsSeparatedByString:@"."].firstObject;
        [attributeMarket addAttribute:NSFontAttributeName value:DIN_Medium_FONT_R(25) range:NSMakeRange(1,first.length)];
    }else{
        [attributeMarket addAttribute:NSFontAttributeName value:DIN_Medium_FONT_R(25) range:NSMakeRange(1,self.model.salePrice.length)];
    }
    priceL.attributedText = attributeMarket;

    UIImageView *iamge = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"product_share_content")];
    iamge.frame = CGRectMake(12*KScreenW_Ratio, 390*KScreenW_Ratio - 55, 141, 43);
    [self.BGWhiteV addSubview:iamge];

    UIImageView *code = [[UIImageView alloc]initWithImage:nil];
    code.frame = CGRectMake(262*KScreenW_Ratio - 70, 390*KScreenW_Ratio - 70, 58, 58);
    
    [self.BGWhiteV addSubview:code];
    
    /**
     商品：  pages/home/pages/goodsDetails/goodsDetails?goodsId=100&shopId=10000
     小程序用户版appId：'wx373b68803208c8cb'
     小程序商家版appId:   'wx19dbc62b5b4a21ee'
     */
    self.titleS = @"商品分享";
    self.descriptionS = self.model.goodsName;
    self.thumbImg = self.model.goodsThumb;
    
    [self startLoadingHUD];
    NSMutableDictionary *signDic = [AppTool getRequestSign];
    [signDic setObject:self.model.goodsId forKey:@"goodsID"];
    [signDic setObject:@"-1" forKey:@"otherID"];
    [signDic setObject:@"g" forKey:@"shareGroup"];
    [signDic setObject:[AppTool getLocalDataWithKey:@"shopID"] forKey:@"shopID"];
    [signDic setObject:[AppTool getLocalDataWithKey:@"userID"] forKey:@"userID"];
    
    [THHttpManager FormatPOST:[NSString stringWithFormat:@"%@share/cpi/shortUrl",XTAppBaseUseURL] parameters:signDic dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200 && [data isKindOfClass:[NSString class]]) {
            self.webpageUrlS = (NSString *)data;
            NSString *url = [NSString stringWithFormat:@"%@",data];
            code.image = [AppTool createQRImageWithString:url];
        }
    }];
}

#pragma mark - 保存至相册
- (void)saveImageToPhotoAlbum:(UIImage*)savedImage{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image: (UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *msg = @"保存图片成功";
    if(error != NULL){
        msg = @"保存图片失败" ;
        [self showMessageWithString:msg];
        return;
    }
    [self showSuccessMessageWithString:msg];
}

- (UIImage *)shotShareImageFromView:(UIView *)view withHeight:(CGFloat)height {
    
    CGSize size = CGSizeMake(view.layer.bounds.size.width, height);
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)cancelBtnClick{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end

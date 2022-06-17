//
//  ProductShareViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/22.
//

#import "ProductShareViewController.h"
#import "WXApi.h"

@interface ProductShareViewController ()

@property (nonatomic , strong)UIView *BGWhiteV;

@end

@implementation ProductShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bgView.hidden = YES;
    
    //sself.view.backgroundColor = UIColor.clearColor;
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - KSafeAreaBottomHeight - 57, ScreenWidth, 57 + KSafeAreaBottomHeight)];
    whiteView.backgroundColor = KWhiteBGColor;
    [self.view addSubview:whiteView];
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"取消" Target:self Action:@selector(cancelBtnClick) Font:DEFAULT_FONT_R(17) BackgroundColor:KWhiteBGColor Color:KBlack333TextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
    btn.frame = CGRectMake(0, 0, ScreenWidth, 57);
    [whiteView addSubview:btn];
    
    float btnWidth = ScreenWidth - 100 - 28*3;
    UIView *grayView = [[UIView alloc]init];
    grayView.backgroundColor = kRGB(245, 245, 245);
    [self.view addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(whiteView.mas_top);
        make.height.mas_equalTo(105 + btnWidth/3.0);
    }];
    grayView.bounds = CGRectMake(0, 0, ScreenWidth, 105 + btnWidth/3.0);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:grayView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = grayView.bounds;
    maskLayer.path = maskPath.CGPath;
    grayView.layer.mask = maskLayer;
    
    NSArray *array = @[@"朋友圈",@"微信好友",@"下载",@"复制口令"];
    NSArray *imageAry = @[@"tuan_code_share_weixin_pengyou",@"tuan_code_share_weixin",@"tuan_code_share_xiazai",@"product_share_copy"];
    for (int i = 0 ; i < 4; i ++) {
        
        UIControl *contro = [[UIControl alloc]initWithFrame:CGRectMake(50+(28+btnWidth/4.0)*i, 70, btnWidth/4.0, btnWidth/4.0 + 20)];
        contro.tag = 120+i;
        [contro addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [grayView addSubview:contro];
        
        UIImageView *image = [[UIImageView alloc]initWithImage:IMAGE_NAMED(imageAry[i])];
        image.frame = CGRectMake(0, 0, btnWidth/4.0, btnWidth/4.0);
        [contro addSubview:image];
        
        UILabel *title = [UILabel creatLabelWithTitle:array[i] textColor:KBlack999TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(11)];
        title.frame = CGRectMake(0, btnWidth/3.0+5, btnWidth/4.0, 20);
        [contro addSubview:title];
    }
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2.0 - 70, 49, 84+56, 1)];
    lineV.backgroundColor = kRGB(204, 204, 204);
    [grayView addSubview:lineV];
    
    UILabel *type = [UILabel creatLabelWithTitle:@"分 享" textColor:KBlack999TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(13)];
    type.frame = CGRectMake(0, 0, 56, 18);
    type.centerY = lineV.centerY;
    type.centerX = self.view.centerX;
    type.backgroundColor = grayView.backgroundColor;
    [grayView addSubview:type];
    
    UIView *bgWhiteV = [[UIView alloc]init];
    bgWhiteV.backgroundColor = KWhiteBGColor;
//    bgWhiteV.layer.cornerRadius = 8;
//    bgWhiteV.clipsToBounds = YES;
    [self.view addSubview:bgWhiteV];
    self.BGWhiteV = bgWhiteV;

    [bgWhiteV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(grayView.mas_top).offset(35);
        make.height.mas_equalTo(390*KScreenW_Ratio);
        make.width.mas_equalTo(262*KScreenW_Ratio);
    }];

    UIImageView *productImg = [[UIImageView alloc]init];
    productImg.frame = CGRectMake(12*KScreenW_Ratio, 12*KScreenW_Ratio, 238*KScreenW_Ratio, 238*KScreenW_Ratio);
    [bgWhiteV addSubview:productImg];
    [productImg sd_setImageWithURL:[NSURL URLWithString:self.model.goodsThumb] placeholderImage:nil];
    
    UILabel *titleL = [UILabel creatLabelWithTitle:self.model.goodsName textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
    titleL.frame = CGRectMake(12*KScreenW_Ratio, 258*KScreenW_Ratio, 248*KScreenW_Ratio, 40*KScreenW_Ratio);
    titleL.numberOfLines = 2;
    [bgWhiteV addSubview:titleL];
    
    UILabel *priceL = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DIN_Medium_FONT_R(18)];
    priceL.frame = CGRectMake(12*KScreenW_Ratio, 298*KScreenW_Ratio, 248*KScreenW_Ratio, 33);
    [bgWhiteV addSubview:priceL];
    
    NSString *price = [NSString stringWithFormat:@"¥%@ ¥%@",self.model.salePrice,self.model.marketPrice];
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:price];
    NSRange range = NSMakeRange(0,1);
    [attributeMarket addAttribute:NSFontAttributeName value:DIN_Medium_FONT_R(15) range:range];
    
    NSString *old = [price componentsSeparatedByString:@" "].lastObject;
    NSRange PriceRange = NSMakeRange(price.length-old.length,old.length);
    [attributeMarket setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:PriceRange];
    [attributeMarket addAttribute:NSForegroundColorAttributeName value:KBlack999TextColor range:PriceRange];
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_R(13) range:PriceRange];
    
    NSString *first = [price componentsSeparatedByString:@" "].firstObject;
    NSString *firstDian= [first componentsSeparatedByString:@"."].firstObject;
    [attributeMarket addAttribute:NSFontAttributeName value:DIN_Medium_FONT_R(25) range:NSMakeRange(1,firstDian.length-1)];
    if ([price containsString:@"."]) {
        [attributeMarket addAttribute:NSFontAttributeName value:DIN_Medium_FONT_R(25) range:NSMakeRange(1,price.length-1)];
    }
    priceL.attributedText = attributeMarket;
    
    UIImageView *iamge = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"product_share_content")];
    iamge.frame = CGRectMake(12*KScreenW_Ratio, 390*KScreenW_Ratio - 55, 141, 43);
    [bgWhiteV addSubview:iamge];
    
    UIImageView *code = [[UIImageView alloc]initWithImage:nil];
    code.frame = CGRectMake(262*KScreenW_Ratio - 70, 390*KScreenW_Ratio - 70, 58, 58);
    code.image = [AppTool createQRImageWithString:[NSString stringWithFormat:@"https://h5.tuanhuoit.com/goodsShow.html?id=%@&uid=%@",self.model.goodsId,[AppTool getLocalDataWithKey:@"userID"]]];
    [bgWhiteV addSubview:code];
}

- (void)shareBtnClick:(UIControl *)contro{
    
    float oneWidth = ScreenWidth - 70 - 16;
    UIImage *image = [self shotShareImageFromView:self.BGWhiteV withHeight:390*KScreenW_Ratio];
    if (contro.tag == 120) {
        [AppTool shareWebPageToPlatformTypeWithData:image WXScene:WXSceneTimeline];
    }
    if (contro.tag == 121) {
        [AppTool shareWebPageToPlatformTypeWithData:image WXScene:WXSceneSession];
    }
    if (contro.tag == 122) {
        [self saveImageToPhotoAlbum:image];
    }
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

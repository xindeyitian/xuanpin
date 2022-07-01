//
//  TuanCodeShareViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/19.
//

#import "TuanCodeShareViewController.h"
#import "WXApi.h"

@interface TuanCodeShareViewController ()

@end

@implementation TuanCodeShareViewController

- (void)creatSubViews{
    [super creatSubViews];
    [self.BGWhiteV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(364*KScreenW_Ratio);
        make.width.mas_equalTo(258*KScreenW_Ratio);
    }];
    UIImageView *bgImageV = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"tuan_share_bgimage")];
    [self.BGWhiteV addSubview:bgImageV];
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.BGWhiteV).insets(UIEdgeInsetsMake(8*KScreenW_Ratio, 8*KScreenW_Ratio, 8*KScreenW_Ratio, 8*KScreenW_Ratio));
    }];
    
    NSString *codeStr= [NSString stringWithFormat:@"%@",self.model.codeNum];
    UILabel *code = [UILabel creatLabelWithTitle:codeStr textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(15)];
    code.frame = CGRectMake(8*KScreenW_Ratio, 298*KScreenW_Ratio, 226*KScreenW_Ratio, 20);
    [bgImageV addSubview:code];
    
    UILabel *titleL = [UILabel creatLabelWithTitle:@"团长码" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(17)];
    titleL.frame = CGRectMake(8*KScreenW_Ratio, 138*KScreenW_Ratio, 226*KScreenW_Ratio, 20);
    [bgImageV addSubview:titleL];
    
    UIImageView *codeImg = [[UIImageView alloc]initWithImage:nil];
    codeImg.frame = CGRectMake(0, 173*KScreenW_Ratio, 101*KScreenW_Ratio, 101*KScreenW_Ratio);
    codeImg.centerX = titleL.centerX;
    codeImg.image = [AppTool createQRImageWithString:[NSString stringWithFormat:@"这里是团长码分享：%@",codeStr]];
    [bgImageV addSubview:codeImg];
    
    self.titleS = @"团长码分享";
    self.descriptionS = @"这里是团长码分享";
    self.webpageUrlS = @"这里是团长码分享链接";
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

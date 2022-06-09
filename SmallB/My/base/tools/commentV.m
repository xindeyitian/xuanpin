//
//  commentV.m
//  SmallB
//
//  Created by zhang on 2022/4/15.
//

#import "commentV.h"

@implementation commentV

/**
 UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
 UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
 }];
 [cancle setValue:KBlack666TextColor forKey:@"titleTextColor"];

 UIAlertAction *camera = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
     
 }];
 [camera setValue:KBlack666TextColor forKey:@"titleTextColor"];
 UIAlertAction *picture = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

 }];
 [picture setValue:KBlack666TextColor forKey:@"titleTextColor"];
 [alertVc addAction:cancle];
 [alertVc addAction:camera];
 [alertVc addAction:picture];
 [self presentViewController:alertVc animated:YES completion:nil];
 */


/**
 UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:whiteV.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(8, 8)];
 CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
 maskLayer.frame = whiteV.bounds;
 maskLayer.path = maskPath.CGPath;
 whiteV.layer.mask = maskLayer;
 */

/**
 lable.textColor = KBlack666TextColor;
 lable.font = DEFAULT_FONT_R(13);
 NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:self.titleAry[section]];
 NSRange range = NSMakeRange(0,4);
 [attributeMarket addAttribute:NSForegroundColorAttributeName value:KBlack333TextColor range:range];
 [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_M(15) range:range];
 lable.attributedText = attributeMarket;
 */

/**
 TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
 imagePickerVc.allowPickingVideo = NO;
 imagePickerVc.naviTitleColor = [UIColor whiteColor];
 imagePickerVc.barItemTextColor = [UIColor whiteColor];

 [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
     if (photos.count) {
         if (_selectImageBlock) {
             _selectImageBlock(photos[0]);
         }
         [self.addBtn setBackgroundImage:photos[0] forState:UIControlStateNormal];
         [self.addBtn setBackgroundImage:photos[0] forState:UIControlStateHighlighted];
     }
 }];
 imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
 [[THAPPService shareAppService].currentViewController presentViewController:imagePickerVc animated:YES completion:nil];
 */

/**
 [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
 */

/**
 self.userInteractionEnabled = YES;
 [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)]];
}

- (void)setImageHeight:(float)imageHeight{
 _imageHeight = imageHeight;
 [self.rightImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
     make.right.mas_equalTo(self);
     make.centerY.mas_equalTo(self.mas_centerY);
     make.width.height.mas_equalTo(_imageHeight);
 }];
}

- (void)tapClick{
 if (_viewClickBlock) {
     _viewClickBlock();
 }
}
 */

/**
 NSString *price = @"¥58.00 ¥108.00";
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
 priceL.attributedText = attributeMarket;
 */

@end

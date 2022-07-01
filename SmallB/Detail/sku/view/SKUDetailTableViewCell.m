//
//  SKUDetailTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/25.
//

#import "SKUDetailTableViewCell.h"
#import "ProductDetailModel.h"

@implementation SKUDetailTableViewCell

- (void)setTitleAry:(NSArray *)titleAry{
   
    _titleAry = titleAry;
    self.contentView.backgroundColor = KWhiteBGColor;
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    /**
     float height = 12.0f;
     float firstwidth = 12.0f;
     for (int i =0; i < array.count; i ++) {
         
         float width = [array[i] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:DEFAULT_FONT_R(12), NSFontAttributeName, nil]].width+10;
         firstwidth += width;
         firstwidth += 12;
         if (firstwidth > ScreenWidth - 24) {
             firstwidth = 12.0f;
             height += (24 + 10);
         }
     }
     height += (24 + 10);
     */
    float height = 12.0f;
    float firstwidth = 12.0f;
    for (int i =0; i < titleAry.count; i ++) {
        ProductDetailGoodsSkuAttrValueModel *model = titleAry[i];
        float width = [model.attrValueName sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:DEFAULT_FONT_R(13), NSFontAttributeName, nil]].width+20;
        if (firstwidth + width + 12> ScreenWidth - 24) {
            firstwidth = 12.0f;
            height += (24 + 10);
        }
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(firstwidth, height, width, 24)];
        [btn setTitleColor:KBlack333TextColor forState:UIControlStateNormal];
        [btn setTitle:model.attrValueName forState:UIControlStateNormal];
        btn.titleLabel.font = DEFAULT_FONT_R(13);
        btn.titleLabel.textColor = KBlack333TextColor;
        btn.backgroundColor = KWhiteBGColor;
//        btn.layer.borderColor = KBlackLineColor.CGColor;
//        btn.layer.borderWidth = 1;
        [self.contentView addSubview:btn];
        
        firstwidth += (width + 12);
    }
}

@end

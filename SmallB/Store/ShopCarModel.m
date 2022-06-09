//
//  ShopCarModel.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/13.
//

#import "ShopCarModel.h"

@implementation ShopCarModel
- (void)setProductName:(NSString *)productName{
    
    _productName = productName;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = productName;
    lable.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    lable.numberOfLines = 2;
    CGFloat lineHeight = ceilf(lable.font.lineHeight);
    
    CGFloat lableHeight = [productName sizeWithLabelWidth:(ScreenWidth - 32 - 24) / 2 font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium]].height;
    
    if (lableHeight > lineHeight) {
        
        self.height = lineHeight * 2 + 8 + 20 + 4 + ((ScreenWidth - 32) / 2) * 3 / 4 + 39 + 12;
    }else{
        
        self.height = lineHeight + 8 + 20 + 4 + ((ScreenWidth - 32) / 2) * 3 / 4 + 39 + 12;
    }
}
@end

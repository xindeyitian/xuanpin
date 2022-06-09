//
//  HomeDataModel.m
//  SmallB
//
//  Created by zhang on 2022/5/6.
//

#import "HomeDataModel.h"

@implementation HomeDataModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"bannerListVos":@"BannerListVosModel",
             @"blockDefineVos":@"BlockDefineVosModel",
             @"goodsCategoryListVos":@"GoodsCategoryListVosModel",
             @"blockDefineGoodsVos":@"BlockDefineGoodsVosModel",
    };
}

@end

@implementation BannerListVosModel

@end

@implementation BlockDefineGoodsVosModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"goodsListVos":@"GoodsListVosModel",
             @"brandConceptVos":@"BrandConceptVosModel"
    };
}

@end

@implementation GoodsListVosModel

- (void)setGoodsName:(NSString *)goodsName{
    _goodsName = goodsName;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = goodsName;
    lable.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    lable.numberOfLines = 2;
    CGFloat lineHeight = ceilf(lable.font.lineHeight);
    
    CGFloat lableHeight = [goodsName sizeWithLabelWidth:(ScreenWidth - 32 - 24) / 2 font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium]].height;
    
    if (lableHeight > lineHeight) {
        self.height = lineHeight * 2 + 8 + ((ScreenWidth - 31) / 2) * 3 / 4 + 40 + 33 + 12;;
    }else{
        self.height = lineHeight + 8 + ((ScreenWidth - 31) / 2) * 3 / 4 + 40 + 33 + 12;;
    }
}

@end

@implementation BlockDefineVosModel

@end

@implementation GoodsCategoryListVosModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"listVos":@"HomeListVosModel"};
}

@end

@implementation HomeListVosModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"listVos":@"HomeListVosModel"};
}

@end

@implementation BrandConceptVosModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"goodsListVos":@"GoodsListVosModel"};
}

@end






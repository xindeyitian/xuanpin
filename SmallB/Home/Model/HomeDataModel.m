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

- (NSString *)ossImgPath{
    if ([_ossImgPath isEqual:[NSNull null]]) {
        _ossImgPath = @"";
    }
    if (!_ossImgPath) {
        _ossImgPath = @"";
    }
    return _ossImgPath;
}

- (NSString *)ossImgName{
    if ([_ossImgName isEqual:[NSNull null]]) {
        _ossImgName = @"";
    }
    if (!_ossImgName) {
        _ossImgName = @"";
    }
    return _ossImgName;
}

@end

@implementation BlockDefineGoodsVosModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"goodsListVos":@"GoodsListVosModel",
             @"brandConceptVos":@"BrandConceptVosModel"
    };
}

- (NSString *)blockCode{
    if (_blockId) {
        _blockCode = _blockId;
    }
    return _blockCode;
}

@end

@implementation GoodsListVosModel

- (void)setGoodsName:(NSString *)goodsName{
    _goodsName = goodsName;
    
//    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
//    lable.text = goodsName;
//    lable.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
//    lable.numberOfLines = 2;
//    CGFloat lineHeight = ceilf(lable.font.lineHeight);
//
//    CGFloat lableHeight = [goodsName sizeWithLabelWidth:(ScreenWidth - 32 - 24) / 2 font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium]].height;
//
//    if (_isFirst) {
//        NSLog(@"第一个");
//        self.height = lineHeight * 2 + 8 + ((ScreenWidth - 31) / 2);
//    }else{
//        NSLog(@"第一个1");
//        if (lableHeight > lineHeight) {
//            self.height = lineHeight * 2 + 8 + ((ScreenWidth - 31) / 2) * 3 / 4 + 40 + 33 + 12;
//        }else{
//            self.height = lineHeight + 8 + ((ScreenWidth - 31) / 2) * 3 / 4 + 40 + 33 + 12;
//        }
//    }
}

- (CGFloat)height{
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = _goodsName;
    lable.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    lable.numberOfLines = 2;
    CGFloat lineHeight = ceilf(lable.font.lineHeight);
    
    CGFloat lableHeight = [_goodsName sizeWithLabelWidth:(ScreenWidth - 32 - 24) / 2 font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium]].height;
    
    float allHeight = .0f;
    if (_isFirst) {
        allHeight = ((ScreenWidth - 31) / 2);
    }else{
        if (lableHeight > lineHeight) {
            allHeight = lineHeight * 2 + 8 + ((ScreenWidth - 31) / 2) * 3 / 4 + 40 + 33 + 12;
        }else{
            allHeight = lineHeight + 8 + ((ScreenWidth - 31) / 2) * 3 / 4 + 40 + 33 + 12;
        }
    }
    return allHeight;
}

- (NSString *)goodsThumb{
    NSString *result = @"";
    if (_goodsThumb) {
        result = [AppTool dealChineseUrl:_goodsThumb];
    }
    return result;
}

- (NSString *)salePrice{
    if (_salePrice) {
        _salePrice = [NSString stringWithFormat:@"%.2f",_salePrice.floatValue];
        return _salePrice;
    }
    return @"0";
}

- (NSString *)marketPrice{
    if (_marketPrice) {
        _marketPrice = [NSString stringWithFormat:@"%.2f",_marketPrice.floatValue];
        return _marketPrice;
    }
    return @"0";
}

- (NSString *)commission{
    if (_commission) {
        NSString *commisso = K_NotNullHolder(_commission, @"0");
        _commission = [NSString stringWithFormat:@"%.2f",commisso.floatValue];
        return _commission;
    }
    return @"0";
}

- (NSString *)saleCount{
    if (_saleCount) {
        return K_NotNullHolder(_saleCount, @"0");
    }
    return @"0";
}

- (NSString *)stockQuantity{
    if (_stockQuantity) {
        return K_NotNullHolder(_stockQuantity, @"0");
    }
    return @"0";
}

@end

@implementation BlockDefineVosModel

@end

@implementation GoodsCategoryListVosModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"listVos":@"HomeListVosModel"};
}

- (NSMutableArray *)listVos{
    if (_listVos.count > 10) {
        NSArray *result = [_listVos subarrayWithRange:NSMakeRange(0, 10)];
        return [result mutableCopy];
    }
    return _listVos;
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






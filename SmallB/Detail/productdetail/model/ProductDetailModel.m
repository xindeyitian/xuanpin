//
//  ProductDetailModel.m
//  SmallB
//
//  Created by zhang on 2022/5/6.
//

#import "ProductDetailModel.h"

@implementation ProductDetailModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"goodsImgs":@"ProductImagesModel",
             @"goodsAttVos":@"goodsAttVosModel"
    };
}

-(NSMutableArray *)productImgAry{
    
    if (self.goodsImgs.images.length) {
        NSError *err;
        NSString * jsonString = self.goodsImgs.images;
        id tmp = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
        if (tmp) {
              if ([tmp isKindOfClass:[NSArray class]]) {
                  return tmp;
              } else if([tmp isKindOfClass:[NSString class]]
                        || [tmp isKindOfClass:[NSDictionary class]]) {
                  return [@[] mutableCopy];
              } else {
                  return [@[] mutableCopy];
              }
          } else {
              return [@[] mutableCopy];
          }
      } else {
          return [@[] mutableCopy];
      }
    return [@[] mutableCopy];
//        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                            options:NSJSONReadingMutableContainers error:&err];
//        if ([dic objectForKey:@"images"]) {
//            NSArray *array = (NSArray *)[dic objectForKey:@"images"];
//            return [array mutableCopy];
//        }
//    }
//    return [@[] mutableCopy];
//
//    if (K_NotNull(self.goodsImgs)) {
//        NSError *err;
//        NSString * jsonString = self.goodsImgs;
//        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                            options:NSJSONReadingMutableContainers error:&err];
//        if ([dic objectForKey:@"images"]) {
//            NSArray *array = (NSArray *)[dic objectForKey:@"images"];
//            return [array mutableCopy];
//        }
//    }
//    return [NSMutableArray array];
}

- (NSString *)salePrice{
    if (_salePrice) {
        _salePrice = [NSString stringWithFormat:@"%.2f",_salePrice.floatValue];
    }
    return _salePrice;
}

- (NSString *)marketPrice{
    if (_marketPrice) {
        _marketPrice = [NSString stringWithFormat:@"%.2f",_marketPrice.floatValue];
    }
    return _marketPrice;
}

- (NSString *)commission{
    if (_commission) {
        _commission = [NSString stringWithFormat:@"%.2f",_commission.floatValue];
    }
    return _commission;
}

@end

@implementation ProductImagesModel

@end

@implementation goodsAttVosModel

@end

@implementation supplyInfoGoodsVoModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"goodsListVos":@"GoodsListVosModel",
    };
}

@end

@implementation appraisesListVoPageRecordModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"records":@"commentRecordModel",
    };
}

@end

@implementation commentRecordModel

- (float)biaoQianBGHeight{
    if (self.biaoQianAry.count == 0) {
        return .0f;
    }
    return 30;
}

- (float)contentBGHeight{
    float contentHeight = [self.content sizeWithLabelWidth:ScreenWidth - 24 -24 font:DEFAULT_FONT_R(13)].height+1;
    return contentHeight;
}

- (NSMutableArray *)imageAry{
    NSMutableArray *image = [NSMutableArray array];
    if (self.images.length) {
        [image addObjectsFromArray:[self.images componentsSeparatedByString:@","]];
    }
    return image;
}

- (float)imageBGHeight{
    float imageHeight = .0f;
    if (self.imageAry.count == 1) {
        imageHeight = 200;
        self.oneImageHeight = imageHeight;
        self.num = 1;
    }
    if (self.imageAry.count == 2) {
        imageHeight = (ScreenWidth - 24 - 12 * 2 - 8)/2.0;
        self.oneImageHeight = imageHeight;
        self.num = 2;
    }
    if (self.imageAry.count > 2) {
        float oneHeight = (ScreenWidth - 24 - 12 * 2 - 8 * 2)/3.0;
        imageHeight = (oneHeight + 12)*(self.imageAry.count%3 == 0?self.imageAry.count/3 : self.imageAry.count/3+1);
        self.oneImageHeight = oneHeight;
        self.num = 3;
    }
    return imageHeight;
}

- (float)rowHeight{

    float height = 47;
    if (self.biaoQianAry.count) {
        height += (8+self.biaoQianBGHeight);
    }
    if (self.imageAry.count) {
        height += (8 + self.imageBGHeight);
    }
    height += (8 + self.contentBGHeight);
    height += (28+12);
    return height;
    return 47 + (8+self.biaoQianBGHeight) + (8 + self.contentBGHeight) +(8 + self.imageBGHeight) + 28+12;
}

@end

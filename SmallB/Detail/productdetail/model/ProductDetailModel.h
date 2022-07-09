//
//  ProductDetailModel.h
//  SmallB
//
//  Created by zhang on 2022/5/6.
//

#import "THBaseModel.h"
@class ProductImagesModel,supplyInfoGoodsVoModel,appraisesListVoPageRecordModel;
NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailModel : THBaseModel

@property (nonatomic , copy)NSString *goodsId;
@property (nonatomic , copy)NSString *goodsName;
@property (nonatomic , copy)NSString *categoryId;
@property (nonatomic , strong)ProductImagesModel *goodsImgs;
@property (nonatomic , copy)NSString *salePrice;
@property (nonatomic , copy)NSString *marketPrice;
@property (nonatomic , copy)NSString *commission;
@property (nonatomic , copy)NSString *saleCount;
@property (nonatomic , copy)NSString *supplyId;
@property (nonatomic , strong)NSMutableArray *goodsAttVos;
@property (nonatomic , copy)NSString *descImgs;
@property (nonatomic , strong)NSMutableArray *goodsSkuVos;

@property (nonatomic , strong)NSMutableArray *productImgAry;
@property (nonatomic , strong)appraisesListVoPageRecordModel *appraisesListVoPage;

@property (nonatomic , copy)NSString *ifCollect;
@property (nonatomic , copy)NSString *shopId;
@property (nonatomic , strong)supplyInfoGoodsVoModel *supplyInfoGoodsVo;
@property (nonatomic , copy)NSString *applauseRate;
@property (nonatomic , copy)NSString *serviceTel;

@end

@interface ProductImagesModel : THBaseModel

@property (nonatomic , strong)NSString *images;

@end

@interface goodsAttVosModel : THBaseModel

@property (nonatomic , copy)NSString *attrName;
@property (nonatomic , strong)NSMutableArray *attrValue;

@end

@interface supplyInfoGoodsVoModel: THBaseModel

@property (nonatomic , copy)NSString *supplyId;
@property (nonatomic , copy)NSString *supplyName;
@property (nonatomic , copy)NSString *logoImgUrl;
@property (nonatomic , copy)NSString *collectCount;
@property (nonatomic , strong)NSMutableArray *goodsListVos;

@end

@interface appraisesListVoPageRecordModel: THBaseModel

@property (nonatomic , strong)NSMutableArray *records;
@property (nonatomic , copy)NSString *total;

@end

@interface commentRecordModel: THBaseModel

@property (nonatomic , copy)NSString *appraisesId;
@property (nonatomic , copy)NSString *userId;
@property (nonatomic , copy)NSString *nickName;
@property (nonatomic , copy)NSString *avatar;
@property (nonatomic , copy)NSString *goodsSkuName;
@property (nonatomic , copy)NSString *images;
@property (nonatomic , copy)NSString *goodsScore;
@property (nonatomic , copy)NSString *createTime;
@property (nonatomic , copy)NSString *content;

@property (nonatomic ,strong)NSMutableArray *biaoQianAry;
@property (nonatomic ,strong)NSMutableArray *imageAry;

@property (nonatomic ,assign)float rowHeight;
@property (nonatomic ,assign)float biaoQianBGHeight;
@property (nonatomic ,assign)float imageBGHeight;
@property (nonatomic ,assign)float oneImageHeight;
@property (nonatomic ,assign)float contentBGHeight;
@property (nonatomic ,assign)NSInteger num;

@end


@interface ProductDetailGoodsSkuVosModel: THBaseModel

@property (nonatomic , copy)NSString *skuImgUrl;
@property (nonatomic , copy)NSString *skuName;
@property (nonatomic , copy)NSString *skuValues;

@end

@interface ProductDetailGoodsSkuAttrValueModel: THBaseModel

@property (nonatomic , copy)NSString *attrValueName;
@property (nonatomic , copy)NSString *attrValueId;

@end
NS_ASSUME_NONNULL_END

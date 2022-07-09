//
//  HomeDataModel.h
//  SmallB
//
//  Created by zhang on 2022/5/6.
//

#import "THBaseModel.h"
#import "HomeDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeDataModel : THBaseModel

@property (nonatomic , strong)NSMutableArray *bannerListVos;
@property (nonatomic , strong)NSMutableArray *blockDefineGoodsVos;
@property (nonatomic , strong)NSMutableArray *blockDefineVos;
@property (nonatomic , strong)NSMutableArray *goodsCategoryListVos;

@end

@interface BannerListVosModel : THBaseModel

@property (nonatomic , copy)NSString *ossImgPath;
@property (nonatomic , copy)NSString *ossImgName;
@property (nonatomic , copy)NSString *linkId;
@property (nonatomic , copy)NSString *bannerName;
@property (nonatomic , copy)NSString *linkType;

@end

@interface BlockDefineGoodsVosModel : THBaseModel

@property (nonatomic , copy)NSString *blockId;
@property (nonatomic , copy)NSString *blockName;
@property (nonatomic , strong)NSMutableArray *goodsListVos;
@property (nonatomic , strong)NSMutableArray *brandConceptVos;

@end

@interface GoodsListVosModel : THBaseModel

@property (nonatomic , copy)NSString *commission;//佣金
@property (nonatomic , copy)NSString *feeRate;//佣金比例
@property (nonatomic , copy)NSString *goodsId;
@property (nonatomic , copy)NSString *goodsName;
@property (nonatomic , copy)NSString *goodsThumb;//商品缩略图
@property (nonatomic , copy)NSString *marketPrice;//删除价格
@property (nonatomic , copy)NSString *saleCount;//已售数量/今日热销数量
@property (nonatomic , copy)NSString *salePrice;//实际价格

@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat firstHeight;

@property (copy, nonatomic) NSString *browseId;

@property (assign, nonatomic)BOOL isSelect;
@property (assign, nonatomic)BOOL isFirst;

@property (nonatomic , copy)NSString *ifOnSale;
@property (nonatomic , copy)NSString *stockQuantity;
@property (nonatomic , copy)NSString *shopGoodsId;

@property (nonatomic , copy)NSString *supplierId;

@end

@interface BlockDefineVosModel : THBaseModel

@property (nonatomic , copy)NSString *blockId;
@property (nonatomic , copy)NSString *blockName;
@property (nonatomic , copy)NSString *logoImgName;
@property (nonatomic , copy)NSString *logoImgPath;

@end

@interface GoodsCategoryListVosModel : THBaseModel

@property (nonatomic , copy)NSMutableArray *bannerUrls;
@property (nonatomic , copy)NSString *categoryId;
@property (nonatomic , copy)NSString *categoryLevel;
@property (nonatomic , copy)NSString *categoryName;
@property (nonatomic , copy)NSString *categoryThumb;
@property (nonatomic , strong)NSMutableArray *listVos;

@end

@interface HomeListVosModel : THBaseModel

@property (nonatomic , strong)NSMutableArray *bannerUrls;
@property (nonatomic , copy)NSString *categoryId;
@property (nonatomic , copy)NSString *categoryLevel;
@property (nonatomic , copy)NSString *categoryName;
@property (nonatomic , copy)NSString *categoryThumb;
@property (nonatomic , strong)NSMutableArray *listVos;

@end

@interface BrandConceptVosModel : THBaseModel
 
@property (nonatomic , strong)NSMutableArray *goodsListVos;
@property (nonatomic , copy)NSString *supplyId;
@property (nonatomic , copy)NSString *supplyName;
@property (nonatomic , copy)NSString *logoImgUrl;
@property (nonatomic , copy)NSString *goodsCount;

@end

NS_ASSUME_NONNULL_END

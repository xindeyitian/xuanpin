//
//  StoreCollectionModel.h
//  SmallB
//
//  Created by zhang on 2022/5/13.
//

#import "THBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreCollectionModel : THBaseModel

@property(nonatomic , strong)NSMutableArray *records;

@end

@interface StoreCollectionRecordsModel : THBaseModel

@property(nonatomic , strong)NSMutableArray *goodsListVos;
@property(nonatomic , copy)NSString *collectId;
@property(nonatomic , copy)NSString *supplyId;
@property(nonatomic , copy)NSString *supplyName;
@property(nonatomic , copy)NSString *logoImgUrl;
@property(nonatomic , copy)NSString *productNum;
@property(nonatomic , assign)BOOL isSelect;

@end

NS_ASSUME_NONNULL_END

//
//  BuyTuanModel.h
//  SmallB
//
//  Created by zhang on 2022/5/13.
//

#import "THBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BuyTuanModel : THBaseModel

@property (nonatomic ,copy)NSString *ossImgPath;
@property (nonatomic ,copy)NSString *salePrice;
@property (nonatomic ,copy)NSString *ossImgName;
@property (nonatomic ,copy)NSString *effectiveDays;
@property (nonatomic ,copy)NSString *typId;
@property (nonatomic ,copy)NSString *codeTypeName;

@end

NS_ASSUME_NONNULL_END

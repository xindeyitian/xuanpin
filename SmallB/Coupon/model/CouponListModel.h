//
//  CouponListModel.h
//  SmallB
//
//  Created by zhang on 2022/5/11.
//

#import "THBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CouponListModel : THBaseModel

@property (nonatomic , copy)NSString *typeId;
@property (nonatomic , copy)NSString *typeName;
@property (nonatomic , copy)NSString *moneyCouponSub;
@property (nonatomic , strong)NSMutableArray *couponListVos;

@end

@interface CouponListVosModel : THBaseModel

@property (nonatomic , copy)NSString *couponId;
@property (nonatomic , copy)NSString *typeId;
@property (nonatomic , copy)NSString *typeName;
@property (nonatomic , copy)NSString *moneyCouponSub;

@end

NS_ASSUME_NONNULL_END

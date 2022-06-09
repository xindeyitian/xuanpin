//
//  ReceiveCouponModel.h
//  SmallB
//
//  Created by zhang on 2022/5/5.
//

#import "THBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReceiveCouponModel : THBaseModel

@property (nonatomic , strong)NSArray *result;

@end

@interface ReceiveCouponDataModel : THBaseModel

@property (nonatomic , copy)NSString *typeId;
@property (nonatomic , copy)NSString *typeName;
@property (nonatomic , copy)NSString *moneyCouponSub;

@end

NS_ASSUME_NONNULL_END

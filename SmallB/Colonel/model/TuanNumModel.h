//
//  TuanNumModel.h
//  SmallB
//
//  Created by zhang on 2022/5/11.
//

#import "THBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuanNumModel : THBaseModel

@property (nonatomic ,copy)NSString *isUsedCount;
@property (nonatomic ,copy)NSString *isNotUsedCount;
@property (nonatomic ,copy)NSString *totalCount;

@end

NS_ASSUME_NONNULL_END

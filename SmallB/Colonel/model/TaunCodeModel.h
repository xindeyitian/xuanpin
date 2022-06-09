//
//  TaunCodeModel.h
//  SmallB
//
//  Created by zhang on 2022/5/14.
//

#import "THBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaunCodeModel : THBaseModel

@property (nonatomic ,strong)NSMutableArray *records;

@end

@interface TaunCodeDataModel : THBaseModel

@property (nonatomic ,copy)NSString *expireTime;
@property (nonatomic ,copy)NSString *cancelUkey;
@property (nonatomic ,copy)NSString *deleteSign;
@property (nonatomic ,copy)NSString *codeNum;
@property (nonatomic ,copy)NSString *ifUsed;
@property (nonatomic ,copy)NSString *typeId;
@property (nonatomic ,copy)NSString *djlsh;
@property (nonatomic ,copy)NSString *buyTime;
@property (nonatomic ,copy)NSString *userId;
@property (nonatomic ,copy)NSString *createTime;
@property (nonatomic ,copy)NSString *ifSold;
@property (nonatomic ,copy)NSString *beginTime;
@property (nonatomic ,copy)NSString *updateTime;

@end

NS_ASSUME_NONNULL_END

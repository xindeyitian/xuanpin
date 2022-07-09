//
//  MyOrderLogisticsDataModel.h
//  SmallB
//
//  Created by zhang on 2022/7/7.
//

#import <Foundation/Foundation.h>
#import "OrderLogistCompanyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyOrderLogisticsDataModel : NSObject

@property (nonatomic , copy)NSString *compantName;
@property (nonatomic , strong)OrderLogistCompanyModel *companyModel;
@property (nonatomic , copy)NSString *logistNO;
@property (nonatomic , copy)NSMutableArray *productList;

@end

NS_ASSUME_NONNULL_END

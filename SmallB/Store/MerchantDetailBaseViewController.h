//
//  MerchantDetailBaseViewController.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/11.
//

#import "BaseCollectionAndTableViewVC.h"
#import "ProductDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MerchantDetailBaseViewController : BaseCollectionAndTableViewVC

//@property (nonatomic , strong)ProductDetailModel *model;
@property (nonatomic , copy)NSString *supplierID;
@property (nonatomic , strong)void(^collectionOperationBlock)(BOOL isCollection);

@end

NS_ASSUME_NONNULL_END

//
//  MerchantDetailView.h
//  SmallB
//
//  Created by zhang on 2022/4/28.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MerchantDetailView : UIView

@property (nonatomic , assign)BOOL havSearchNav;
@property (nonatomic , strong)StoreModel *storeModel;
@property (nonatomic , strong)void(^searchBlock)(NSString *searchStr);
@property (nonatomic , strong)void(^collectionOperationBlock)(BOOL isCollection);

@end

NS_ASSUME_NONNULL_END

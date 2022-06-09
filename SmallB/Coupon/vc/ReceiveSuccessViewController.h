//
//  ReceiveSuccessViewController.h
//  SmallB
//
//  Created by zhang on 2022/5/5.
//

#import "THBaseTableViewController.h"
#import "ReceiveCouponModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReceiveSuccessViewController : THBaseTableViewController

@property (nonatomic , copy)NSString *token;

@end

@interface couponInfoImgV : UIImageView

@property(nonatomic , strong)UILabel *titleL;
@property(nonatomic , strong)UILabel *priceL;
@property(nonatomic , strong)NSString *priceStr;
@property(nonatomic , strong)ReceiveCouponDataModel *dataModel;

@end

NS_ASSUME_NONNULL_END

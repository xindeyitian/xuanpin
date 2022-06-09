//
//  ReceiveCouponViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/21.
//

#import "THBaseTableViewController.h"
#import "ReceiveCouponModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReceiveCouponViewController : THBaseTableViewController

@property (nonatomic , copy)NSString *token;
@property(nonatomic , strong)NSMutableArray *couponAry;
@property (nonatomic , copy)NSString *contentString;
@property (nonatomic , copy)NSString *titleString;
@property (nonatomic , strong)void(^viewBlock)(void);

@end

@interface CouponImageView : UIImageView

@property(nonatomic , strong)UILabel *titleL;
@property(nonatomic , strong)UILabel *priceL;
@property(nonatomic , strong)NSString *priceStr;

@end

NS_ASSUME_NONNULL_END

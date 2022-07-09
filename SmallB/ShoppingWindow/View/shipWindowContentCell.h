//
//  shipWindowContentCell.h
//  SmallB
//
//  Created by zhang on 2022/4/9.
//

#import "ThBaseTableViewCell.h"
#import "shopWindowContentVC.h"
#import "HomeDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface shipWindowContentCell : ThBaseTableViewCell

@property(nonatomic , assign)windowProductType statusType;

@property(nonatomic , copy)NSString *statusString;

@property(nonatomic , strong)UILabel *productTitleL;

@property (nonatomic ,assign)NSInteger shopType;
@property (nonatomic ,assign)NSInteger index;

@property(nonatomic , strong)GoodsListVosModel *model;
@property(nonatomic , strong)void(^viewBlock)(void);
@property(nonatomic , strong)void(^deleteViewBlock)(void);

@end

NS_ASSUME_NONNULL_END

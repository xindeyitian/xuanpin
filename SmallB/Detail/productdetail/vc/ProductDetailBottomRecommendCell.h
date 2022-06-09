//
//  ProductDetailRecommendCell.h
//  SmallB
//
//  Created by zhang on 2022/5/24.
//

#import "ThBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailBottomRecommendCell : ThBaseTableViewCell

@property (nonatomic , strong)NSMutableArray *dataAry;
@property (nonatomic , strong)void(^heightBlock)(float height);

@end

NS_ASSUME_NONNULL_END

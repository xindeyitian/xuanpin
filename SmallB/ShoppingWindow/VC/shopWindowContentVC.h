//
//  shopWindowContentVC.h
//  SmallB
//
//  Created by zhang on 2022/4/9.
//

#import "THBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, windowProductType) {
    windowProductTypeCloudSold = 0,//销售中
    windowProductTypeCloudYiXiajia,//已下架

    windowProductTypeMineSold,//销售中
    windowProductTypeMineShenhe,//审核中
    windowProductTypeMineYiXiajia,//已下架
};

@interface shopWindowContentVC : THBaseTableViewController<JXCategoryListContentViewDelegate>

@property (nonatomic ,copy)NSString *searchStr;
@property (nonatomic ,assign)NSInteger shopType;
@property (nonatomic ,assign)NSInteger index;

@property (nonatomic ,assign)windowProductType cellShowType;

@end

NS_ASSUME_NONNULL_END

//
//  TuanCodeContentViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/18.
//

#import "THBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuanCodeContentViewController : THBaseTableViewController<JXCategoryListContentViewDelegate>

@property (nonatomic ,assign)NSInteger index;
@property (nonatomic ,copy)NSString *searchStr;
@property (nonatomic , strong)void(^noDataBlock)(BOOL noData);

@end

NS_ASSUME_NONNULL_END

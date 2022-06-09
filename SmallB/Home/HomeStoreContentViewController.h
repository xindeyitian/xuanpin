//
//  HomeStoreContentViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/28.
//

#import "THBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeStoreContentViewController : THBaseTableViewController<JXCategoryListContentViewDelegate>

@property (nonatomic , copy)NSString *searchStr;
@property (nonatomic , copy)NSString *blockId;

@end

NS_ASSUME_NONNULL_END

//
//  MingXiContentViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/25.
//

#import "THBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MingXiContentViewController : THBaseTableViewController<JXCategoryListContentViewDelegate>

@property(nonatomic , assign)NSInteger typeIndex;
@property(nonatomic , copy)NSString *startTime;
@property(nonatomic , copy)NSString *endTime;
@property(nonatomic , assign)BOOL needReload;

@end

NS_ASSUME_NONNULL_END

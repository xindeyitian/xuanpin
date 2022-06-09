//
//  MessageContentViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/24.
//

#import "THBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageContentViewController : THBaseTableViewController<JXCategoryListContentViewDelegate>

@property(nonatomic , assign)NSInteger index;

@end

NS_ASSUME_NONNULL_END

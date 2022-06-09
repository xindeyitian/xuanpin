//
//  myVCStoreAttentionCell.h
//  SmallB
//
//  Created by zhang on 2022/4/8.
//

#import "THBaseCommentTableViewCell.h"
#import "StoreCollectionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface myVCStoreAttentionCell : THBaseCommentTableViewCell

@property (nonatomic , assign)BOOL isManager;
@property (nonatomic , strong)StoreCollectionRecordsModel *model;
@property (nonatomic , strong)void(^updateBlock)(void);

@end

NS_ASSUME_NONNULL_END

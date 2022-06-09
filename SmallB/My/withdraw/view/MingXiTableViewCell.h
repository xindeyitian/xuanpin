//
//  MingXiTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/25.
//

#import "THBaseCommentTableViewCell.h"
#import "MingXiRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MingXiTableViewCell : THBaseCommentTableViewCell

@property(nonatomic , strong)MingXiRecordListModel *model;

@end

NS_ASSUME_NONNULL_END

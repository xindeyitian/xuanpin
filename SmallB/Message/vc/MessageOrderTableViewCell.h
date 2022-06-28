//
//  MessageOrderTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/24.
//

#import "THBaseCommentTableViewCell.h"
#import "MagicBoxMessageListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageOrderTableViewCell : THBaseCommentTableViewCell

@property (nonatomic , strong)MagicBoxMessageListModel *model;

@end

NS_ASSUME_NONNULL_END

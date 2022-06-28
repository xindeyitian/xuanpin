//
//  MessageDetailTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/24.
//

#import "THBaseCommentTableViewCell.h"
#import "MagicBoxMessageListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageDetailTableViewCell : THBaseCommentTableViewCell

@property (nonatomic , strong)MagicBoxMessageListModel *model;
@property (nonatomic , strong)UILabel *titleL;
@property (nonatomic , strong)UILabel *timeL;
@property (nonatomic , strong)UILabel*contentL;

@end

NS_ASSUME_NONNULL_END

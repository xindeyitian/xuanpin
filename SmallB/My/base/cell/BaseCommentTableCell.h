//
//  BaseCommentTableCell.h
//  SmallB
//
//  Created by zhang on 2022/4/12.
//

#import "THBaseCommentTableViewCell.h"
#import "orderDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseCommentTableCell : THBaseCommentTableViewCell

@property(nonatomic , strong)UILabel *leftL;
@property(nonatomic , strong)UILabel *rightL;

@end

@interface BaseCommentRightTableCell : BaseCommentTableCell

@property(nonatomic , strong)UIImageView *rightImgV;

@end

NS_ASSUME_NONNULL_END

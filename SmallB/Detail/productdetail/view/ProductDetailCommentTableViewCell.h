//
//  ProductDetailCommentTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/24.
//

#import "THBaseCommentTableViewCell.h"
#import "ProductDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailCommentTableViewCell : THBaseCommentTableViewCell

@property (nonatomic ,strong)commentRecordModel *model;

@end

NS_ASSUME_NONNULL_END

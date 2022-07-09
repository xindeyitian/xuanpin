//
//  myOrderDetailProductTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/12.
//

#import "THBaseCommentTableViewCell.h"
#import "orderDataModel.h"
#import "OrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface myOrderDetailProductTableViewCell : THBaseCommentTableViewCell

@property(nonatomic , strong)UILabel *productTitleL;
@property(nonatomic , strong)OrderListProductModel *model;
@property (nonatomic ,assign)NSInteger type;

@end

@interface myOrderDetailCommentTableViewCell : THBaseCommentTableViewCell

@property(nonatomic , strong)orderDataModel *dataModel;

@end

@interface myOrderDetailChatTableViewCell : THBaseCommentTableViewCell

@end

@interface myOrderDetailShouhouTableViewCell : THBaseCommentTableViewCell

@property(nonatomic , strong)orderDataModel *dataModel;

@end

NS_ASSUME_NONNULL_END

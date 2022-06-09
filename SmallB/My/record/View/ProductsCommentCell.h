//
//  ProductsCommentCell.h
//  SmallB
//
//  Created by zhang on 2022/4/9.
//

#import "THBaseCommentTableViewCell.h"
#import "HomeDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProductsCommentCell : THBaseCommentTableViewCell

@property (nonatomic , assign)BOOL isManager;

@property (nonatomic , assign)BOOL showYongJin;

@property (nonatomic , strong)GoodsListVosModel *dataModel;

@property(nonatomic , strong)UIView *lineV;

@end

NS_ASSUME_NONNULL_END

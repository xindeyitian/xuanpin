//
//  HomeYouXuanTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/20.
//

#import "BaseTableViewCell.h"
#import "HomeDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeYouXuanTableViewCell : BaseTableViewCell

@property (nonatomic , strong)BlockDefineGoodsVosModel *model;

@end

@interface YouXuanProductView : UIView

@property (nonatomic , strong)GoodsListVosModel *goodModel;

@end

NS_ASSUME_NONNULL_END

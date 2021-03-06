//
//  myOrderDetailHeaderView.h
//  SmallB
//
//  Created by zhang on 2022/4/12.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface myOrderDetailHeaderView : UIView

@property(nonatomic , copy)NSString *addressStr;
@property(nonatomic , assign)BOOL showWuliu;
@property(nonatomic , assign)BOOL haveBtn;
@property (nonatomic , strong)OrderDetailModel *detailModel;

@end

NS_ASSUME_NONNULL_END

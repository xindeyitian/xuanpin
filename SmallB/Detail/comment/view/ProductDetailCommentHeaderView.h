//
//  ProductDetailCommentHeaderView.h
//  SmallB
//
//  Created by zhang on 2022/4/24.
//

#import <UIKit/UIKit.h>
#import "ProductDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailCommentHeaderView : UIView

@property (nonatomic , copy)NSString *productID;
@property (nonatomic , strong)ProductDetailModel *detailModel;

@end

@interface ProductDetailNoCommentHeaderView : UIView

@end

NS_ASSUME_NONNULL_END

//
//  ProductDetailBottomView.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/8.
//

#import "THBaseView.h"
#import "ProductDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailBottomView : THBaseView

@property (nonatomic , strong)ProductDetailModel *model;
@property (nonatomic , assign)BOOL hiddenBuy;

@end

NS_ASSUME_NONNULL_END

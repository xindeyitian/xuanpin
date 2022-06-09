//
//  ProductDetailViewController.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/8.
//

#import "THBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailViewController : THBaseViewController

@property (nonatomic , strong)NSString *productID;
@property (nonatomic , strong)NSString *categoryID;

@end

@interface ProductDetailTopSelectView : UIView

@property (nonatomic , strong)UIView *lineView;
@property (nonatomic , assign)NSInteger selectIndex;
@property (nonatomic , strong)void(^selectBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END

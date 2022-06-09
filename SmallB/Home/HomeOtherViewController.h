//
//  HomeOtherViewController.h
//  SmallB
//
//  Created by 张昊男 on 2022/4/6.
//

#import "THBaseViewController.h"
@class HomeDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface HomeOtherViewController : THBaseViewController<JXCategoryListContentViewDelegate>

@property (nonatomic , strong)HomeDataModel *dataModel;
@property (nonatomic , assign)NSInteger index;

@end

NS_ASSUME_NONNULL_END

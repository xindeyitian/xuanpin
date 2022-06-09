//
//  HomeViewController.h
//  LLWFan
//
//  Created by 张昊男 on 2022/3/22.
//

#import "THBaseViewController.h"
@class HomeDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : THBaseViewController<JXCategoryListContentViewDelegate>

@property (nonatomic , strong)void(^requestDataBlock)(HomeDataModel *model);

@property (nonatomic , strong)HomeDataModel *dataModel;

@end

NS_ASSUME_NONNULL_END

//
//  HomeCollectionReusableHeaderView.h
//  SmallB
//
//  Created by zhang on 2022/4/29.
//

#import <UIKit/UIKit.h>
#import "HomeTopView.h"
#import "BaseTopSelectView.h"
#import "HomeDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeCollectionReusableHeaderView : UICollectionReusableView

@property (strong, nonatomic) HomeTopView *topView;
@property (strong, nonatomic) BaseTopSelectView *topUtilityView;
@property (strong, nonatomic) GoodsCategoryListVosModel *categoryModel;

@end

NS_ASSUME_NONNULL_END

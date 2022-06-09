//
//  HomeTopView.h
//  SmallB
//
//  Created by 张昊男 on 2022/4/1.
//

#import "THBaseView.h"
#import "HomeDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeTopView : UICollectionReusableView

@property (strong, nonatomic) MyLinearLayout *rootLy;

@property (strong, nonatomic) GoodsCategoryListVosModel *categoryModel;

-(void)setOthers;

@end

NS_ASSUME_NONNULL_END

//
//  HomeCollectionViewCell.h
//  SmallB
//
//  Created by 张昊男 on 2022/4/6.
//

#import <UIKit/UIKit.h>
#import "HomeDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeCollectionViewCell : UICollectionViewCell

@property (nonatomic , strong)GoodsListVosModel *model;
@property (strong, nonatomic) MyLinearLayout *rootLy;

@end

NS_ASSUME_NONNULL_END

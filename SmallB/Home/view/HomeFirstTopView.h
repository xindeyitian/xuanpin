//
//  HomeFirstTopView.h
//  SmallB
//
//  Created by zhang on 2022/4/22.
//

#import "THBaseView.h"
#import "HomeDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeFirstTopView : THBaseView

@property (strong, nonatomic) MyLinearLayout *rootLy;

@property (strong, nonatomic) HomeDataModel *dataModel;

-(void)setOthers;

@end

NS_ASSUME_NONNULL_END

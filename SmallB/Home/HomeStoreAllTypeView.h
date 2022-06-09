//
//  HomeStoreAllTypeView.h
//  SmallB
//
//  Created by zhang on 2022/4/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeStoreAllTypeView : UIView

@property (nonatomic ,strong)NSMutableArray *titleAry;

@property (nonatomic ,assign)NSInteger index;
@property (nonatomic ,copy)NSString *typeStr;
@property (nonatomic ,strong)void(^btnClickBlock)(NSInteger index,NSString *typeStr);

@end

NS_ASSUME_NONNULL_END

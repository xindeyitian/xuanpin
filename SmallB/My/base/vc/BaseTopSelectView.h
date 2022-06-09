//
//  BaseTopSelectView.h
//  SmallB
//
//  Created by zhang on 2022/4/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTopSelectView : UIView

@property (nonatomic ,strong)void(^itemClickBlcok)(NSInteger index,BOOL isDescending);//是否降序
@property (nonatomic ,strong)void(^typeClickBlcok)(BOOL isSelected);//是否降序

@property (nonatomic , assign)BOOL hiddenAllBtn;
/**
 默认 @"综合", @"销量", @"积分", @"价格"
 */
@property (nonatomic, strong) NSMutableArray<NSString *> *currentTitles;//

@end

NS_ASSUME_NONNULL_END

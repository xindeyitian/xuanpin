//
//  withdrawShaixuanView.h
//  SmallB
//
//  Created by zhang on 2022/4/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface withdrawShaixuanView : UIView

@property (nonatomic , assign)BOOL hiddenStatus;
@property (nonatomic , strong)UIView *bgView;

@property (nonatomic , strong)NSString *selectStartDate;
@property (nonatomic , strong)NSString *selectEndDate;

@property (nonatomic , strong)NSDate *startDate;
@property (nonatomic , strong)NSDate *endDate;

- (void)show;

- (void)dismiss;

/**
 startTime 开始时间
 endTime 结束时间
 type  类型
 */
@property(nonatomic,strong)void(^confirmBlock)(NSString *startTime,NSString *endTime,NSString *type);
@property(nonatomic,strong)void(^cancelBlock)(void);

@end

@interface shaixuanBtn : UIButton

@end

@interface withdrawTimeShaixuanView : UIView

@end

NS_ASSUME_NONNULL_END

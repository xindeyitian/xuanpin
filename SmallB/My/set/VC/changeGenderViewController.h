//
//  changeGenderViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import "BaseAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface changeGenderViewController : BaseAlertViewController

@property (nonatomic , copy)NSString *sex;
@property(nonatomic,strong)void(^selectOperationBlock)(NSInteger index);

@end


@interface genderView : UIView

@property (nonatomic , strong)UIView *BGView;
@property (nonatomic , strong)UIImageView *icon;
@property (nonatomic , strong)UILabel *titleL;

@property(nonatomic,strong)void(^viewClickBlock)(void);

@end

NS_ASSUME_NONNULL_END

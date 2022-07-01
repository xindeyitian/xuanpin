//
//  BaseShareAlertViewController.h
//  SmallB
//
//  Created by zhang on 2022/6/16.
//

#import "BaseAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseShareAlertViewController : BaseAlertViewController

@property (nonatomic , strong)UIView *BGWhiteV;

@property (nonatomic , copy)NSString *titleS;
@property (nonatomic , copy)NSString *descriptionS;
@property (nonatomic , copy)NSString *webpageUrlS;

- (void)creatSubViews;

@end

NS_ASSUME_NONNULL_END

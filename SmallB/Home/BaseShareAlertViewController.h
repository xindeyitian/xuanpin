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
@property (nonatomic , copy)NSString *thumbImg;
@property (nonatomic , copy)NSString *path;
@property (nonatomic , assign)BOOL inventStore;

- (void)creatSubViews;

- (void)shareBtnClick:(UIControl *)contro;

@end

NS_ASSUME_NONNULL_END

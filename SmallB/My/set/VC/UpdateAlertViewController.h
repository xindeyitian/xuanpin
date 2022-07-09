//
//  UpdateAlertViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/26.
//

#import "BaseAlertViewController.h"
#import "VersionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UpdateAlertViewController : BaseAlertViewController

@property (nonatomic , strong)VersionModel *model;

@end

NS_ASSUME_NONNULL_END

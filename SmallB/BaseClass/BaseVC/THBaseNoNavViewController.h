//
//  THBaseNoNavViewController.h
//  SeaEgret
//
//  Created by MAC on 2021/3/22.
//

#import "THBaseViewController.h"
@class BaseSearchNavBarView;
NS_ASSUME_NONNULL_BEGIN

@interface THBaseNoNavViewController : THBaseViewController

@property (strong, nonatomic) BaseSearchNavBarView *nav;
@property (strong, nonatomic) NSArray *btnAry;
@property (assign, nonatomic) BOOL fieldEnabled;

@end

NS_ASSUME_NONNULL_END

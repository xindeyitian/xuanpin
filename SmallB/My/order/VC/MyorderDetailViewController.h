//
//  MyorderDetailViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/12.
//

#import "THBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyorderDetailViewController : THBaseTableViewController

@property (nonatomic , assign)BOOL isShouHou;
@property (nonatomic , copy)NSString *orderID;
@property (nonatomic ,assign)NSInteger type;

@end

NS_ASSUME_NONNULL_END

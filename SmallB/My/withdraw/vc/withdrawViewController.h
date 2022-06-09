//
//  withdrawViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/12.
//

#import "THBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface withdrawViewController : THBaseTableViewController

@property (nonatomic , copy)NSString *moneyStr;
@property (nonatomic , assign)NSInteger index;

@end

@interface withdrawTypeView : UIView

@property (nonatomic , strong)UIImageView *iconImgV;
@property (nonatomic , strong)UILabel *typeL;
@property (nonatomic , strong)UIView *lineView;
@property (nonatomic , assign)BOOL selected;
@property (nonatomic , strong)UIImageView *rightImgV;

@property (nonatomic , strong)BaseButton *bindingBtn;
@property (nonatomic , copy)NSString *rightImgVName;

@property(nonatomic,strong)void(^viewClickBlock)(void);

@end

NS_ASSUME_NONNULL_END

//
//  BaseOwnerNavView.h
//  SmallB
//
//  Created by zhang on 2022/4/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseOwnerNavView : UIImageView

@property (nonatomic , strong)UILabel *titleL;
@property (nonatomic , strong)BaseButton *backBtn;
@property (nonatomic , strong)void(^backOperation)(void);

@end

NS_ASSUME_NONNULL_END

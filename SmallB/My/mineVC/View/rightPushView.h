//
//  rightPushView.h
//  SmallB
//
//  Created by zhang on 2022/4/8.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface rightPushView : THBaseView

@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,copy)NSString *imageNameString;
@property(nonatomic,assign)float imageHeight;

@property(nonatomic,strong)void(^viewClickBlock)(void);

@end

NS_ASSUME_NONNULL_END

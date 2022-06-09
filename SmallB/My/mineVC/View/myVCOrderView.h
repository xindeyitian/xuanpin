//
//  myVCOrderBtn.h
//  SmallB
//
//  Created by zhang on 2022/4/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface myVCOrderView : THBaseView

@property(nonatomic , assign) BOOL hiddenRedView;

@property(nonatomic,copy)NSString *titleString;
@property(nonatomic,copy)NSString *imageNameString;

@property(nonatomic,assign)float imageHeight;

@property(nonatomic,strong)void(^viewClickBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END

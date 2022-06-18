//
//  BaseSearchView.h
//  SmallB
//
//  Created by zhang on 2022/4/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseSearchView : UIView

@property (strong, nonatomic) UITextField *searchField;
@property (strong, nonatomic)UIImageView *leftSearchImgv;

@property(nonatomic,strong)void(^viewClickBlock)(NSInteger index,NSString *searchStr);

@property (nonatomic, assign)BOOL fieldEnabled;
@property (strong, nonatomic) UIButton *searchBtn;
@property (nonatomic, assign)BOOL showBackBtn;

@end

NS_ASSUME_NONNULL_END

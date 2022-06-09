//
//  BaseSearchNavBarView.h
//  SmallB
//
//  Created by zhang on 2022/4/22.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseSearchNavBarView : THBaseView

@property (strong, nonatomic) UITextField *searchField;
@property (nonatomic, assign)BOOL hiddenBackBtn;
@property (strong, nonatomic) NSArray *btnAry;
@property (strong, nonatomic) UIImageView *searchImgV;
@property (strong, nonatomic) UIView *searchView;
@property (strong, nonatomic) UIButton *searchBtn;
@property (strong, nonatomic) UIButton *backBtn;

@property(nonatomic,strong)void(^viewClickBlock)(NSInteger index,NSString *searchStr);

@property (assign, nonatomic) BOOL fieldEnabled;

@end

NS_ASSUME_NONNULL_END

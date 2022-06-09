//
//  CouponChooseCell.h
//  SmallB
//
//  Created by zhang on 2022/4/21.
//

#import "THBaseCommentTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CouponChooseCell : THBaseCommentTableViewCell

@property(nonatomic ,strong)UILabel *titleL;
@property(nonatomic ,strong)UILabel *subTitleL;
@property(nonatomic ,strong)UILabel *contentTitleL;
@property(nonatomic ,strong)UIImageView *rightImgV;
@property(nonatomic ,strong)UIImageView *iconImgV;
@property(nonatomic ,assign)BOOL isSelect;

@end

NS_ASSUME_NONNULL_END

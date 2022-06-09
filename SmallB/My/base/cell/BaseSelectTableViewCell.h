//
//  BaseSelectTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/16.
//

#import "THBaseCommentTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseSelectTableViewCell : THBaseCommentTableViewCell

@property(nonatomic,strong)UIImageView *leftImgV;
@property(nonatomic,strong)UIImageView *rightImgV;
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *subTitleL;

@property(nonatomic,assign)BOOL hiddenLeft;

@end

NS_ASSUME_NONNULL_END

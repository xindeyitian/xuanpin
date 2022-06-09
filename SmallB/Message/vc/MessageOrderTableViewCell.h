//
//  MessageOrderTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/24.
//

#import "THBaseCommentTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageOrderTableViewCell : THBaseCommentTableViewCell

@property (nonatomic , strong)UIImageView *imgV;
@property (nonatomic , strong)UILabel *titleL;
@property (nonatomic , strong)UILabel*contentL;
@property (nonatomic , strong)UILabel*timeL;
@property (nonatomic , strong)UIView*redView;

@end

NS_ASSUME_NONNULL_END

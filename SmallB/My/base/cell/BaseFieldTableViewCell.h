//
//  BaseFieldTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/13.
//

#import "THBaseCommentTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseFieldTableViewCell : THBaseCommentTableViewCell

@property(nonatomic , assign)NSInteger maxNum;
@property(nonatomic , strong)UITextField *fieldT;
@property(nonatomic , strong)UIImageView *rightImgV;
@property(nonatomic , assign)BOOL havRightImgV;
@property (nonatomic , strong)void(^viewBlock)(NSString *content);

@end

NS_ASSUME_NONNULL_END

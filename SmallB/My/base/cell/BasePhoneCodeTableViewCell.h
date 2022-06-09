//
//  BasePhoneCodeTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/15.
//

#import "THBaseCommentTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BasePhoneCodeTableViewCell : THBaseCommentTableViewCell

@property(nonatomic , copy)NSString *phoneType;
@property(nonatomic , copy)NSString *phone;
@property(nonatomic , strong)UITextField *fieldT;
@property(nonatomic , strong)UIView *BGView;
@property (nonatomic , strong)void(^viewBlock)(NSString *content);

@end

NS_ASSUME_NONNULL_END

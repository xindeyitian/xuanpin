//
//  BaseCommonPhoneCell.h
//  SmallB
//
//  Created by zhang on 2022/6/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseCommonPhoneCell : UITableViewCell

@property(nonatomic , strong)UITextField *fieldT;
@property(nonatomic , strong)UIView *BGView;
@property (nonatomic , strong)void(^viewBlock)(NSString *content);

@end

NS_ASSUME_NONNULL_END

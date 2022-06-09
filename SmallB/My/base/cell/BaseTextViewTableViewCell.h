//
//  BaseTextViewTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/15.
//

#import "THBaseCommentTableViewCell.h"
#import "GCPlaceholderTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTextViewTableViewCell : THBaseCommentTableViewCell

@property(nonatomic , strong)GCPlaceholderTextView *textV;
@property  (nonatomic , strong)UILabel *numL;
@property (nonatomic , strong)void(^viewBlock)(NSString *content);

@end

NS_ASSUME_NONNULL_END

//
//  THBaseCommentTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import "ThBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface THBaseCommentTableViewCell : ThBaseTableViewCell

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *separatorLineView;
/**
 内容父视图内容缩进
 */
@property (nonatomic, assign) UIEdgeInsets bgViewContentInset;

/**
 是否默认切圆角
 */
@property (nonatomic, assign, getter=isAutoCorner) BOOL autoCorner;
/**
 圆角位置
 */
@property (nonatomic, assign) UIRectCorner roundCorners;
/**
 圆角半径, 默认10.f
 */
@property (nonatomic, copy) NSNumber *cornerRadii;

/**
 设置默认圆角
 第一行上圆角,最后一行下圆角
 autoCorner为YES时生效

 @param tableView tableView
 @param indexPath indexPath
 */
- (void)defualtCornerInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

- (void)k_creatSubViews;

@end

NS_ASSUME_NONNULL_END

//
//  mySetTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import "THBaseCommentTableViewCell.h"
#import "mySetDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface mySetTableViewCell : THBaseCommentTableViewCell

@property (nonatomic , strong)mySetDataModel *model;
@property (nonatomic , strong)UILabel *contentL;

@end

@interface mySetTableHeaderView : UIView

@property(nonatomic , strong)void(^selectImageBlock)(UIImage *image);
@property(nonatomic , strong)void(^uploadImageBlock)(NSString *url);
@property (nonatomic , strong)UIImageView *userLogo;

@end



NS_ASSUME_NONNULL_END

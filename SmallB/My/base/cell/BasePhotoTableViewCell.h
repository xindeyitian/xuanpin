//
//  BasePhotoTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/13.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BasePhotoTableViewCell : BaseTableViewCell

@property (nonatomic , strong)UILabel *titleL;
@property (nonatomic , strong)UILabel *subTitleL;
@property (nonatomic , strong)NSMutableArray *photoAry;//多选的数组
@property (nonatomic , assign)NSInteger maxNum;
@property (nonatomic , strong)UIImage *yingyeImage;//单选的image

@property (nonatomic , strong)UIView *allPhotoView;
@property (nonatomic , strong)UIButton *addBtn;
@property (nonatomic , strong)UIButton *deleteButton;

@property(nonatomic,strong)void(^viewClickBlock)(BOOL isAdd,NSInteger index);
@end

@interface BaseOnePhotoTableViewCell : BaseTableViewCell

@property (nonatomic , strong)UILabel *titleL;
@property (nonatomic , strong)UILabel *subTitleL;;
@property (nonatomic , strong)UIImage *yingyeImage;//单选的image

@property (nonatomic , strong)UIButton *addBtn;
@property (nonatomic , strong)UIButton *deleteButton;

@property(nonatomic,strong)void(^viewClickBlock)(BOOL isAdd,NSInteger index);
@end

NS_ASSUME_NONNULL_END

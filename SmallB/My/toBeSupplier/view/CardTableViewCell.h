//
//  CardTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/13.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardTableViewCell : BaseTableViewCell

@property (nonatomic , assign)BOOL isEdit;//是否是编辑状态
@property(nonatomic,strong)UIImage *shouchiImage;
@property(nonatomic,strong)UIImage *zhengImage;
@property(nonatomic,strong)UIImage *fanImage;
@property(nonatomic,strong)NSMutableArray *imageAry;
@property (nonatomic , strong)void(^viewBlock)(NSMutableArray *array);

@end

@interface CardImgView : UIImageView

@property (nonatomic , strong)UIButton *addBtn;

@end

NS_ASSUME_NONNULL_END

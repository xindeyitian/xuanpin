//
//  ShopInstroTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/15.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShopInstroTableViewCell : BaseTableViewCell

@property (nonatomic , strong)UIButton *addBtn;
@property (nonatomic , strong)UIButton *deleteB;
@property (nonatomic , copy)NSString *imageUrl;
@property (nonatomic , strong)UIImage *selectImage;
@property(nonatomic,strong)void(^selectImageBlock)(UIImage *image);

@end

NS_ASSUME_NONNULL_END

//
//  HomeRecommendTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/20.
//

#import "BaseTableViewCell.h"
#import "HomeDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeRecommendTableViewCell : BaseTableViewCell

@property (nonatomic , assign)BOOL haveBtn;
@property (nonatomic , strong)BlockDefineGoodsVosModel *model;

@end

@interface HomeRecommendStoreView : UIView

@property (nonatomic , strong)BrandConceptVosModel *goodModel;
@property (strong, nonatomic) UILabel    *titleL;
@property (strong, nonatomic) UILabel    *subtitleL;
@property (strong, nonatomic) UIButton    *attentionBtn;
@property (strong, nonatomic) UIButton    *pushBtn;
@property (strong, nonatomic) UIImageView    *logoImgV;
@property (nonatomic , assign)BOOL haveBtn;

@end

@interface StoreProductView : UIView

@property (nonatomic , strong)GoodsListVosModel *goodModel;
@property (nonatomic , assign)BOOL haveBtn;

@end

NS_ASSUME_NONNULL_END

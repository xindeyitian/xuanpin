//
//  RankListContentTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/7.
//

#import "THBaseCommentTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, contentCellType) {
    contentCellTypeRankList = 0,//榜单
    contentCellTypeProductCollection,//商品收藏
    contentCellTypeRecordList,//浏览记录
};

@interface RankListContentTableViewCell : THBaseCommentTableViewCell

@property (nonatomic ,assign)contentCellType cellType;
@property(nonatomic , strong)UIImageView *topImgV;
@property(nonatomic , strong)GoodsListVosModel *model;

@end

NS_ASSUME_NONNULL_END

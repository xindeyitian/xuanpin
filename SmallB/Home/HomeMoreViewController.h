//
//  HomeMoreViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/29.
//

#import "THBaseViewController.h"

typedef NS_ENUM(NSInteger, HomeMoreType) {
   
    HomeMoreType_Brand  = 0,//品牌产品
    HomeMoreType_GoodYouXuan,//好货优选
    HomeMoreType_JiuKuaiJiu,//9.9包邮
    HomeMoreType_Global,//全球嗨购
    HomeMoreType_Rank,//带货榜单
    //HomeMoreType_Recommend,//好货推荐
    HomeMoreType_XiaoLianYouXuan,//小莲优选
    //HomeMoreType_Category,//三级分类
};

NS_ASSUME_NONNULL_BEGIN

@interface HomeMoreViewController : THBaseViewController

@property (nonatomic , copy)NSString *blockId;
@property (nonatomic , assign)HomeMoreType homeMoreType;
@property (nonatomic , copy)NSString *titleStr;

@end

NS_ASSUME_NONNULL_END

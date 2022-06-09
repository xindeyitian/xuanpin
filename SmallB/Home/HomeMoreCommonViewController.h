//
//  HomeMoreCommonViewController.h
//  SmallB
//
//  Created by zhang on 2022/5/1.
//

#import "BaseCollectionAndTableViewVC.h"

typedef NS_ENUM(NSInteger, HomeMoreCommonType) {
   
    HomeMoreCommonType_Recommend,//好货推荐
    HomeMoreCommonType_Category,//三级分类
    HomeMoreCommonType_HomeCategory,//首页(其余类目下的)二级分类
    HomeMoreCommonType_SearchResult,//首页搜索结果
};
NS_ASSUME_NONNULL_BEGIN

@interface HomeMoreCommonViewController : BaseCollectionAndTableViewVC

@property (nonatomic , assign)HomeMoreCommonType homeMoreCommonType;
@property (nonatomic , copy)NSString *titleStr;
@property (nonatomic , copy)NSString *blockId;
@property (nonatomic , copy)NSString *categoryId;
@property (nonatomic , strong)NSString *searchStr;

@end

NS_ASSUME_NONNULL_END

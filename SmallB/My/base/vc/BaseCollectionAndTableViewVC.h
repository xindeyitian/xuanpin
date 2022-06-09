//
//  BaseCollectionAndTableViewVC.h
//  SmallB
//
//  Created by zhang on 2022/4/22.
//

#import "THBaseViewController.h"
#import "CJNoDataView.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionAndTableViewVC : THBaseViewController

@property (nonatomic, strong) BaseTopSelectView *topView;
@property (nonatomic, strong) UICollectionView *collectionView;

//UITableViewStyle
@property (nonatomic, assign) UITableViewStyle tableViewStyle;
//UItableView
@property (nonatomic, strong) UITableView * tableView;

//是否需要下拉刷新
@property (nonatomic, assign) BOOL needPullDownRefresh;
//是否需要上拉加载
@property (nonatomic, assign) BOOL needPullUpRefresh;
//是否需要下拉刷新
@property (nonatomic, assign) BOOL collectionNeedPullDownRefresh;
//是否需要上拉加载
@property (nonatomic, assign) BOOL collectionNeedPullUpRefresh;
//数据源
@property (nonatomic, strong) NSMutableArray * dataArray;
//没有网络
//@property (nonatomic, strong) CJImportNoNetworkView * noNetView;
//没有数据
@property (nonatomic, strong) CJNoDataView * emptyDataView;
//没有数据的图片名称
@property (nonatomic, copy) NSString * emptyImageName;
//没有数据的占位文字
@property (nonatomic, copy) NSString * emptyText;

/**
 下拉加载数据请求
 */
- (void)loadNewData;

/**
上拉加载数据请求
*/
- (void)loadMoreData;

@end

NS_ASSUME_NONNULL_END

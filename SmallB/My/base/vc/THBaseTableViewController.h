//
//  THBaseTableViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import "THBaseViewController.h"
#import "UIView+LYExtension.h"
#import "LYEmptyView.h"
#import "UIView+Empty.h"
#import "CJNoDataView.h"

NS_ASSUME_NONNULL_BEGIN

@interface THBaseTableViewController : THBaseViewController

//UITableViewStyle
@property (nonatomic, assign) UITableViewStyle tableViewStyle;
//UItableView
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) BaseButton *backBtn;
/**
 是否需要下拉刷新
 */
@property (nonatomic, assign) BOOL needPullDownRefresh;
/**
 是否需要上拉加载
 */
@property (nonatomic, assign) BOOL needPullUpRefresh;
//数据源
@property (nonatomic, strong) NSMutableArray * dataArray;
//没有网络
@property (nonatomic, strong) CJNoDataView * noNetView;
//没有数据
@property (nonatomic, strong) CJNoDataView * emptyDataView;
//没有数据的图片名称
@property (nonatomic, copy) NSString * emptyImageName;
//没有数据的占位文字
@property (nonatomic, copy) NSString * emptyText;

@property (nonatomic , strong)void (^backOperationBlock)(id data);
/**
 下拉加载数据请求
 */
- (void)loadNewData;

/**
上拉加载数据请求
*/
- (void)loadMoreData;

- (void)endRefresh;

@end

NS_ASSUME_NONNULL_END

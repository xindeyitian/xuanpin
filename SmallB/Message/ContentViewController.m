//
//  ContentViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/27.
//

#import "ContentViewController.h"
#import "myOrderListContentTableViewCell.h"
#import "MyorderDetailViewController.h"
#import "MyOrderListZiYingTableViewCell.h"
#import "OrderListModel.h"
#import "BaseSearchView.h"

@interface ContentViewController ()<JXCategoryViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , copy)NSString *typeStatus;
@property (nonatomic , assign)NSInteger page;
@end

@implementation ContentViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    
    BaseSearchView *searchV = [[BaseSearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    searchV.fieldEnabled = YES;
    searchV.viewClickBlock = ^(NSInteger index, NSString * _Nonnull searchStr) {
        NSLog(@"%@",searchStr);
    };
    searchV.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:searchV];
    [self.view bringSubviewToFront:searchV];
    searchV.hidden = !self.isShouhou;
    
    self.needPullUpRefresh = self.needPullDownRefresh = YES;
    [self.tableView registerClass:[myOrderListContentTableViewCell class] forCellReuseIdentifier:[myOrderListContentTableViewCell description]];
    [self.tableView registerClass:[MyOrderListZiYingTableViewCell class] forCellReuseIdentifier:[MyOrderListZiYingTableViewCell description]];
    self.page = 1;
    if (self.orderType == myOrderTypeWaitingAllOrder) {
        self.typeStatus = @"";
    }if (self.orderType == myOrderTypeWaitingPaid) {
        self.typeStatus = @"1";
    }if (self.orderType == myOrderTypeWaitingToBeDelivered) {
        self.typeStatus = @"2";
    }if (self.orderType == myOrderTypeWaitingPendingReceipt) {
        self.typeStatus = @"3";
    }if (self.orderType == myOrderTypeWaitingRefund) {
        self.typeStatus = @"9";
    }if (self.orderType == myOrderTypeWaitingComplete) {
        self.typeStatus = @"-1";
    }
    [self getOrderListData];
}

- (void)loadNewData{
    self.page = 1;
    [self getOrderListData];
}

- (void)loadMoreData{
    self.page ++;
    [self getOrderListData];
}

- (void)setOrderType:(myOrderType)orderType{
    _orderType = orderType;
}

- (void)getOrderListData{
    
    NSDictionary *dica;
    NSString *url = @"";
    if (!self.tableView.mj_header.isRefreshing && !self.tableView.mj_footer.isRefreshing) {
        [self startLoadingHUD];
    }
    if (!self.isShouhou) {
        dica = @{@"pageNum":[NSString stringWithFormat:@"%ld",(long)self.page],
                               @"pageSize":@"10",
                               @"orderType":[NSString stringWithFormat:@"%ld",(long)self.type-1],
                               @"orderState":self.typeStatus,
        };
        url = @"goods/orderInfo/goodsOrderPage";
        [THHttpManager GET:url parameters:dica block:^(NSInteger returnCode, THRequestStatus status, id data) {
            [self stopLoadingHUD];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
                OrderListModel *model = [OrderListModel mj_objectWithKeyValues:data];
                if (self.page == 1) {
                    [self.dataArray removeAllObjects];
                    [self.dataArray addObjectsFromArray:model.records];
                    self.emptyDataView.hidden = !(self.dataArray.count == 0);
                }else{
                    [self.dataArray addObjectsFromArray:model.records];
                    if (model.records.count == 0) {
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    }
                }
                [self.tableView reloadData];
            }
        }];
    }else{
        dica = @{@"current":[NSString stringWithFormat:@"%ld",(long)self.page],
                               @"size":@"10",
                               @"ifSelf":[NSString stringWithFormat:@"%ld",2-(long)self.type],
        };
        url = @"order/goodsBackApply/listPage";
        [THHttpManager POST:(NSString *)url parameters:dica dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
            [self stopLoadingHUD];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
                OrderListModel *model = [OrderListModel mj_objectWithKeyValues:data];
                if (self.page == 1) {
                    [self.dataArray removeAllObjects];
                    [self.dataArray addObjectsFromArray:model.records];
                    self.emptyDataView.hidden = !(self.dataArray.count == 0);
                }else{
                    [self.dataArray addObjectsFromArray:model.records];
                    if (model.records.count == 0) {
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    }
                }
                [self.tableView reloadData];
            }
        }];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.isShouhou) {
        self.tableView.frame = CGRectMake(0, 44, ScreenWidth, ScreenHeight - 44 - KNavBarHeight -12);
    }else{
        self.tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 42 - KNavBarHeight - 44 -12);
    }
}
#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count) {
        OrderListRecordsModel *model = self.dataArray[section];
        return model.orderGoodsListVos.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.type == 1) {
        myOrderListContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[myOrderListContentTableViewCell description]];
        if (self.dataArray.count) {
            OrderListRecordsModel *model = self.dataArray[indexPath.section];
            cell.model = model.orderGoodsListVos[indexPath.row];
        }
        return cell;
    }
    myOrderListContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[myOrderListContentTableViewCell description]];
    if (self.dataArray.count) {
        OrderListRecordsModel *model = self.dataArray[indexPath.section];
        cell.model = model.orderGoodsListVos[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pustToDetailWithSection:indexPath.section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 86;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.type == 1) {
        return 50;
    }
    
 /**
  myOrderTypeWaitingToBeDelivered,//待发货
  myOrderTypeWaitingPendingReceipt,//待收货
  myOrderTypeWaitingRefund,//退款/售后
  */
    if (self.orderType == myOrderTypeWaitingToBeDelivered || self.orderType == myOrderTypeWaitingPendingReceipt || self.orderType == myOrderTypeWaitingRefund) {
        return 50 + 45;
    }
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (self.type == 1) {
        myOrderListContentCellFootView *view = [[myOrderListContentCellFootView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        if (self.dataArray.count) {
            view.model = self.dataArray[section];
        }
        CJWeakSelf()
        view.viewClickBlock = ^{
            CJStrongSelf()
            [self pustToDetailWithSection:section];
        };
        return view;
    }
    float height = 50;
    if (self.orderType == myOrderTypeWaitingToBeDelivered || self.orderType == myOrderTypeWaitingPendingReceipt || self.orderType == myOrderTypeWaitingRefund) {
        height = 50+45;
    }
    myOrderListZiYingCellFootView *view = [[myOrderListZiYingCellFootView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
    if (self.dataArray.count) {
        view.model = self.dataArray[section];
    }
    view.orderType = self.orderType;
    CJWeakSelf()
    view.viewClickBlock = ^{
        CJStrongSelf()
        [self pustToDetailWithSection:section];
    };
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.type == 1) {
        return 44+12;
    }
    return 76+12+7;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.type == 1) {
        myOrderListContentCellHeadView *view = [[myOrderListContentCellHeadView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44+12)];
        if (self.dataArray.count) {
            view.model = self.dataArray[section];
        }
        CJWeakSelf()
        view.viewClickBlock = ^{
            CJStrongSelf()
            [self pustToDetailWithSection:section];
        };
        return view;
    }
    myOrderListZiYingCellHeadView *view = [[myOrderListZiYingCellHeadView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 76+12+7)];
    if (self.dataArray.count) {
        view.model = self.dataArray[section];
    }
    CJWeakSelf()
    view.viewClickBlock = ^{
        CJStrongSelf()
        [self pustToDetailWithSection:section];
    };
    return view;
}

- (void)pustToDetailWithSection:(NSInteger)section{
    
    OrderListRecordsModel *model = self.dataArray[section];
    MyorderDetailViewController *vc = [[MyorderDetailViewController alloc]init];
    vc.type = self.type;
    vc.orderID = model.orderId;
    [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
}

- (UIView *)listView {
    return self.view;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SetIOS13;
    [navigationController setNavigationBarHidden:YES animated:YES];
}

@end


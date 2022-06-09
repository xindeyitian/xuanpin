//
//  ProductDetailCommentViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/24.
//

#import "ProductDetailCommentViewController.h"
#import "ProductDetailCommentTableViewCell.h"
#import "ProductDetailCommentModel.h"

@interface ProductDetailCommentViewController ()<UINavigationControllerDelegate>

@property (nonatomic , assign)NSInteger page;

@end

@implementation ProductDetailCommentViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"评价";
    self.page = 1;
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(12);
        } else {
            make.top.equalTo(self.view).offset(KNavBarHeight).offset(12);
        }
    }];
    
    [self.tableView registerClass:[ProductDetailCommentTableViewCell class] forCellReuseIdentifier:[ProductDetailCommentTableViewCell description]];
    self.needPullUpRefresh = self.needPullDownRefresh = YES;
    [self getHomeData];
}

- (void)loadNewData{
    self.page = 1;
    [self getHomeData];
}

- (void)loadMoreData{
    self.page ++;
    [self getHomeData];
}

- (void)getHomeData{
    if (!self.tableView.mj_header.isRefreshing && !self.tableView.mj_footer.isRefreshing) {
        [self startLoadingHUD];
    }
    self.emptyDataView.hidden = YES;
    [THHttpManager GET:@"goods/goodsAppraises/page" parameters:@{@"goodsId":self.productID,@"pageNum":[NSString stringWithFormat:@"%ld",(long)self.page],@"pageSize":@"10"} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            appraisesListVoPageRecordModel
             *model = [appraisesListVoPageRecordModel mj_objectWithKeyValues:data];
            [self.dataArray addObjectsFromArray:model.records];
            if (self.page == 1) {
                self.emptyDataView.hidden = !(self.dataArray.count == 0);
            }else{
                if (model.records.count == 0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductDetailCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ProductDetailCommentTableViewCell description]];
    commentRecordModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.autoCorner = YES;
    [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
    cell.separatorLineView.hidden = YES;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    commentRecordModel *model = self.dataArray[indexPath.row];
    return model.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    view.backgroundColor = KBGColor;
    return view;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SetIOS13;
    [navigationController setNavigationBarHidden:NO animated:YES];
}

@end

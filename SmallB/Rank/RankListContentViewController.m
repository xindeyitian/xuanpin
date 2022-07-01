//
//  RankListContentViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/7.
//

#import "RankListContentViewController.h"
#import "RankListContentTableViewCell.h"
#import "RecordsModel.h"

@interface RankListContentViewController ()<JXCategoryViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,LMJVerticalFlowLayoutDelegate>

@property (strong, nonatomic) UIView *topUtilityView;

@property (nonatomic, strong) NSMutableArray<NSString *> *titles;
@property (nonatomic, strong) JXCategoryTitleSortView *categoryView;

@property (strong, nonatomic) CJNoDataView *emptyView;

@property (assign, nonatomic) NSInteger page;

@end

@implementation RankListContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.redColor;
    self.dataArray = @[].mutableCopy;
    self.page = 1;
    self.needPullUpRefresh = self.needPullDownRefresh = YES;
    self.tableView.backgroundColor = UIColor.whiteColor;
    [self.tableView registerClass:[RankListContentTableViewCell class] forCellReuseIdentifier:[RankListContentTableViewCell description]];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
}

- (void)setIndex:(NSInteger)index{
    _index = index;
    [self getHomeData];
}

- (void)loadNewData{
    self.page = 1;
    [self getHomeData];
}

- (void)loadMoreData{
    self.page ++ ;
    [self getHomeData];
}

- (void)getHomeData{

    if (!self.tableView.mj_header.isRefreshing && !self.tableView.mj_footer.isRefreshing) {
        [self startLoadingHUD];
    }
    NSDictionary *dic = @{
                          @"pageNum":[NSString stringWithFormat:@"%ld",(long)self.page],
                          @"pageSize":@"10",
                          @"exampleType":[NSString stringWithFormat:@"%ld",(long)self.index+1]
    };

    self.emptyView.hidden = YES;
    
    [THHttpManager GET:@"goods/goodsInfo/exampleGoodsPage" parameters:dic block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            RecordsModel *model = [RecordsModel mj_objectWithKeyValues:data];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:model.records];
                self.emptyView.hidden = !(self.dataArray.count == 0);
                if (self.dataArray.count == 0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
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
    
    RankListContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RankListContentTableViewCell description]];
    cell.cellType = contentCellTypeRankList;
    cell.topImgV.hidden = indexPath.section > 2;
    cell.topImgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"rank_top%ld",indexPath.row+1]];
    if (self.dataArray.count) {
        GoodsListVosModel *model = self.dataArray[indexPath.row];
        cell.model = model;
        cell.separatorLineView.hidden = indexPath.row == self.dataArray.count - 1;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 117;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count) {
        GoodsListVosModel *model = self.dataArray[indexPath.row];
        [AppTool GoToProductDetailWithID:model.goodsId];
    }
}

#pragma mark - JXCategoryListContentViewDelegate -
- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (UIView *)listView {
    return self.view;
}

- (CJNoDataView *)emptyView {
    if(!_emptyView) {
        _emptyView = [[CJNoDataView alloc] init];
        _emptyView.hidden = YES;
        _emptyView.backgroundColor = UIColor.clearColor;
        [self.tableView addSubview:_emptyView];
        [_emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.tableView.centerY).offset(30*KScreenW_Ratio);
            make.centerX.mas_equalTo(self.tableView.centerX);
            make.width.mas_equalTo(278);
            make.height.mas_equalTo(170);
        }];
    }
    return _emptyView;
}

@end

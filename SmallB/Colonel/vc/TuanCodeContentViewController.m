//
//  TuanCodeContentViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/18.
//

#import "TuanCodeContentViewController.h"
#import "TuanCodeNoUseTableViewCell.h"
#import "TuanUsedTableViewCell.h"
#import "BuyTuanCodeViewController.h"
#import "RecordsModel.h"
#import "TaunCodeModel.h"

@interface TuanCodeContentViewController ()

@property (nonatomic , strong)UIView *addView;
@property (assign, nonatomic) NSInteger page;
@property (strong, nonatomic) CJNoDataView *emptyView;

@end

@implementation TuanCodeContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[].mutableCopy;
    self.page = 1;
    
    [self.tableView addSubview:self.addView];
    
    self.view.backgroundColor = self.tableView.backgroundColor = KWhiteBGColor;
    [self.tableView registerClass:[TuanCodeNoUseTableViewCell class] forCellReuseIdentifier:[TuanCodeNoUseTableViewCell description]];
    [self.tableView registerClass:[TuanUsedTableViewCell class] forCellReuseIdentifier:[TuanUsedTableViewCell description]];
    self.needPullUpRefresh = self.needPullDownRefresh = YES;
}

- (void)setIndex:(NSInteger)index{
    _index = index;
}

- (void)loadNewData{
    self.page = 1;
    [self getHomeData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTuanNum" object:nil];
}

- (void)loadMoreData{
    self.page ++ ;
    [self getHomeData];
}

- (void)setSearchStr:(NSString *)searchStr{
    _searchStr = searchStr;
    [self loadNewData];
}

- (void)getHomeData{
    if (!self.tableView.mj_header.isRefreshing && !self.tableView.mj_footer.isRefreshing) {
        [self startLoadingHUD];
    }
    NSMutableDictionary *dic = [@{
                          @"pageNum":[NSString stringWithFormat:@"%ld",(long)self.page],
                          @"pageSize":@"10",
                          @"isUsed":[NSString stringWithFormat:@"%ld",(long)self.index]
    } mutableCopy];
    if (self.searchStr.length) {
        [dic setValue:self.searchStr forKey:@"activateCode"];
    }
    self.emptyView.hidden = YES;
    self.addView.hidden = YES;
    [THHttpManager GET:@"shop/shopActivateCodeInfo/goodsForSupplierPage" parameters:dic block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            TaunCodeModel  *model = [TaunCodeModel mj_objectWithKeyValues:data];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:model.records];
                if (self.index == 1) {
                    self.emptyView.hidden = !(self.dataArray.count == 0);
                    if (self.dataArray.count == 0) {
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    }
                }else{
                    self.addView.hidden = !(self.dataArray.count == 0);
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

#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.index == 0) {
        TuanCodeNoUseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TuanCodeNoUseTableViewCell description]];
        if (self.dataArray.count) {
            cell.model = self.dataArray[indexPath.section];
        }
        return cell;
    }
    TuanUsedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TuanUsedTableViewCell description]];
    if (self.dataArray.count) {
        cell.model = self.dataArray[indexPath.section];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.index == 0 ? 70 : 91;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 225 - KNavBarHeight - KTabBarHeight);
}

- (UIView *)addView{
    if (!_addView) {
        _addView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
        
        UILabel *title = [UILabel creatLabelWithTitle:@"您还没有团长码哦～" textColor:KBlack666TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(15)];
        title.frame = CGRectMake(0, 32, ScreenWidth, 23);
        [_addView addSubview:title];
        
        BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"前去购买" Target:self Action:@selector(addClick) Font:DEFAULT_FONT_R(17) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = 25;
        [_addView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(title.mas_bottom).offset(22);
            make.centerX.mas_equalTo(_addView.mas_centerX);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(160);
        }];
    }
    return _addView;
}

- (void)addClick{
    BuyTuanCodeViewController *vc = [[BuyTuanCodeViewController alloc]init];
    [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
}

#pragma mark - JXCategoryListContentViewDelegate -
- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (UIView *)listView {
    return self.view;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SetIOS13;
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (CJNoDataView *)emptyView {
    if(!_emptyView) {
        _emptyView = [[CJNoDataView alloc] init];
        _emptyView.hidden = YES;
        _emptyView.backgroundColor = UIColor.clearColor;
        _emptyView.noDataImageView.image = IMAGE_NAMED(@"no_data_list");
        _emptyView.noDataTitleLabel.text = @"暂无数据哦～";
        [self.tableView addSubview:_emptyView];
        [_emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.tableView.centerY).offset(10*KScreenW_Ratio);
            make.centerX.mas_equalTo(self.tableView.mas_centerX);
            make.width.mas_equalTo(278);
            make.height.mas_equalTo(170);
        }];
    }
    return _emptyView;
}

@end

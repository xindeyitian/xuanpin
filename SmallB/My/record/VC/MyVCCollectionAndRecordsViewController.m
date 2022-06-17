//
//  MyVCCollectionAndRecordsViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/8.
//

#import "MyVCCollectionAndRecordsViewController.h"
#import "ProductsCommentCell.h"
#import "myVCStoreAttentionCell.h"
#import "RecordModel.h"
#import "listVosModel.h"
#import "StoreCollectionModel.h"

@interface MyVCCollectionAndRecordsViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
{
    BOOL isManager;
}
@property (nonatomic , strong)MyVCCollectionAndRecordsBottomView *bottomView;
//@property (nonatomic , strong)RecordModel *recordModel;
@property (nonatomic , strong)listVosModel *listModel;
@property (nonatomic , assign)NSInteger page;

@end

@implementation MyVCCollectionAndRecordsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.delegate = self;
    isManager = NO;
    self.page = 1;
    self.dataArray = [NSMutableArray array];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = CGRectMake(0,0 ,25, 25);
    [btn setTitle:@"管理" forState:UIControlStateNormal];
    [btn setTitle:@"完成" forState:UIControlStateSelected];
    [btn setTitleColor:KBlack333TextColor forState:UIControlStateNormal];
    btn.titleLabel.font = DEFAULT_FONT_R(16);
    btn.titleLabel.textColor = KBlack333TextColor;
    [btn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem  =  [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
    self.navigationItem.title = self.typeIndex == vcTypeIndexProductCollection ? @"我的收藏" : @"浏览记录";
    if (self.typeIndex == vcTypeIndexStoreAttention) {
        self.navigationItem.title = @"我的关注";
        self.emptyDataView.noDataImageView.image = IMAGE_NAMED(@"no_data_list");
        self.emptyDataView.noDataTitleLabel.text = @"暂无数据哦～";
    }
    self.needPullUpRefresh = self.needPullDownRefresh = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    self.tableView.clipsToBounds = YES;
    self.tableView.layer.cornerRadius = 4;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    
    self.emptyDataView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    
    [self.tableView registerClass:[ProductsCommentCell class] forCellReuseIdentifier:[ProductsCommentCell description]];
    [self.tableView registerClass:[myVCStoreAttentionCell class] forCellReuseIdentifier:[myVCStoreAttentionCell description]];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-5);
    }];
    self.bottomView = [[MyVCCollectionAndRecordsBottomView alloc]init];
    self.bottomView.typeIndex = self.typeIndex;
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(TabbarSafeBottomMargin + 56);
    }];
    self.bottomView.hidden = YES;
    self.needPullDownRefresh = self.needPullUpRefresh = YES;
    [self getListData];
    CJWeakSelf()
    self.bottomView.selectOperation = ^(BOOL isSelect) {
        CJStrongSelf()
        [self setAllWithSelect:isSelect];
    };
    self.bottomView.deleteOperation = ^{
        CJStrongSelf()
        [self deleteWithDeleteCurrent:YES row:0];;
    };
}

- (void)loadNewData{
    self.page = 1;
    [self getListData];
}

- (void)loadMoreData{
    self.page ++;
    [self getListData];
}

- (void)getListData{
    self.navigationItem.title = self.typeIndex == vcTypeIndexProductCollection ? @"我的收藏" : @"浏览记录";
    if (self.typeIndex == vcTypeIndexStoreAttention) {
        self.navigationItem.title = @"我的关注";
    }
    if (!self.tableView.mj_header.isRefreshing && !self.tableView.mj_footer.isRefreshing) {
        [self startLoadingHUD];
    }
    NSString *url = @"";
    if (self.typeIndex == vcTypeIndexProductCollection) {
        url = @"goods/goodsInfo/collectGoodsPage";
    }
    if (self.typeIndex == vcTypeIndexStoreAttention) {
        url = @"shop/shopInfo/shopSupplyCollectPage";
    }
    if (self.typeIndex == vcTypeIndexRecordList) {
        url = @"goods/goodsInfo/browseGoodsPage";
    }
    NSDictionary *dica = @{@"pageNum":[NSString stringWithFormat:@"%ld",(long)self.page],@"pageSize":@"10"};
    if (self.typeIndex == vcTypeIndexStoreAttention) {
        [THHttpManager FormatPOST:url parameters:dica dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
            [self stopLoadingHUD];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
                StoreCollectionModel *model = [StoreCollectionModel mj_objectWithKeyValues:data];
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
                [self judgeStoreIsAll];
                [self.tableView reloadData];
            }
        }];
    }else{
        [THHttpManager GET:url parameters:dica block:^(NSInteger returnCode, THRequestStatus status, id data) {
            [self stopLoadingHUD];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
                RecordModel *model = [RecordModel mj_objectWithKeyValues:data];
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
                [self judgeIsAll];
                [self.tableView reloadData];
            }
        }];
    }
}

- (void)editBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    isManager = btn.selected;
    self.bottomView.hidden = !isManager;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(isManager ? -61 - KSafeAreaBottomHeight : - 5);
    }];
    [self.tableView reloadData];
}

#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.typeIndex == vcTypeIndexStoreAttention) {
        myVCStoreAttentionCell *cell = [tableView dequeueReusableCellWithIdentifier:[myVCStoreAttentionCell description]];
        cell.autoCorner = 1;
        [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
        cell.isManager = isManager;
        if (self.dataArray.count) {
            cell.model = self.dataArray[indexPath.row];
        }
        cell.updateBlock = ^{
            [self loadNewData];
        };
        return cell;
    }
    ProductsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:[ProductsCommentCell description]];
    cell.autoCorner = 1;
    [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
    cell.isManager = isManager;
    if (self.dataArray.count) {
        cell.dataModel = self.dataArray[indexPath.row];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.typeIndex == vcTypeIndexStoreAttention) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.typeIndex == vcTypeIndexStoreAttention) {
        if (isManager) {
            StoreCollectionRecordsModel *model = self.dataArray[indexPath.row];
            model.isSelect = !model.isSelect;
            [self.tableView reloadData];
            [self judgeStoreIsAll];
        }
    }else{
        if (isManager) {
            GoodsListVosModel *model = self.dataArray[indexPath.row];
            model.isSelect = !model.isSelect;
            [self.tableView reloadData];
            [self judgeIsAll];
        }else{
            GoodsListVosModel *model = self.dataArray[indexPath.row];
            [AppTool GoToProductDetailWithID:model.goodsId];
        }
    }
}

- (void)setAllWithSelect:(BOOL)select{
    
    if (self.typeIndex == vcTypeIndexStoreAttention) {
        for (StoreCollectionRecordsModel *model in self.dataArray) {
            model.isSelect = select;
        }
        self.bottomView.selectImg.image = select ? IMAGE_NAMED(@"all_select_selected") :IMAGE_NAMED(@"all_select_select");
        [self.tableView reloadData];
        return;
    }
    
    for (GoodsListVosModel *model in self.dataArray) {
        model.isSelect = select;
    }
    self.bottomView.selectImg.image = select ? IMAGE_NAMED(@"all_select_selected") :IMAGE_NAMED(@"all_select_select");
    [self.tableView reloadData];
}

- (BOOL)judgeStoreIsAll{
    NSMutableArray *allAry = [NSMutableArray arrayWithArray:self.dataArray];
    NSMutableArray *selectAry = [NSMutableArray array];
    for (StoreCollectionRecordsModel *model in self.dataArray) {
        if (model.isSelect) {
            [selectAry addObject:model];
        }
    }
    if (allAry.count == selectAry.count) {
        self.bottomView.selectImg.image = IMAGE_NAMED(@"all_select_selected");
        self.bottomView.controL.selected = YES;
        return YES;
    }
    self.bottomView.selectImg.image = IMAGE_NAMED(@"all_select_select");
    self.bottomView.controL.selected = NO;
    return NO;
}

- (BOOL)judgeIsAll{
    NSMutableArray *allAry = [NSMutableArray arrayWithArray:self.dataArray];
    NSMutableArray *selectAry = [NSMutableArray array];
    for (GoodsListVosModel *model in self.dataArray) {
        if (model.isSelect) {
            [selectAry addObject:model];
        }
    }
    if (allAry.count == selectAry.count) {
        self.bottomView.selectImg.image = IMAGE_NAMED(@"all_select_selected");
        self.bottomView.controL.selected = YES;
        return YES;
    }
    self.bottomView.selectImg.image = IMAGE_NAMED(@"all_select_select");
    self.bottomView.controL.selected = NO;
    return NO;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)) {
    CJWeakSelf()
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        CJStrongSelf()
        [self deleteWithDeleteCurrent:NO row:indexPath.row];
    }];
    deleteRowAction.backgroundColor = UIColor.redColor;
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    config.performsFirstActionWithFullSwipe = NO;
    return config;
}

- (void)deleteWithDeleteCurrent:(BOOL)isBottom row:(NSInteger)row{
    
    NSMutableArray *IDAry = [NSMutableArray array];
    if (!isBottom) {
        GoodsListVosModel *model = self.dataArray[row];
        [IDAry addObject:model.browseId];
    }else{
        if (self.typeIndex == vcTypeIndexStoreAttention) {
            for (StoreCollectionRecordsModel *model in self.dataArray) {
                if (model.isSelect) {
                    [IDAry addObject:model.collectId];
                }
            }
        }else{
            for (GoodsListVosModel *model in self.dataArray) {
                if (model.isSelect) {
                    [IDAry addObject:model.browseId];
                }
            }
        }
    }
    if (IDAry.count == 0) {
        [self showMessageWithString:@"请至少选择一个商品"];
        return;
    }
    [self startLoadingHUD];
    NSString *url = @"goods/goodsInfo/delCollectGoods";
    if (self.typeIndex == vcTypeIndexRecordList) {
        url = @"goods/goodsInfo/delBrowse";
    }if (self.typeIndex == vcTypeIndexStoreAttention) {
        url = @"shop/shopInfo/cancelCollect";
    }
    [THHttpManager POST:url parameters:@{@"ids":IDAry} dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200) {
            
            NSString *string = @"取消收藏成功";
            if (self.typeIndex == vcTypeIndexRecordList) {
                string = @"记录删除成功";
            }if (self.typeIndex == vcTypeIndexStoreAttention) {
                string = @"取消关注成功";
            }
            [self showSuccessMessageWithString:string];
            [self loadNewData];
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.typeIndex == vcTypeIndexStoreAttention) {
        float width = (ScreenWidth - 24 - 24 - 24)/4.0;
        return 94+width;
    }
    return 144;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    SetIOS13;
    [navigationController setNavigationBarHidden:NO animated:YES];
}

@end

@implementation MyVCCollectionAndRecordsBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    
    self.backgroundColor = KWhiteBGColor;
    UIControl *contro = [[UIControl alloc]init];
    contro.frame = CGRectMake(12, 0, 67, 56);
    [contro addTarget:self action:@selector(selectOperation:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:contro];
    self.controL = contro;
    
    UIImageView *select = [[UIImageView alloc]initWithFrame:CGRectMake(12, 16, 24, 24)];
    select.image = IMAGE_NAMED(@"all_select_select");
    [contro addSubview:select];
    self.selectImg = select;
    
    UILabel *title = [UILabel creatLabelWithTitle:@"全选" textColor:KBlack666TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
    title.frame = CGRectMake(37, 18, 30, 20);
    [contro addSubview:title];
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_R(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 20;
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(8);
        make.right.mas_equalTo(self).offset(-12);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(108);
    }];
    self.operationBtn = btn;
}

- (void)setTypeIndex:(vcTypeIndex)typeIndex{
    _typeIndex = typeIndex;
    
    NSString *title = @"";
    /**
     vcTypeIndexProductCollection = 0,//商品收藏
     vcTypeIndexStoreAttention,//店铺关注
     vcTypeIndexRecordList,//浏览记录
     */
    if (_typeIndex == vcTypeIndexProductCollection) {
        title = @"取消收藏";
    }
    if (_typeIndex == vcTypeIndexStoreAttention) {
        title = @"取消关注";
    }
    if (_typeIndex == vcTypeIndexRecordList) {
        title = @"一键删除";
    }
    [self.operationBtn setTitle:title forState:UIControlStateNormal];
    
}

-(void)selectOperation:(UIControl *)contro{
    contro.selected = !contro.selected;
    if (_selectOperation) {
        _selectOperation(contro.selected);
    }
}

-(void)btnClick{
    if (_deleteOperation) {
        _deleteOperation();
    }
}

@end

//
//  MyViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/3/22.
//

#import "MyViewController.h"
#import "MyVCInfoTableViewCell.h"
#import "myVCGuideView.h"
#import "MyVCCollectionAndRecordsViewController.h"
#import "incomeStatisticsModel.h"

typedef NS_ENUM(NSInteger, CJMyListVMType) {
    myVCInfo = 0,
    myVCProfits,
    myVCOrder,//myVCGuide,
    myVCChat,
};

@interface MyViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) incomeStatisticsModel *myDataModel;
@property (strong, nonatomic) userInfoModel *infoModel;
@property (strong, nonatomic) NSMutableArray *bannerAry;

@end

@implementation MyViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationNone)];
    [self loadNewData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.delegate = self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    if (@available(iOS 11.0, *)) {
        [UITableView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.bannerAry = [NSMutableArray array];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = KBGColor;
    
    [self.tableView registerClass:[MyVCInfoTableViewCell class] forCellReuseIdentifier:[MyVCInfoTableViewCell description]];
    [self.tableView registerClass:[MyVCChatTableViewCell class] forCellReuseIdentifier:[MyVCChatTableViewCell description]];
    [self.tableView registerClass:[MyVCOrderTableViewCell class] forCellReuseIdentifier:[MyVCOrderTableViewCell description]];
    [self.tableView registerClass:[MyVCProfitsTableViewCell class] forCellReuseIdentifier:[MyVCProfitsTableViewCell description]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell description]];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
   
    self.needPullDownRefresh = YES;
}

- (void)loadNewData{
    [self getMyincomeStatistics];
    [self banner];
    [self getUserInfo];
}

- (void)getUserInfo{
    [THHttpManager POST:@"shop/shopUser/queryShopUserInfo" parameters:@{} dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        if (returnCode == 200 &&  [data isKindOfClass:[NSDictionary class]]) {
            self.infoModel = [userInfoModel mj_objectWithKeyValues:data];
            if (self.infoModel.inviteCode) {
                [AppTool saveToLocalDataWithValue:self.infoModel.inviteCode key:@"inviteCode"];
            }
        }
        [self.tableView reloadData];
    }];
}

- (void)banner{
    [THHttpManager GET:@"commons/bannerInfo/bannerList" parameters:@{@"bannerCode":@"shopCentreCode"} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self.bannerAry removeAllObjects];
        if (returnCode == 200 &&  [data isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dica in data) {
                BannerListVosModel *model = [BannerListVosModel mj_objectWithKeyValues:dica];
                [self.bannerAry addObject:model.ossImgPath];
            }
        }
        [self.tableView reloadData];
    }];
}

- (void)getMyincomeStatistics{
    if (!self.tableView.mj_header.isRefreshing) {
        //[self startLoadingHUD];
    }
    [THHttpManager GET:@"user/UserStatistics/incomeStatistics" parameters:@{} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        [self.tableView.mj_header endRefreshing];
        if ([data isKindOfClass:[NSDictionary class]]) {
            incomeStatisticsModel *model = [incomeStatisticsModel mj_objectWithKeyValues:data];
            self.myDataModel = model;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case myVCInfo:{
            MyVCInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyVCInfoTableViewCell description]];
            if (self.myDataModel) {
                cell.model = self.myDataModel;
            }
            if (self.infoModel) {
                cell.infoModel = self.infoModel;
            }
            return cell;
        }
            break;
        case myVCProfits:{
            MyVCProfitsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyVCProfitsTableViewCell description]];
            if (self.myDataModel) {
                cell.model = self.myDataModel;
            }
            return cell;
        }
            break;
        case myVCOrder:{
            MyVCOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyVCOrderTableViewCell description]];
            return cell;
        }
            break;
        case myVCChat:{
            MyVCChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyVCChatTableViewCell description]];
            return cell;
        }
            break;
        default:
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell description]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case myVCInfo:{
            return KStatusBarHeight + 180;
        }
            break;
        case myVCProfits:
            return 144;
            break;
        case myVCOrder:
            return 138 + 12;
            break;
        case myVCChat:
            return 96;
            break;
        default:
            break;
    }
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == myVCChat && self.bannerAry.count) {
        return 80*KScreenW_Ratio + 12;
    }
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == myVCChat && self.bannerAry.count) {
        myVCGuideView *headerView = [[myVCGuideView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80*KScreenW_Ratio + 12)];
        headerView.bannerAry = self.bannerAry;
        return headerView;
    }
    return [UIView new];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}

@end

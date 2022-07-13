//
//  SearchListViewController.m
//  SmallB
//
//  Created by 张昊男 on 2022/4/6.
//

#import "SearchListViewController.h"
#import "SearchResultViewController.h"
#import "SearchNavBar.h"
#import "HomeMoreCommonViewController.h"
#import "SearchHotModel.h"

@interface SearchListViewController ()

@property (strong, nonatomic) MyLinearLayout *rootLy, *historyLy, *searchLy;
@property (strong, nonatomic)NSMutableArray *searchHotAry;
@property (assign, nonatomic)NSInteger page;

@end

@implementation SearchListViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    
    [self creatHeaderView];
    //[self creatFooterView];
}

- (void)deleteHistory{
    [AppTool cleanLocalSearchHistory];
    [self creatHeaderView];
}

- (void)historyClicked:(UIButton *)sender{
    [self pushToSearchWithSearchStr:sender.titleLabel.text];
}
- (void)refersh{
    
}

- (void)getHotData{
    [THHttpManager GET:@"goods/goodsInfo/searchFound" parameters:@{@"pageSize":@"9",@"pageNum":[NSString stringWithFormat:@"%ld",(long)self.page]} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        if ([data isKindOfClass:[NSDictionary class]] && returnCode == 200) {
            [self.searchHotAry removeAllObjects];
            SearchHotModel *model = [SearchHotModel mj_objectWithKeyValues:data];
            [self.searchHotAry addObjectsFromArray:model.records];
            [self creatFooterView];
        }
    }];
}

- (void)findClicked:(UIButton *)sender{
    [self pushToSearchWithSearchStr:sender.titleLabel.text];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KWhiteBGColor;
    self.tableView.backgroundColor = KWhiteBGColor;
    
    self.nav = [[SearchNavBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight)];
    [self.view addSubview:self.nav];
    CJWeakSelf()
    self.nav.searchBtnOperationBlock = ^(NSString * _Nonnull searchStr) {
        CJStrongSelf();
        [AppTool saveToLocalSearchHistory:searchStr];
        [self pushToSearchWithSearchStr:searchStr];
    };
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nav.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    self.searchHotAry = [NSMutableArray array];
    self.page = 1;
    [self getHotData];
}

- (void)pushToSearchWithSearchStr:(NSString *)searchStr{
    HomeMoreCommonViewController *vc = [[HomeMoreCommonViewController alloc] init];
    vc.searchStr = searchStr;
    vc.homeMoreCommonType = HomeMoreCommonType_SearchResult;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)creatHeaderView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    headView.backgroundColor = KWhiteBGColor;
  
    UILabel *searchTitle = [UILabel creatLabelWithTitle:@"搜索历史" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(16)];
    searchTitle.frame = CGRectMake(12, 12, 180, 26);
    [headView addSubview:searchTitle];

    UIButton *delBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(deleteHistory) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1 BackgroundImage:@"delete" HeightLightBackgroundImage:@"delete"];
    delBtn.frame = CGRectMake(ScreenWidth - 37, 12, 25, 25);
    [headView addSubview:delBtn];
    
    float width = (ScreenWidth - 48) / 3;
    NSArray *historyArr = [AppTool getLocalSearchHistory];
    float maxY = CGRectGetMaxY(searchTitle.frame);
    for (int i = 0; i < historyArr.count; i++) {
        
        UIButton *historyBtn = [BaseButton CreateBaseButtonTitle:historyArr[i] Target:self Action:@selector(historyClicked:) Font:[UIFont systemFontOfSize:15] BackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"] Color:UIColor.blackColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:i];
        historyBtn.frame = CGRectMake(12+(width + 12)*(i%3), 50+(12+40)*(i/3), width, 40);
        historyBtn.layer.cornerRadius = 20;
        historyBtn.layer.masksToBounds = YES;
        if (i == historyArr.count - 1) {
            maxY = CGRectGetMaxY(historyBtn.frame);
        }
        [headView addSubview:historyBtn];
    }
    maxY += 12;
    headView.frame = CGRectMake(0, 0, ScreenWidth, maxY);
    self.tableView.tableHeaderView = headView;
}

- (void)creatFooterView{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectZero];
    footView.backgroundColor = KWhiteBGColor;
    self.tableView.tableFooterView = footView;
    
    UILabel *searchTitle = [UILabel creatLabelWithTitle:@"搜索发现" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(16)];
    searchTitle.frame = CGRectMake(12, 12, 180, 26);
    [footView addSubview:searchTitle];

    UIButton *delBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(reloadHotSearch) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1 BackgroundImage:@"refersh" HeightLightBackgroundImage:@"refersh"];
    delBtn.frame = CGRectMake(ScreenWidth - 37, 12, 25, 25);
    [footView addSubview:delBtn];
    
    NSMutableArray *resultAry = [NSMutableArray array];
    for (SearchHotDataModel *model in self.searchHotAry) {
        [resultAry addObject:model.searchName];
    }
    float width = (ScreenWidth - 48) / 3;
    float maxY = .0f;
    for (int i = 0; i < resultAry.count; i++) {
        
        UIButton *historyBtn = [BaseButton CreateBaseButtonTitle:resultAry[i] Target:self Action:@selector(historyClicked:) Font:[UIFont systemFontOfSize:15] BackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"] Color:UIColor.blackColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:i];
        historyBtn.frame = CGRectMake(12+(width + 12)*(i%3), 50+(12+40)*(i/3), width, 40);
        historyBtn.layer.cornerRadius = 20;
        historyBtn.layer.masksToBounds = YES;
        if (i == resultAry.count - 1) {
            maxY = CGRectGetMaxY(historyBtn.frame);
        }
        [footView addSubview:historyBtn];
    }
    maxY += 12;
    footView.frame = CGRectMake(0, 0, ScreenWidth, maxY);
    self.tableView.tableFooterView = footView;
}

- (void)reloadHotSearch{
    self.page ++ ;
    [self getHotData];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SetIOS13;
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}

@end

//
//  HomeViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/3/22.
//

#import "HomeViewController.h"
#import "HomeTopView.h"
#import "rightPushView.h"
#import "HomeYouXuanTableViewCell.h"
#import "HomeRecommendTableViewCell.h"
#import "HomeFirstTopView.h"
#import "HomeStoreContentViewController.h"
#import "HomeMoreCommonViewController.h"
#import "HomeDataModel.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (copy,   nonatomic) void(^scrollCallback)(UIScrollView *scrollView);
@property (strong, nonatomic) UITableView *homeTable;
@property (strong, nonatomic) HomeFirstTopView *topView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.clearColor;
    self.homeTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - KNavBarHeight - KTabBarHeight - 44) style:UITableViewStyleGrouped];
    self.homeTable.delegate = self;
    self.homeTable.dataSource = self;
    self.homeTable.showsVerticalScrollIndicator = NO;
    self.homeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.homeTable.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.homeTable];
    [self.homeTable registerClass:[ProductsCommentCell class] forCellReuseIdentifier:[ProductsCommentCell description]];
    [self.homeTable registerClass:[HomeYouXuanTableViewCell class] forCellReuseIdentifier:[HomeYouXuanTableViewCell description]];
    [self.homeTable registerClass:[HomeRecommendTableViewCell class] forCellReuseIdentifier:[HomeRecommendTableViewCell description]];
    
    self.topView = [[HomeFirstTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 124 + 140*KScreenW_Ratio)];
    self.topView.backgroundColor = UIColor.clearColor;
    self.homeTable.tableHeaderView = self.topView;
    CJWeakSelf()
    self.homeTable.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        CJStrongSelf()
        [self getHomeData];
    }];

    UIView *footereV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5.01f)];
    footereV.backgroundColor = UIColor.whiteColor;
    self.homeTable.tableFooterView = footereV;
}

- (void)setDataModel:(HomeDataModel *)dataModel{
    _dataModel = dataModel;
    self.topView.dataModel = dataModel;
    [self.homeTable reloadData];
}

- (void)getHomeData{
    if (!self.homeTable.mj_header.isRefreshing) {
        [self startLoadingHUD];
    }
    [THHttpManager GET:@"goods/shopBlockDefine/home" parameters:@{} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        [self.homeTable.mj_header endRefreshing];
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            HomeDataModel *model = [HomeDataModel mj_objectWithKeyValues:data];
            self.dataModel = model;
            [self.homeTable reloadData];
            self.topView.dataModel = model;
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        for (BlockDefineGoodsVosModel *model in self.dataModel.blockDefineGoodsVos) {
            if ([model.blockId isEqualToString:@"8"]) {
                return model.goodsListVos.count;
            }
        }
        return 0;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HomeYouXuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeYouXuanTableViewCell description]];
        BlockDefineGoodsVosModel *currentModel = [[BlockDefineGoodsVosModel alloc]init];
        for (BlockDefineGoodsVosModel *model in self.dataModel.blockDefineGoodsVos) {
            if ([model.blockId isEqualToString:@"7"]) {
                currentModel =  model;
            }
        }
        if (currentModel.blockName.length) {
            cell.model = currentModel;
        }
        return cell;
    }
    if (indexPath.section == 1) {
        HomeRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeRecommendTableViewCell description]];
        BlockDefineGoodsVosModel *currentModel = [[BlockDefineGoodsVosModel alloc]init];
        for (BlockDefineGoodsVosModel *model in self.dataModel.blockDefineGoodsVos) {
            if ([model.blockId isEqualToString:@"6"]) {
                currentModel =  model;
            }
        }
        if (currentModel.blockName.length) {
            cell.model = currentModel;
        }
        return cell;
    }
    ProductsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:[ProductsCommentCell description]];
    cell.bgViewContentInset = UIEdgeInsetsMake(0, 0, 0, 0);
   
    GoodsListVosModel *currentModel = [[GoodsListVosModel alloc]init];
    NSMutableArray *array = [NSMutableArray array];
    for (BlockDefineGoodsVosModel *model in self.dataModel.blockDefineGoodsVos) {
        if ([model.blockId isEqualToString:@"8"]) {
            currentModel =  model.goodsListVos[indexPath.row];
            [array addObjectsFromArray:model.goodsListVos];
            break;
        }
    }
    if (currentModel.goodsName.length) {
        cell.dataModel = currentModel;
    }
    if (array.count) {
        cell.separatorLineView.hidden = (indexPath.row == array.count - 1);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsListVosModel *currentModel = [[GoodsListVosModel alloc]init];
    for (BlockDefineGoodsVosModel *model in self.dataModel.blockDefineGoodsVos) {
        if ([model.blockId isEqualToString:@"8"]) {
            currentModel =  model.goodsListVos[indexPath.row];
        }
    }
    [AppTool GoToProductDetailWithID:currentModel.goodsId];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataModel) {
        if (indexPath.section == 1) {
            return 252 - 76 + 76*KScreenW_Ratio;
        }
        return (indexPath.section == 0 ? 279 : 140);
    }
    return 20.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section == 2 ? 0.01:12.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, section == 2 ? 0.01:12.0)];
    view.backgroundColor = KViewBGColor;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 1 ? 57 :37;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    float height = section == 1 ? 57 : 37;
    float width = section == 2 ? ScreenWidth : ScreenWidth - 24;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
    view.backgroundColor = section == 2 ? KWhiteBGColor : KViewBGColor;
    
    UIImageView *bgView=  [[UIImageView alloc]initWithFrame:CGRectMake(section == 2 ? 0:12, 0, width, height)];
    if (section == 1) {
        bgView.image = IMAGE_NAMED(@"hotTopImg");
    }
    if (section == 0) {
        bgView.backgroundColor = KWhiteBGColor;
    }
    [view addSubview:bgView];
    
    NSString *titleStr = section == 0 ? @"小莲优选":(section ==1 ?@"品牌热推":@"好货推荐");
    UILabel *title = [UILabel creatLabelWithTitle:titleStr textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:FONTWEIGHT_MEDIUM_FONT_R(17)];
    title.frame = CGRectMake(12, height-25, 160, 25);
    [bgView addSubview:title];
    
    bgView.userInteractionEnabled = YES;
    rightPushView *rightV = [[rightPushView alloc]initWithFrame:CGRectMake(width-60-6, 0, 60, 20)];
    rightV.centerY = title.centerY;
    rightV.imageHeight = 15;
    rightV.imageNameString = @"my_right_gray";
    rightV.titleL.text = @"更多";
    rightV.titleL.font = DEFAULT_FONT_R(12);
    rightV.titleL.textColor = KBlack999TextColor;
    [bgView addSubview:rightV];
    if (section == 1) {
        rightV.titleL.textColor = KWhiteTextColor;
        title.textColor = KWhiteTextColor;
        rightV.imageNameString = @"my_right_white";
        rightV.centerY = title.centerY = bgView.centerY;
    }
    CJWeakSelf()
    rightV.viewClickBlock = ^{
        CJStrongSelf()
        if (section == 1) {
            HomeStoreContentViewController *vc = [[HomeStoreContentViewController alloc]init];
            vc.blockId = @"6";
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (section == 0) {
            HomeMoreViewController *vc = [[HomeMoreViewController alloc]init];
            vc.homeMoreType = HomeMoreType_XiaoLianYouXuan;
            vc.blockId = @"7";
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (section == 2) {
            HomeMoreCommonViewController *vc = [[HomeMoreCommonViewController alloc]init];
            vc.homeMoreCommonType = HomeMoreCommonType_Recommend;
            vc.blockId = @"8";
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
    return view;
}
#pragma mark - JXCategoryListContentViewDelegate -
- (UIScrollView *)listScrollView {
    return self.homeTable;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self.view;
}
@end

//
//  ProductDetailViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/8.
//

#import "ProductDetailViewController.h"
#import "ProductDetailInfoCell.h"
#import "ProductDetailSKUCell.h"
#import "ProductDetailCommentTableViewCell.h"
#import "ProductDetailStoreCell.h"
#import "ProductDetailRecommendCell.h"
#import "ProductDetailBottomView.h"
#import "MerchantDetailBaseViewController.h"
#import "HomeCollectionViewCell.h"
//#import "ProductDetailCommentModel.h"
#import "ProductDetailCommentViewController.h"
#import "ProductDetailCommentHeaderView.h"
#import "ProductDetailCommentFooterView.h"
#import "ProductDeatilInfoTableViewCell.h"
#import "THBaseCommentTableViewCell.h"
#import "ProductDetailSKUViewController.h"
#import "ProductGuiGeViewController.h"
//#import "ProductDetailModel.h"
#import "RecordsModel.h"
#import "ProductShareViewController.h"
#import "ProductDetailBottomRecommendCell.h"

@interface ProductDetailViewController ()<UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate,THFlowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,JXCategoryViewDelegate>

@property (strong, nonatomic) UITableView             *productDetailTable;
@property (strong, nonatomic) ProductDetailBottomView *bottomView;
@property (strong, nonatomic) UICollectionView        *recommendCollection;
@property (strong, nonatomic) MyLinearLayout          *topLy, *baseLy;
@property (strong, nonatomic) UIView          *topView;
@property (strong, nonatomic) NSMutableArray          *commentArray;
@property (strong, nonatomic) NSMutableArray          *productInfoAry;
@property (strong, nonatomic)JXCategoryTitleView *categoryTitleV;
@property (strong, nonatomic)ProductDetailTopSelectView *topSelectView;
@property (strong, nonatomic) ProductDetailModel          *productDetailModel;

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, assign) CGFloat webViewHeight;

@property (nonatomic, strong) NSMutableArray *dataAry;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) CGFloat recommendHeight;
@property (nonatomic, assign) BOOL topClick;

@end

@implementation ProductDetailViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
- (void)rightBtnClicked:(UIButton *)sender{
    
    if (sender.tag == 10) {
        [self.productDetailTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (void)popVC{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    self.view.backgroundColor = UIColor.whiteColor;
    self.dataAry = @[].mutableCopy;
    self.webViewHeight = 0.0;
    self.page = 1;
    self.recommendHeight = 0.0;
    
    NSMutableArray *array = [NSMutableArray array];
    self.commentArray = [NSMutableArray array];
    self.productInfoAry = [@[@{@"left":@"规格",@"right":@""},@{@"left":@"参数",@"right":@"品牌，适用年龄…"},@{@"left":@"保障",@"right":@""}]  mutableCopy];
    self.productInfoAry = [@[@{@"left":@"规格",@"right":@""},@{@"left":@"保障",@"right":@""}]  mutableCopy];
  
    self.productDetailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, RootStatusBarHeight, ScreenWidth, ScreenHeight - RootStatusBarHeight - TabbarSafeBottomMargin - 45) style:UITableViewStyleGrouped];
    self.productDetailTable.delegate = self;
    self.productDetailTable.dataSource = self;
    self.productDetailTable.showsVerticalScrollIndicator = NO;
    self.productDetailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.productDetailTable.estimatedRowHeight = 10000;
    self.productDetailTable.rowHeight = UITableViewAutomaticDimension;
    self.productDetailTable.backgroundColor = KBGColor;
    [self.view addSubview:self.productDetailTable];
    
    [self.productDetailTable registerClass:[ProductDeatilInfoBiaoQianTableViewCell class] forCellReuseIdentifier:@"ProductDeatilInfoBiaoQianTableViewCell"];
    [self.productDetailTable registerClass:[ProductDetailInfoCell class] forCellReuseIdentifier:@"ProductDetailInfoCell"];
    [self.productDetailTable registerClass:[ProductDeatilInfoTableViewCell class] forCellReuseIdentifier:@"ProductDeatilInfoTableViewCell"];
    [self.productDetailTable registerClass:[ProductDetailCommentTableViewCell class] forCellReuseIdentifier:@"ProductDetailCommentTableViewCell"];
    [self.productDetailTable registerClass:[ProductDetailStoreCell class] forCellReuseIdentifier:@"ProductDetailStoreCell"];
    [self.productDetailTable registerClass:[ProductDetailRecommendCell class] forCellReuseIdentifier:@"ProductDetailRecommendCell"];
    [self.productDetailTable registerClass:[THBaseCommentTableViewCell class] forCellReuseIdentifier:@"THBaseCommentTableViewCell"];
    [self.productDetailTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.productDetailTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell1"];
    [self.productDetailTable registerClass:[ProductDetailBottomRecommendCell class] forCellReuseIdentifier:@"ProductDetailBottomRecommendCell"];
    
    self.bottomView = [[ProductDetailBottomView alloc] initWithFrame:CGRectMake(0, ScreenHeight - TabbarSafeBottomMargin - 60, ScreenWidth, TabbarSafeBottomMargin + 60)];
    [self.view addSubview:self.bottomView];
    
    CJWeakSelf()
    self.productDetailTable.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        CJStrongSelf()
        [self loadNewData];
    }];
    
    THFlowLayout *layout = [[THFlowLayout alloc] init];
    layout.delegate = self;
    layout.columnMargin = 8;
    layout.rowMargin = 8;
    layout.columnsCount = 2;
    layout.headerReferenceSize = CGSizeMake(ScreenWidth, 0);
    layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
    
    self.recommendCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, MAXFLOAT) collectionViewLayout:layout];
    self.recommendCollection.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.recommendCollection.delegate = self;
    self.recommendCollection.dataSource = self;
    self.recommendCollection.showsVerticalScrollIndicator = NO;
    [self.recommendCollection registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
    
    [self initTopBtn];
    [self initTopView];
    [self createRightBtnView];
    [self loadNewData];
}

- (void)loadNewData{
    [self getHomeData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.productDetailTable == scrollView) {
        
        self.topLy.alpha = scrollView.contentOffset.y / (375 - KNavBarHeight);
        self.topView.alpha = scrollView.contentOffset.y / (375 - KNavBarHeight);
        if (scrollView.contentOffset.y > 0) {
            self.baseLy.alpha = 0;
        }else{
            self.baseLy.alpha = 1;
        }
    }

//    if (!self.topClick) {
        float section0 = 0;
        float section2 = [self.productDetailTable rectForHeaderInSection:2].origin.y - 44;
        float section3 = [self.productDetailTable rectForHeaderInSection:3].origin.y - 44;
        float section5 = [self.productDetailTable rectForHeaderInSection:5].origin.y - 44;
        
        float contentOffsetY = scrollView.contentOffset.y;
        if (contentOffsetY > section0 && contentOffsetY < section2) {
            self.topSelectView.selectIndex = 0;
        }else if (contentOffsetY > section2 && contentOffsetY < section3) {
            self.topSelectView.selectIndex = 1;
        }else if (contentOffsetY > section3 && contentOffsetY < section5) {
            self.topSelectView.selectIndex = 2;
        }else if (contentOffsetY > section5) {
            self.topSelectView.selectIndex = 3;
        }
        self.topClick = NO;
//    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        if (self.productDetailModel) {
            return (self.productDetailModel.appraisesListVoPage.records.count > 2) ? 2 : self.productDetailModel.appraisesListVoPage.records.count;
        }
        return 0;
    }
    if (section == 1) {
        return self.productInfoAry.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        ProductDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDetailInfoCell"];
        if (self.productDetailModel) {
            cell.detailModel = self.productDetailModel;
        }
        return cell;
    }else if (indexPath.section == 1){
        
        ProductDeatilInfoTableViewCell *cell;
        if (indexPath.row == 1) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDeatilInfoBiaoQianTableViewCell"];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDeatilInfoTableViewCell"];
        }
        cell.autoCorner = YES;
        [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
        cell.separatorLineView.hidden = YES;
        NSDictionary *dica = self.productInfoAry[indexPath.row];
        cell.leftL.text = dica[@"left"];
        cell.rightL.text = dica[@"right"];
        cell.rightL.textAlignment = NSTextAlignmentLeft;
        return cell;
    }else if (indexPath.section == 2){
        THBaseCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THBaseCommentTableViewCell"];
        cell.autoCorner = YES;
        [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
        [cell.bgView addSubview:self.webView];
        return cell;
    }else if (indexPath.section == 3){
        ProductDetailCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDetailCommentTableViewCell"];
        if (self.productDetailModel.appraisesListVoPage.records.count) {
            commentRecordModel *commentModel = self.commentArray[indexPath.row];
            cell.model = commentModel;
        }
        return cell;
    }else if (indexPath.section == 4){
        if (self.productDetailModel.supplyInfoGoodsVo) {
            ProductDetailStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDetailStoreCell"];
            if (self.productDetailModel) {
                cell.model = self.productDetailModel;
            }
            return cell;
        }
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell1"];
        cell.contentView.backgroundColor = KBGColor;
        return cell;
    }else {
        ProductDetailBottomRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDetailBottomRecommendCell"];
        cell.dataAry = self.dataAry;
        cell.heightBlock = ^(float height) {
            self.recommendHeight = height;
            [self.productDetailTable reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:(UITableViewRowAnimationNone)];
        };
        return cell;
    }
}

#pragma mark ================ Target-Action ================
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (_webViewHeight != [self.webView.scrollView contentSize].height) {
        _webViewHeight = [self.webView.scrollView contentSize].height;
        self.webView.frame = CGRectMake(12,12, ScreenWidth - 48, _webViewHeight);
        [self.productDetailTable reloadSections:[[NSIndexSet alloc] initWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 5) {
        return self.recommendHeight;
        return self.recommendCollection.collectionViewLayout.collectionViewContentSize.height;
    }else if (indexPath.section == 3){
        commentRecordModel *model = self.commentArray[indexPath.row];
        return model.rowHeight;
    }else if (indexPath.section == 0){
        return UITableViewAutomaticDimension;
    }else if (indexPath.section == 2){
        return _webViewHeight + 24;
    }else if (indexPath.section == 4){
        if (self.productDetailModel.supplyInfoGoodsVo) {
            return 200+76*KScreenW_Ratio;
        }
        return 0.01;
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3 && self.commentArray.count){
        return 58;
    }
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 3 && self.commentArray.count){
        ProductDetailCommentFooterView *footerV = [[ProductDetailCommentFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 58)];
        footerV.productID = self.productID;
        return footerV;
    }
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3 && self.commentArray.count){
        return 54;
    }
    if (section == 3 && self.commentArray.count == 0){
        return 89;
    }
    if (section == 1 || section == 2){
        return 12;
    }
    if (section == 4) {
        if (self.productDetailModel.supplyInfoGoodsVo) {
            return 12;
        }
    }
    if (section == 5){
        return 53;
    }
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3 && self.commentArray.count){
        ProductDetailCommentHeaderView *headerV = [[ProductDetailCommentHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 54)];
        headerV.productID = self.productID;
        headerV.detailModel = self.productDetailModel;
        return headerV;
    }
    if (section == 3 && self.commentArray.count == 0){
        ProductDetailNoCommentHeaderView *headerV = [[ProductDetailNoCommentHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 89)];
        return headerV;
    }
    if (section == 1 || section == 2){
        UIView *headerV = [[ProductDetailCommentHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
        headerV.backgroundColor = KBGColor;
        return headerV;
    }
    if (section == 4) {
        if (self.productDetailModel.supplyInfoGoodsVo) {
            UIView *headerV = [[ProductDetailCommentHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
            headerV.backgroundColor = KBGColor;
            return headerV;
        }
    }
    
    if (section == 5) {
        UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 53)];
        headerV.backgroundColor = KBGColor;
        
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 24, 96, 21)];
        imgV.centerX = headerV.centerX;
        imgV.image = IMAGE_NAMED(@"product_detail_collection_title");
        [headerV addSubview:imgV];
        return headerV;
    }
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        ProductDetailCommentViewController *vc = [[ProductDetailCommentViewController alloc]init];
        vc.productID = self.productID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1 &&indexPath.row
        == 0) {
        ProductDetailSKUViewController *vc = [[ProductDetailSKUViewController alloc]init];
        vc.model = self.productDetailModel;
        vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self  presentViewController:vc animated:NO completion:nil];
    }
    if (indexPath.section == 1 &&indexPath.row
        == 1) {
        ProductGuiGeViewController *vc = [[ProductGuiGeViewController alloc]init];
        vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        //[self  presentViewController:vc animated:NO completion:nil];
    }
}

- (void)getHomeData{
    if (!self.productDetailTable.mj_header.isRefreshing && !self.productDetailTable.mj_footer.isRefreshing) {
        [self startLoadingHUD];
    }
    [THHttpManager GET:@"goods/goodsInfo/get" parameters:@{@"goodsId":self.productID} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        [self.productDetailTable.mj_header endRefreshing];
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            ProductDetailModel *model = [ProductDetailModel mj_objectWithKeyValues:data];
            self.productDetailModel = model;
            [self.commentArray addObjectsFromArray:self.productDetailModel.appraisesListVoPage.records];
            NSLog(@"详情====%@",model.descImgs);
            [self createWebView:model.descImgs];
            self.bottomView.model = model;
            [self.productDetailTable reloadData];
            [self getSimProduct];
        }
    }];
}

- (void)getSimProduct{
    NSDictionary *dic = @{
                          @"pageNum":[NSString stringWithFormat:@"%ld",(long)self.page],
                          @"pageSize":@"10",
                          @"categoryId":[NSString stringWithFormat:@"%@",self.productDetailModel.categoryId]
    };

    [THHttpManager GET:@"goods/goodsInfo/goodsPage" parameters:dic block:^(NSInteger returnCode, THRequestStatus status, id data) {
  
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            RecordsModel *model = [RecordsModel mj_objectWithKeyValues:data];
            if (self.page == 1) {
                [self.dataAry removeAllObjects];
                [self.dataAry addObjectsFromArray:model.records];
                if (self.dataAry.count == 0) {
                    [self.productDetailTable.mj_footer endRefreshingWithNoMoreData];
                }
            }else{
                [self.dataAry addObjectsFromArray:model.records];
                if (model.records.count == 0) {
                    [self.productDetailTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [AppTool dealCollectionDataAry:self.dataAry];
            NSArray *titleAry = @[@"测试测试",@"测试测试测试测试",@"测试测试测试测试测试测试",@"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试",@"测试测试",@"测试测试",@"测试测试测试测试测试测试测试测试测试测试",@"测试",@"测试测试",@"测试测试测试测试测试测试测试测试"];
            
//            for (GoodsListVosModel *model in self.dataAry) {
//                NSInteger index = [self.dataAry indexOfObject:model];
//                model.goodsName = titleAry[index];
//            }
            [self.productDetailTable reloadData];
        }
    }];
}

- (void)createWebView:(NSString*)htmlStr
{
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    wkWebConfig.userContentController = wkUController;
    // 自适应屏幕宽度js
    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    // 添加js调用
    [wkUController addUserScript:wkUserScript];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(12, 12, self.view.frame.size.width - 48, 1) configuration:wkWebConfig];
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.opaque = NO;
    self.webView.userInteractionEnabled = NO;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.webView sizeToFit];

    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView loadHTMLString:htmlStr baseURL:nil];
}

#pragma mark - UICollectionViewDelegate - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataAry.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.dataAry[indexPath.item];
    return cell;
}
- (CGFloat)waterflowLayout:(THFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    GoodsListVosModel *model = self.dataAry[indexPath.item];
    return model.height;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsListVosModel *model = self.dataAry[indexPath.item];
    [AppTool GoToProductDetailWithID:model.goodsId];
}

- (void)initTopBtn{
    
    self.baseLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.baseLy.myHorzMargin = 0;
    self.baseLy.myHeight = 44;
    self.baseLy.backgroundColor = UIColor.clearColor;
    self.baseLy.myTop = RootStatusBarHeight;
    self.baseLy.gravity = MyGravity_Vert_Center;
    self.baseLy.padding = UIEdgeInsetsMake(0, 12, 0, 12);
    [self.view addSubview:self.baseLy];
    
    UIButton *backBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(popVC) Font:DEFAULT_FONT_R(10) Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1 BackgroundImage:@"product_detail_back" HeightLightBackgroundImage:@"product_detail_back"];
    backBtn.myWidth = backBtn.myHeight = 32;
    [self.baseLy addSubview:backBtn];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 44;
    [self.baseLy addSubview:nilView];
    
    UIButton *shareBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(shareProduct) Font:DEFAULT_FONT_R(10) Frame:CGRectMake(ScreenWidth - 12 - 32, RootStatusBarHeight + 8, 32, 32) Alignment:NSTextAlignmentCenter Tag:2 BackgroundImage:@"product_detail_share" HeightLightBackgroundImage:@"product_detail_share"];
    shareBtn.myWidth = shareBtn.myHeight = 32;
    [self.baseLy addSubview:shareBtn];
}

- (void)shareProduct{
    ProductShareViewController *vc = [[ProductShareViewController alloc]init];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    GoodsListVosModel *model = [[GoodsListVosModel alloc]init];
    model.commission = self.productDetailModel.commission;
    model.goodsId = self.productDetailModel.goodsId;
    model.goodsName = self.productDetailModel.goodsName;
    if (self.productDetailModel.productImgAry.count) {
        model.goodsThumb = self.productDetailModel.productImgAry[0];
    }
    model.marketPrice = self.productDetailModel.marketPrice;
    model.saleCount = self.productDetailModel.saleCount;
    model.salePrice = self.productDetailModel.salePrice;
    vc.model = model;
    [[AppTool currentVC] presentViewController:vc animated:NO completion:nil];
}

- (void)initTopView{
    
    UIView *topV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, RootStatusBarHeight + 44)];
    topV.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:topV];
    self.topView = topV;
    self.topView.alpha = 0;
    
    self.topSelectView = [[ProductDetailTopSelectView alloc]initWithFrame:CGRectMake(80, KStatusBarHeight, ScreenWidth - 160, 44)];
    [topV addSubview:self.topSelectView];
    
    UIButton *backBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(popVC) Font:DEFAULT_FONT_R(10) Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"return" HeightLightBackgroundImage:@"return"];
    backBtn.myWidth = backBtn.myHeight = 24;
    backBtn.frame =CGRectMake(10, KStatusBarHeight + 10, 24, 24);
    [topV addSubview:backBtn];
    
    UIButton *shareBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(shareProduct) Font:DEFAULT_FONT_R(10) Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:2 BackgroundImage:@"product_detail_bar_share" HeightLightBackgroundImage:@"product_detail_bar_share"];
    shareBtn.myWidth = shareBtn.myHeight = 32;
    shareBtn.frame = CGRectMake(ScreenWidth - 42, KStatusBarHeight + 7, 30, 30);
    [topV addSubview:shareBtn];
    
    CJWeakSelf()
    self.topSelectView.selectBlock = ^(NSInteger index) {
        
        CJStrongSelf()
        self.topClick = YES;
        NSInteger section = 0;
        switch (index) {
            case 0:
                section = 0;
                break;
            case 1:
                section = 2;
                break;
            case 2:
                section = 3;
                break;
            case 3:
                section = 5;
                break;
                
            default:
                break;
        }
        CGRect rect = [self.productDetailTable rectForHeaderInSection:section];
        if (section == 0) {
            self.productDetailTable.contentOffset = CGPointMake(0,0.01);
        }else{
            self.productDetailTable.contentOffset = CGPointMake(0,rect.origin.y);
        }
    };
    
}
- (void)createRightBtnView{
    
    UIButton *zhiding = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(rightBtnClicked:) Font:DEFAULT_FONT_R(10) Frame:CGRectMake(ScreenWidth - 17 - 58, ScreenHeight - self.bottomView.height - 78, 58, 58) Alignment:NSTextAlignmentCenter Tag:10 BackgroundImage:@"home_detail_zhiding" HeightLightBackgroundImage:@"home_detail_zhiding"];
    [self.view addSubview:zhiding];
}
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index{
    
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[self class]] || [viewController isKindOfClass:[MerchantDetailBaseViewController class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

@end


@implementation ProductDetailTopSelectView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    float jiange = (self.frame.size.width - 40*4)/3.0;
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 5, 30, 2)];
    lineV.backgroundColor = KMainBGColor;
    lineV.hidden = YES;
    [self addSubview:lineV];
    self.lineView = lineV;
    
    NSArray *titleAry = @[@"商品",@"详情",@"评价",@"推荐"];
    for (int i = 0 ; i < 4; i ++) {
        UILabel *title = [UILabel creatLabelWithTitle:titleAry[i] textColor:KBlack666TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(13)];
        title.frame = CGRectMake((jiange + 40)*i, 0, 40, 40);
        title.tag = 100 +i;
        [self addSubview:title];
        
        title.userInteractionEnabled = YES;
        [title addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)]];
    }
}

- (void)tapClick:(UITapGestureRecognizer *)gest{
    UILabel *title = (UILabel *)gest.view;
    NSArray *titleAry = @[@"商品",@"详情",@"评价",@"推荐"];
    NSLog(@"点击了---%@",titleAry[title.tag - 100]);
    if (_selectBlock) {
        _selectBlock(title.tag - 100);
    }
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    for (int i =0; i < 4; i ++) {
        UILabel *titleL = [self viewWithTag:100+i];
        titleL.textColor = i == selectIndex ? KMaintextColor : KBlack333TextColor;
        if (i == selectIndex) {
            self.lineView.hidden = NO;
            self.lineView.centerX = titleL.centerX;
            titleL.font = DEFAULT_FONT_M(13);
        }
    }
}

@end


//
//  HomeBaseViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/3/28.
//

#import "HomeBaseViewController.h"
#import "HomeViewController.h"
#import "HomeOtherViewController.h"
#import "MessageViewController.h"
#import "HomeCategoryViewController.h"
#import "HomeDataModel.h"

@interface HomeBaseViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) UIImageView *topBackView;
@property (strong, nonatomic) UIButton *allBtn;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;//菜单标题view
@property (nonatomic, strong) JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong) NSMutableArray <NSString *> *titles;
@property (nonatomic, strong)HomeDataModel *dataModel;
@property (nonatomic, strong)HomeViewController *firstVC;
@property (nonatomic, strong)HomeOtherViewController *secondVC;

@end

@implementation HomeBaseViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
}
- (void)initView{

    self.firstVC = [[HomeViewController alloc]init];
    self.secondVC = [[HomeOtherViewController alloc]init];
    
    self.topBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight + 44)];
    self.topBackView.image = IMAGE_NAMED(@"home_bg_top");
    self.topBackView.userInteractionEnabled = YES;
    [self.view addSubview:self.topBackView];
    
    BaseSearchNavBarView *bar = [[BaseSearchNavBarView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight)];
    bar.hiddenBackBtn = YES;
    bar.btnAry = @[@"home_message_image"];
    [self.topBackView addSubview:bar];
    bar.viewClickBlock = ^(NSInteger index, NSString * _Nonnull searchStr) {
        if (index == 1) {
            MessageViewController *vc = [[MessageViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{

        }
    };
    
    UIView *categoryV = [[UIView alloc] initWithFrame:CGRectMake(0, KNavBarHeight, ScreenWidth, 44)];
    categoryV.backgroundColor = UIColor.clearColor;
    [self.topBackView addSubview:categoryV];
    
    MyLinearLayout *categoryLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    categoryLy.myHorzMargin = 10;
    categoryLy.myHeight = 43;
    categoryLy.myTop = 0;
    categoryLy.gravity = MyGravity_Vert_Center;
    categoryLy.backgroundColor = UIColor.clearColor;
    categoryLy.layer.cornerRadius = 12;
    categoryLy.layer.masksToBounds = YES;
    [categoryV addSubview:categoryLy];

    self.titles = [@[@"首页"] mutableCopy];
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
    self.categoryView.weight = 1;
    self.categoryView.myHeight = 43;
    self.categoryView.titles = self.titles;
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = UIColor.whiteColor;
    self.categoryView.titleColor = UIColor.whiteColor;
    self.categoryView.titleSelectedFont = DEFAULT_FONT_M(16);
    self.categoryView.titleFont = DEFAULT_FONT_R(15);
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.backgroundColor = UIColor.clearColor;
    self.categoryView.myWidth = ScreenWidth - 10 - 72;
    [categoryLy addSubview:self.categoryView];
    
    self.allBtn = [BaseButton CreateBaseButtonTitle:@"全部" Target:self Action:@selector(allCategory) Font:[UIFont systemFontOfSize:15] BackgroundColor:UIColor.clearColor Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:2];
    self.allBtn.myWidth = 60;
    self.allBtn.myHeight = 25;
    [self.allBtn setImage:IMAGE_NAMED(@"home_allType_image") forState:UIControlStateNormal];
    [categoryLy addSubview:self.allBtn];
    
    self.lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.lineView.indicatorColor = UIColor.whiteColor;
    self.lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
    self.categoryView.indicators = @[self.lineView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
//    [self.listContainerView addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];
    self.categoryView.listContainer = self.listContainerView;
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);

    [self getHomeData];
}

- (void)getHomeData{
    [self startLoadingHUD];
    [THHttpManager GET:@"goods/shopBlockDefine/home" parameters:@{} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            HomeDataModel *model = [HomeDataModel mj_objectWithKeyValues:data];
            self.dataModel = model;
            NSMutableArray *array =[NSMutableArray arrayWithObject:@"首页"];
            for (int i =0; i< model.goodsCategoryListVos.count; i ++) {
                GoodsCategoryListVosModel *categoryModel = model.goodsCategoryListVos[i];
                [array addObject:categoryModel.categoryName];
            }
            self.titles = array;
            self.categoryView.titles = self.titles;
        
            self.firstVC.dataModel = model;
            self.secondVC.dataModel = model;
            [self.categoryView reloadData];
        }
        if (self.titles.count == 1 && [self.titles containsObject:@"首页"]) {
          
        }
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.categoryView.frame = CGRectMake(0, 0, ScreenWidth, 44);
    self.listContainerView.frame = CGRectMake(0, KNavBarHeight + 44, ScreenWidth, ScreenHeight - KTabBarHeight - KNavBarHeight - 44);
}
- (void)allCategory{
    HomeCategoryViewController *vc = [[HomeCategoryViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - JXPagingViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    if (index == 0) {
        return self.firstVC;
    }else{
        HomeOtherViewController *vc = [[HomeOtherViewController alloc]init];
        vc.index = index;
        vc.dataModel = self.dataModel;
        self.secondVC = vc;
        return vc;
    }
}
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end

//
//  myOrderViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/8.
//

#import "myOrderViewController.h"
#import "myOrderListContentViewController.h"
#import "BaseSearchView.h"
#import "MyOrderListZiYingContentViewController.h"

@interface myOrderViewController ()<UINavigationControllerDelegate,JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;//菜单标题view
@property (nonatomic, strong) JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@property (nonatomic, copy)NSString *typeStatus;

@end

@implementation myOrderViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.delegate = self;
    self.navigationItem.title = @"自营订单";
    
    self.view.backgroundColor = KBGColor;
    
    BaseSearchView *searchV = [[BaseSearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    searchV.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:searchV];
    
    UIView *categoryV = [[UIView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, 42)];
    categoryV.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:categoryV];
    
    MyLinearLayout *categoryLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    categoryLy.myHorzMargin = 0;
    categoryLy.myHeight = 42;
    categoryLy.myTop = 0;
    categoryLy.gravity = MyGravity_Horz_Left;
    categoryLy.backgroundColor = UIColor.whiteColor;
    categoryLy.layer.cornerRadius = 12;
    categoryLy.layer.masksToBounds = YES;
    [categoryV addSubview:categoryLy];
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
    self.categoryView.weight = 1;
    self.categoryView.myHeight = 42;
    self.categoryView.titles = @[@"全部",@"待付款",@"待发货",@"待收货",@"售后",@"已完成"];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = KMaintextColor;
    self.categoryView.titleColor = KBlack333TextColor;
    self.categoryView.titleSelectedFont = DEFAULT_FONT_M(16);
    self.categoryView.titleFont = DEFAULT_FONT_R(15);
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.backgroundColor = UIColor.clearColor;
    self.categoryView.defaultSelectedIndex = self.orderType == myOrderTypeWaitingAllOrder ? 0: self.orderType + 1;
    [categoryLy addSubview:self.categoryView];
    
    self.lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.lineView.indicatorColor = UIColor.redColor;
    self.lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
    self.categoryView.indicators = @[self.lineView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    [self.view addSubview:self.listContainerView];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(categoryLy.mas_bottom).offset(5);
    }];
    self.categoryView.listContainer = self.listContainerView;
}

#pragma mark - JXPagingViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    MyOrderListZiYingContentViewController *vc = [[MyOrderListZiYingContentViewController alloc]init];
    vc.index = index;
    return vc;
}

-(NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 6;
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
  
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


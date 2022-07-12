//
//  MyOrderTypeViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/27.
//

#import "MyOrderTypeViewController.h"
#import "ContentViewController.h"
#import "BaseSearchView.h"

@interface MyOrderTypeViewController ()<UINavigationControllerDelegate,JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;//菜单标题view
@property (nonatomic, strong) JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, copy) NSString *searchStr;

@end

@implementation MyOrderTypeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.delegate = self;
    self.view.backgroundColor = KBGColor;
    self.searchStr = @"";
    
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    bgV.backgroundColor = KWhiteBGColor;
    [self.view addSubview:bgV];
    
    BaseSearchView *searchV = [[BaseSearchView alloc] initWithFrame:CGRectMake(0, 4, ScreenWidth, 40)];
    searchV.fieldEnabled = YES;
    searchV.searchV.backgroundColor = KWhiteBGColor;

    NSAttributedString *attrString = [[NSAttributedString alloc]initWithString:@"请输入订单号/手机号/收货人姓名" attributes:@{NSForegroundColorAttributeName:KBlack666TextColor,NSFontAttributeName:searchV.searchField.font}];
    searchV.searchField.attributedPlaceholder = attrString;
    
    searchV.leftSearchImgv.image = IMAGE_NAMED(@"放大镜_black");
    searchV.viewClickBlock = ^(NSInteger index, NSString * _Nonnull searchStr) {
        NSLog(@"%@",searchStr);
        if (![self.searchStr isEqualToString:searchStr]) {
            self.searchStr = searchStr;
            [self.categoryView reloadData];
        }
    };
    searchV.backgroundColor = UIColor.whiteColor;
    [bgV addSubview:searchV];
    [self.view bringSubviewToFront:bgV];
    
    UIView *categoryV = [[UIView alloc] initWithFrame:CGRectMake(0,44, ScreenWidth , 42)];
    categoryV.backgroundColor = KWhiteBGColor;
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
    //@"售后"
    self.categoryView.titles = @[@"全部",@"待付款",@"待发货",@"待收货",@"已完成"];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = KMaintextColor;
    self.categoryView.titleColor = KBlack333TextColor;
    self.categoryView.titleSelectedFont = DEFAULT_FONT_M(16);
    self.categoryView.titleFont = DEFAULT_FONT_R(15);
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.backgroundColor = UIColor.clearColor;
    self.categoryView.defaultSelectedIndex = self.index + 1;
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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#pragma mark - JXPagingViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    ContentViewController *vc = [[ContentViewController alloc]init];
    vc.isShouhou = self.isShouhou;
    vc.type = self.type;
    vc.orderIndex = index;
    vc.keyword = self.searchStr;
    return vc;
}

-(NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 5;
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
  
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SetIOS13;
    [navigationController setNavigationBarHidden:YES animated:YES];
}

- (UIView *)listView {
    return self.view;
}

@end

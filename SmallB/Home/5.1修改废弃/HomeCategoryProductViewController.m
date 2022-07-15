//
//  HomeCategoryProductViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/22.
//

#import "HomeCategoryProductViewController.h"
#import "HomeCategoryProductContentVC.h"

@interface HomeCategoryProductViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;//菜单标题view
@property (nonatomic, strong) JXCategoryIndicatorLineView *lineView;
@property (strong, nonatomic) UIView *topBackView;
@property (strong, nonatomic) UIButton *allBtn;

@end

@implementation HomeCategoryProductViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initView{
    
    self.topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight + 44)];
    self.topBackView.backgroundColor = [UIColor bm_colorGradientChangeWithSize:self.topBackView.size direction:IHGradientChangeDirectionLevel startColor:KJianBianBGColor endColor:KMainBGColor];
    [self.topBackView removeFromSuperview];
    [self.view addSubview:self.topBackView];
    
    BaseSearchNavBarView *bar = [[BaseSearchNavBarView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight)];
    [self.topBackView addSubview:bar];

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

    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
    self.categoryView.weight = 1;
    self.categoryView.myHeight = 43;
    self.categoryView.titles = @[@"商品",@"评价",@"推荐",@"详情",@"商品",@"评价",@"推荐",@"详情",@"商品",@"评价",@"推荐",@"详情"];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = UIColor.whiteColor;
    self.categoryView.titleColor = UIColor.whiteColor;
    self.categoryView.titleSelectedFont = DEFAULT_FONT_M(16);
    self.categoryView.titleFont = DEFAULT_FONT_R(15);
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.backgroundColor = UIColor.clearColor;
    self.categoryView.frame = CGRectMake(0, 0, ScreenWidth, 40);
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
    self.listContainerView.frame = CGRectMake(0,  KNavBarHeight + 44, ScreenWidth, ScreenHeight - KNavBarHeight - 44);
    [self.view addSubview:self.listContainerView];
    self.categoryView.listContainer = self.listContainerView;
}

- (void)allCategory{
    
}

#pragma mark - JXPagingViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    return [[HomeCategoryProductContentVC alloc] init];
}
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 12;
}
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {

}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)backClcik{
    [self.navigationController popViewControllerAnimated:YES];
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

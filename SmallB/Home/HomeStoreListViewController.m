//
//  HomeStoreListViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/28.
//

#import "HomeStoreListViewController.h"
#import "HomeCategoryProductContentVC.h"
#import "HomeStoreContentViewController.h"
#import "HomeStoreAllTypeView.h"

@interface HomeStoreListViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;//菜单标题view
@property (nonatomic, strong) JXCategoryIndicatorLineView *lineView;
@property (strong, nonatomic) UIView *topBackView;
@property (strong, nonatomic) UIButton *allBtn;
@property (strong, nonatomic) NSMutableArray *titleAry;
@property (strong, nonatomic) HomeStoreAllTypeView *typeView;
@property (strong, nonatomic) HomeStoreContentViewController *contentVC;

@property (assign, nonatomic)NSInteger selectIndex;
@property (assign, nonatomic)NSString *selectTypeStr;

@end

@implementation HomeStoreListViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectIndex = 0;
    self.selectTypeStr = @"商品";
    self.contentVC = [[HomeStoreContentViewController alloc]init];
    [self creatSubViews];
}

- (void)creatSubViews{
    
    self.topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight + 44)];
    self.topBackView.backgroundColor = KWhiteBGColor;
    [self.view addSubview:self.topBackView];
    
    BaseSearchNavBarView *bar = [[BaseSearchNavBarView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight)];
    [bar.backBtn setImage:IMAGE_NAMED(@"back") forState:UIControlStateNormal];
    bar.searchBtn.titleLabel.textColor = KMaintextColor;
    [bar.searchBtn setTitleColor:KMaintextColor forState:UIControlStateNormal];
    bar.searchView.layer.borderWidth = .5;
    bar.searchView.layer.borderColor = KMainBGColor.CGColor;
    bar.searchField.placeholder = @"搜索店铺名称";
    bar.searchImgV.image = IMAGE_NAMED(@"放大镜_black");
    bar.fieldEnabled = YES;
    CJWeakSelf()
    bar.viewClickBlock = ^(NSInteger index, NSString * _Nonnull searchStr) {
        CJStrongSelf();
        self.contentVC.searchStr = searchStr;
    };
    [self.topBackView addSubview:bar];

    UIView *categoryV = [[UIView alloc] initWithFrame:CGRectMake(0, KNavBarHeight, ScreenWidth, 44)];
    categoryV.backgroundColor = UIColor.clearColor;
    [self.topBackView addSubview:categoryV];
    
    MyLinearLayout *categoryLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    categoryLy.myHorzMargin = 10;
    categoryLy.myHeight = 44;
    categoryLy.myTop = 0;
    categoryLy.gravity = MyGravity_Vert_Center;
    categoryLy.backgroundColor = UIColor.clearColor;
    categoryLy.layer.cornerRadius = 12;
    categoryLy.layer.masksToBounds = YES;
    [categoryV addSubview:categoryLy];

    self.titleAry = [@[@"商品",@"女装",@"男装",@"男装",@"商品",@"女装",@"男装",@"男装",@"商品",@"女装",@"男装",@"男装",@"商品",@"女装",@"男装",@"男装"] mutableCopy];
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
    self.categoryView.weight = 1;
    self.categoryView.myHeight = 44;
    self.categoryView.titles = self.titleAry;
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = KMaintextColor;
    self.categoryView.titleColor = KBlack333TextColor;
    self.categoryView.titleSelectedFont = DEFAULT_FONT_M(16);
    self.categoryView.titleFont = DEFAULT_FONT_R(15);
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.backgroundColor = UIColor.clearColor;
    self.categoryView.frame = CGRectMake(0, 0, ScreenWidth, 44);
    self.categoryView.myWidth = ScreenWidth - 10 - 72;
    [categoryLy addSubview:self.categoryView];
    
    self.allBtn = [BaseButton CreateBaseButtonTitle:@"分类" Target:self Action:@selector(allCategory:) Font:[UIFont systemFontOfSize:15] BackgroundColor:UIColor.clearColor Color:KBlack333TextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:2];
    self.allBtn.myWidth = 60;
    self.allBtn.myHeight = 25;
    [self.allBtn setImage:IMAGE_NAMED(@"arrow_bottom_image") forState:UIControlStateNormal];
    [self.allBtn layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyleRight) imageTitleSpace:15];
    [categoryLy addSubview:self.allBtn];
    
    self.lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.lineView.indicatorColor = KMaintextColor;
    self.lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
    self.categoryView.indicators = @[self.lineView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.listContainerView.frame = CGRectMake(0,  KNavBarHeight + 44, ScreenWidth, ScreenHeight - KNavBarHeight - 44);
    [self.view addSubview:self.listContainerView];
    self.categoryView.listContainer = self.listContainerView;
    
    self.typeView = [[HomeStoreAllTypeView alloc]initWithFrame:CGRectMake(0, KNavBarHeight + 44, ScreenWidth, ScreenHeight - KNavBarHeight - 44)];
    self.typeView.titleAry = self.titleAry;
    self.typeView.typeStr = self.selectTypeStr;
    self.typeView.index = self.selectIndex;
    self.typeView.btnClickBlock = ^(NSInteger index, NSString * _Nonnull typeStr) {
        CJStrongSelf()
        if (self.selectIndex != index) {
            self.typeView.hidden = YES;
            self.selectTypeStr = typeStr;
            self.selectIndex = index;
            self.categoryView.defaultSelectedIndex = index;
        }
    };
    [self.view addSubview:self.typeView];
    self.typeView.hidden = YES;
}

- (void)allCategory:(BaseButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        btn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    }else{
        btn.imageView.transform = CGAffineTransformIdentity;
    }
    self.typeView.hidden = !btn.selected;
}

#pragma mark - JXPagingViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    return self.contentVC;
}
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titleAry.count;
}
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.selectIndex = index;
    self.selectTypeStr = self.titleAry[index];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
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

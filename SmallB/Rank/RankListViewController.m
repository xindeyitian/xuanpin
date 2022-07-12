//
//  RankListViewController.m
//  SmallB
//
//  Created by 张昊男 on 2022/4/1.
//

#import "RankListViewController.h"
#import "RankListContentViewController.h"

@interface RankListViewController ()<UINavigationControllerDelegate,JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;//菜单标题view
@property (nonatomic, strong) JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@end

@implementation RankListViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    
    XHPageControl  *_pageControl = [[XHPageControl alloc] initWithFrame:CGRectMake(0, 300,[UIScreen mainScreen].bounds.size.width, 30)];
    _pageControl.numberOfPages = 7;
    _pageControl.otherMultiple = 1;
    _pageControl.currentMultiple = 2;
    _pageControl.type = PageControlMiddle;
    _pageControl.otherColor=[UIColor grayColor];
    _pageControl.currentColor=[UIColor orangeColor];
    _pageControl.delegate = self;
    _pageControl.tag = 902;
    //[self.view addSubview:_pageControl];

    [self creatTopImgV];
}

- (void)creatTopImgV{
    
    UIImageView *topimgV = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"tab_rank")];
    [self.view addSubview:topimgV];
    [topimgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(179 * KScreenW_Ratio);
    }];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textColor = KWhiteTextColor;
    titleLable.font = BOLD_FONT_R(18);
    titleLable.text = @"小莲云仓榜单";
    titleLable.textAlignment = NSTextAlignmentCenter;
    [topimgV addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLable.superview).offset(50);
        make.right.mas_equalTo(titleLable.superview).offset(-50);
        make.top.mas_equalTo(titleLable.superview).offset(KStatusBarHeight+7);
        make.height.mas_equalTo(30);
    }];
    
    UIView *whiteBGView = [[UIView alloc]init];
    whiteBGView.backgroundColor = KWhiteBGColor;
    ViewBorderRadius(whiteBGView, 5, 1, [UIColor clearColor]);
    [self.view addSubview:whiteBGView];
    [whiteBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(12);
        make.right.mas_equalTo(self.view).offset(-12);
        make.top.mas_equalTo(topimgV.mas_bottom).offset(-20);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    UIView *categoryV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-24, 42)];
    categoryV.backgroundColor = UIColor.clearColor;
    [whiteBGView addSubview:categoryV];
    
    MyLinearLayout *categoryLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    categoryLy.myHorzMargin = 0;
    categoryLy.myHeight = 42;
    categoryLy.myTop = 0;
    categoryLy.gravity = MyGravity_Horz_Left;
    categoryLy.backgroundColor = UIColor.clearColor;
    categoryLy.layer.cornerRadius = 12;
    categoryLy.layer.masksToBounds = YES;
    [categoryV addSubview:categoryLy];
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
    self.categoryView.weight = 1;
    self.categoryView.myHeight = 42;
    self.categoryView.titles = @[@"今日热销榜",@"今日积分榜",@"热销总榜"];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = kRGB(250, 23, 45);
    self.categoryView.titleColor = KBlack333TextColor;
    self.categoryView.titleSelectedFont = DEFAULT_FONT_M(16);
    self.categoryView.titleFont = DEFAULT_FONT_R(15);
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.backgroundColor = UIColor.clearColor;
    [categoryLy addSubview:self.categoryView];
    
    self.lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.lineView.indicatorColor = UIColor.redColor;
    self.lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
    self.categoryView.indicators = @[self.lineView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    [whiteBGView addSubview:self.listContainerView];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(whiteBGView);
        make.top.mas_equalTo(categoryLy.mas_bottom).offset(5);
    }];
    self.categoryView.listContainer = self.listContainerView;
}

#pragma mark - JXPagingViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    RankListContentViewController *vc = [[RankListContentViewController alloc]init];
    vc.index = index;
    return vc;
}

-(NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 3;
}
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
  
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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

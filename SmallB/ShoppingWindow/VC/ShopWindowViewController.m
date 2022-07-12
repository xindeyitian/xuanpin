//
//  ShopWindowViewController.m
//  SmallB
//
//  Created by 张昊男 on 2022/4/1.
//

#import "ShopWindowViewController.h"
#import "shopWindowContentVC.h"

@interface ShopWindowViewController ()<UINavigationControllerDelegate,JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>
{
    BaseButton *_selectBtn;
}
@property(nonatomic,strong)UIView *topBackView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;//菜单标题view
@property (nonatomic, strong) JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property(nonatomic,copy)NSString *searchStr;

@end

@implementation ShopWindowViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.searchStr = @"";

    self.topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight + 10)];
    self.topBackView.backgroundColor = KMainBGColor;
    [self.view addSubview:self.topBackView];
    [self.view sendSubviewToBack:self.topBackView];
    
    self.view.backgroundColor = KBlackLineColor;
    //标题
    UIView *productV = [[UIView alloc] initWithFrame:CGRectMake(0, KNavBarHeight, ScreenWidth, 45)];
    productV.backgroundColor = KWhiteBGColor;
    [self.view addSubview:productV];
    
    NSArray *titleAry = @[@"云仓产品",@"自营产品"];
    for (int i =0; i < 2; i ++) {
        BaseButton *btn = [BaseButton CreateBaseButtonTitle:titleAry[i] Target:self Action:@selector(btnClick:) Font:DEFAULT_FONT_R(16) BackgroundColor:UIColor.clearColor Color:KBlack999TextColor Frame:CGRectMake( i == 0 ? 34*KScreenW_Ratio: ScreenWidth - 164*KScreenW_Ratio, 5, 130*KScreenW_Ratio, 35) Alignment:NSTextAlignmentCenter Tag:50+i];
        [btn setTitleColor:KMaintextColor forState:UIControlStateSelected];
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = 17.5;
        if (i == 0) {
            btn.backgroundColor = KBlackLineColor;
            _selectBtn = btn;
            _selectBtn.selected = YES;
        }
        [productV addSubview:btn];
    }
    //分类
    UIView *categoryV = [[UIView alloc] initWithFrame:CGRectMake(0, KNavBarHeight+45, ScreenWidth, 42)];
    categoryV.backgroundColor = KWhiteBGColor;
    [self.view addSubview:categoryV];
    
    MyLinearLayout *categoryLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    categoryLy.myHorzMargin = 0;
    categoryLy.myHeight = 40;
    categoryLy.myTop = 10;
    categoryLy.gravity = MyGravity_Horz_Left;
    categoryLy.backgroundColor = UIColor.whiteColor;
    categoryLy.layer.cornerRadius = 12;
    categoryLy.layer.masksToBounds = YES;
    [categoryV addSubview:categoryLy];
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
    self.categoryView.weight = 1;
    self.categoryView.myHeight = 40;
    self.categoryView.titles = @[@"销售中",@"已下架"];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = KMaintextColor;
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
    [self.view addSubview:self.listContainerView];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(categoryLy.mas_bottom).offset(5);
    }];
    self.categoryView.listContainer = self.listContainerView;
    
    self.nav.searchField.placeholder = @"可搜索本店商品";
    self.fieldEnabled  = YES;
    self.nav.viewClickBlock = ^(NSInteger index, NSString * _Nonnull searchStr) {
        NSLog(@"%@",searchStr);
        self.searchStr = searchStr;
        [self.categoryView reloadData];
    };
}

- (void)btnClick:(BaseButton *)btn{
    if (_selectBtn.tag != btn.tag) {
        btn.selected = !btn.selected;
        btn.backgroundColor = KBlackLineColor;
        _selectBtn.selected = NO;
        _selectBtn.backgroundColor = UIColor.clearColor;
        _selectBtn = btn;
        if (_selectBtn.tag == 50) {
            self.categoryView.titles = @[@"销售中",@"已下架"];
        }else{
            self.categoryView.titles = @[@"销售中",@"审核中",@"已下架"];
//            self.categoryView.titles = @[@"销售中",@"审核中",@"已下架",@"草稿箱"];
        }
        self.categoryView.defaultSelectedIndex = 0;
        [self.categoryView reloadData];
    }
}

#pragma mark - JXPagingViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    shopWindowContentVC *vc = [[shopWindowContentVC alloc]init];
    vc.index = index;
    vc.shopType = _selectBtn.tag - 50;
    vc.searchStr = self.searchStr;
    return vc;
}

-(NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return _selectBtn.tag == 50 ? 2:3;
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    shopWindowContentVC *vc = [[shopWindowContentVC alloc]init];
    vc.index = index;
    vc.shopType = _selectBtn.tag - 50;
    vc.searchStr = self.searchStr;
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

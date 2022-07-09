//
//  MyNewOrderViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/27.
//

#import "MyNewOrderViewController.h"
#import "MyOrderTypeViewController.h"

@interface MyNewOrderViewController ()<UINavigationControllerDelegate,JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>
{
    UIImageView *navBarHairlineImageView;
}
@property (nonatomic, strong) NSArray *titleAry;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;//菜单标题view
@property (nonatomic, strong) JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@end

@implementation MyNewOrderViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //navBarHairlineImageView.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
 }

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.delegate = self;
    self.view.backgroundColor = KWhiteBGColor;
    
    UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight)];
    whiteV.backgroundColor = KWhiteBGColor;
//    whiteV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:whiteV];
    
    BaseButton *btn= [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(backClick) Font:DEFAULT_FONT_R(10) Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"back" HeightLightBackgroundImage:@"back"];
    btn.frame = CGRectMake(0, KStatusBarHeight, 44, 44);
    btn.backgroundColor = KWhiteBGColor;
    [whiteV addSubview:btn];
    
    UIView *categoryV = [[UIView alloc] initWithFrame:CGRectMake(60,KStatusBarHeight , ScreenWidth - 120, 44)];
    categoryV.backgroundColor = KWhiteBGColor;
    [whiteV addSubview:categoryV];
    
    MyLinearLayout *categoryLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    categoryLy.myHorzMargin = 0;
    categoryLy.myHeight = 44;
    categoryLy.myTop = 0;
    categoryLy.gravity = MyGravity_Horz_Left;
    categoryLy.backgroundColor = KWhiteBGColor;
    categoryLy.layer.cornerRadius = 12;
    categoryLy.layer.masksToBounds = YES;
    [categoryV addSubview:categoryLy];
    //@"自营订单"  @"云仓订单"
    self.titleAry = @[@"云仓订单"];
    if ([AppTool getCurrentLevalIsAdd]) {
        self.titleAry = @[@"云仓订单",@"自营订单"];
    }
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
    self.categoryView.weight = 1;
    self.categoryView.myHeight = 44;
    self.categoryView.titles = self.titleAry;
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = KMaintextColor;
    self.categoryView.titleColor = KBlack333TextColor;
    self.categoryView.titleSelectedFont = DEFAULT_FONT_M(17);
    self.categoryView.titleFont = DEFAULT_FONT_R(15);
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.backgroundColor = KWhiteBGColor;
    [categoryLy addSubview:self.categoryView];
    
    self.lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.lineView.indicatorColor = UIColor.redColor;
    self.lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
    if (self.titleAry.count > 1) {
        self.categoryView.indicators = @[self.lineView];
        self.categoryView.titleSelectedColor = KMaintextColor;
        self.categoryView.titleColor = KBlack333TextColor;
        self.categoryView.titleSelectedFont = DEFAULT_FONT_M(17);
        self.categoryView.titleFont = DEFAULT_FONT_R(15);
    }else{
        self.categoryView.titleSelectedColor = KBlack333TextColor;
        self.categoryView.titleColor = KBlack333TextColor;
        self.categoryView.titleSelectedFont = DEFAULT_FONT_M(17);
        self.categoryView.titleFont = DEFAULT_FONT_M(17);
    }
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    [self.view addSubview:self.listContainerView];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(categoryLy.mas_bottom).offset(5);
    }];
    self.categoryView.listContainer = self.listContainerView;
}

- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - JXPagingViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    MyOrderTypeViewController *vc = [[MyOrderTypeViewController alloc]init];
    vc.isShouhou = self.isShouhou;;
    vc.orderType = self.orderType;
    vc.index = self.index;
    if (self.titleAry.count == 1 && [self.titleAry containsObject:@"云仓订单"]) {
        vc.type = 1;
    }else  if (self.titleAry.count == 1 && [self.titleAry containsObject:@"自营订单"]) {
        vc.type = 2;
    }else{
        vc.type = index + 1;
    }
    return vc;
}

-(NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titleAry.count;
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
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}

@end


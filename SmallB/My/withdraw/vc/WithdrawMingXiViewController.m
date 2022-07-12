//
//  WithdrawMingXiViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/25.
//

#import "WithdrawMingXiViewController.h"
#import "MingXiContentViewController.h"
#import "withdrawShaixuanView.h"

@interface WithdrawMingXiViewController ()

@property (nonatomic, strong) JXCategoryTitleView *categoryView;//菜单标题view
@property (nonatomic, strong) JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property(nonatomic , strong)withdrawShaixuanView *shaixuanView;
@property(nonatomic , strong)MingXiContentViewController *currentVC;

@property(nonatomic , strong)UIControl *controL;

@property(nonatomic , copy)NSString *startTime;
@property(nonatomic , copy)NSString *endTime;

@end

@implementation WithdrawMingXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"收益明细";
    self.startTime = self.endTime = @"";

    self.view.backgroundColor = KBGColor;
    
    UIView *categoryV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 42)];
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
    self.categoryView.titles = @[@"货款收益",@"收益明细"];
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
    
    UIControl *contro = [[UIControl alloc]init];
    [self.view addSubview:contro];
    self.controL = contro;
    [contro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(12);
        make.top.mas_equalTo(self.view).offset(42);
        make.height.mas_equalTo(44);
    }];
    UILabel *lable = [UILabel creatLabelWithTitle:@"日期" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(15)];
    [contro addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contro).offset(10);
        make.left.mas_equalTo(contro).offset(12);
        make.height.mas_equalTo(24);
    }];
    
    UIImageView *imgv = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"arrow_bottom_image")];
    [contro addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lable.mas_right).offset(8);
        make.height.width.mas_equalTo(16);
        make.centerY.mas_equalTo(lable.centerY);
        make.right.mas_equalTo(contro).offset(-8);
    }];
    [contro addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.shaixuanView = [[withdrawShaixuanView alloc]initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight)];
    self.shaixuanView.hiddenStatus = YES;
    CJWeakSelf()
    self.shaixuanView.cancelBlock = ^{
        CJStrongSelf()
        self.controL.selected = !self.controL.selected;
    };
    self.shaixuanView.confirmBlock = ^(NSString * _Nonnull startTime, NSString * _Nonnull endTime, NSString * _Nonnull type) {
        CJStrongSelf()
        lable.text = [NSString stringWithFormat:@"%@ - %@",[startTime stringByReplacingOccurrencesOfString:@"-" withString:@":"],[endTime stringByReplacingOccurrencesOfString:@"-" withString:@":"]];
        if (startTime.length == 0 && endTime.length == 0) {
            lable.text = @"日期";
        }
        self.startTime = startTime;
        self.endTime = endTime;
        self.controL.selected = !self.controL.selected;
        [self.categoryView reloadData];
    };
}

- (void)btnClick:(UIControl *)contro{
    contro.selected = !contro.selected;
    if (contro.selected) {
        [self.shaixuanView show];
    }else{
        [self.shaixuanView dismiss];
    }
}

#pragma mark - JXPagingViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    self.currentVC = [[MingXiContentViewController alloc]init];
    self.currentVC.typeIndex = index + 2;
    self.currentVC.startTime = self.startTime;
    self.currentVC.endTime = self.endTime;
    return self.currentVC;
}

-(NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 2;
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


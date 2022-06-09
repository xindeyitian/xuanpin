//
//  ColonelCodeViewController.m
//  SmallB
//
//  Created by 张昊男 on 2022/4/1.
//

#import "ColonelCodeViewController.h"
#import "TuanCodeContentViewController.h"
#import "BuyTuanCodeViewController.h"
#import "TuanNumModel.h"

@interface ColonelCodeViewController ()<UINavigationControllerDelegate,JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property(nonatomic,strong)UIImageView *topView;
@property(nonatomic,strong)UIImageView *codeNumView;

@property (nonatomic, strong) JXCategoryTitleView *categoryView;//菜单标题view
@property (nonatomic, strong) JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) BaseButton *addBtn;
@property (nonatomic, strong) UILabel *numL;
@property (nonatomic, strong) NSString *searchStr;

@end

@implementation ColonelCodeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self getAllNumNeedReload:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.nav.searchField.placeholder = @"查询团长码";
    self.fieldEnabled  = YES;
    self.searchStr = @"";
    CJWeakSelf()
    self.nav.viewClickBlock = ^(NSInteger index, NSString * _Nonnull searchStr) {
        CJStrongSelf()
        NSLog(@"%@",searchStr);
        self.searchStr = searchStr;
        [self.categoryView reloadData];
    };
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadNum) name:@"reloadTuanNum" object:nil];
}

- (void)reloadNum{
    [self getAllNumNeedReload:NO];
}

- (void)initView{

    self.topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight + 192)];
    self.topView.image = IMAGE_NAMED(@"tuan_code_head");
    [self.view addSubview:self.topView];
    
    UIImageView *bgImage = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"tuan_code_bg")];
    bgImage.frame = CGRectMake(0, KNavBarHeight + 19, 302, 205);
    bgImage.centerX = self.view.centerX;
    [self.view addSubview:bgImage];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"我的团长码" textColor:KBlack666TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(15)];
    [bgImage addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgImage).offset(39);
        make.right.mas_equalTo(bgImage).offset(-12);
        make.left.mas_equalTo(bgImage).offset(12);
        make.height.mas_equalTo(24);
    }];
    
    UILabel *num = [UILabel creatLabelWithTitle:@"0个" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(17)];
    [bgImage addSubview:num];
    [num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom);
        make.right.mas_equalTo(bgImage).offset(-12);
        make.left.mas_equalTo(bgImage).offset(12);
        make.height.mas_equalTo(72);
    }];
    NSString *count = @"0";
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@个",count]];
    NSRange range = NSMakeRange(0,count.length);
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_R(55) range:range];
    num.attributedText = attributeMarket;
    self.numL = num;

    //分类
    UIView *categoryV = [[UIView alloc] initWithFrame:CGRectMake(0, KNavBarHeight+175, ScreenWidth, 50)];
    categoryV.backgroundColor = KWhiteBGColor;
    [self.view addSubview:categoryV];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:categoryV.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = categoryV.bounds;
    maskLayer.path = maskPath.CGPath;
    categoryV.layer.mask = maskLayer;
    
    MyLinearLayout *categoryLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    categoryLy.myHorzMargin = 0;
    categoryLy.myHeight = 44;
    categoryLy.myTop = 5;
    categoryLy.gravity = MyGravity_Horz_Left;
    categoryLy.backgroundColor = UIColor.whiteColor;
    categoryLy.layer.cornerRadius = 12;
    categoryLy.layer.masksToBounds = YES;
    [categoryV addSubview:categoryLy];
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
    self.categoryView.weight = 1;
    self.categoryView.myHeight = 44;
    self.categoryView.titles = @[@"未使用(0)",@"已使用(0)"];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = KMaintextColor;
    self.categoryView.titleColor = KBlack333TextColor;
    self.categoryView.titleSelectedFont = DEFAULT_FONT_M(16);
    self.categoryView.titleFont = DEFAULT_FONT_R(15);
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
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
    
    BaseButton *add = [[BaseButton alloc]init];
    [add setImage:IMAGE_NAMED(@"tuanCode_home_add") forState:UIControlStateNormal];
    [add setImage:IMAGE_NAMED(@"tuanCode_home_add") forState:UIControlStateHighlighted];
    [add addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:add];
    [add mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-30);
        make.right.mas_equalTo(self.view).offset(-24);
        make.height.width.mas_equalTo(50);
    }];
    self.addBtn = add;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotif) name:@"nodata" object:nil];
}

- (void)getAllNumNeedReload:(BOOL)isReload{
    [THHttpManager GET:@"shop/shopActivateCodeInfo/queryActivateCodeCount" parameters:@{} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            TuanNumModel *model = [TuanNumModel mj_objectWithKeyValues:data];
            self.categoryView.titles = @[[NSString stringWithFormat:@"未使用(%@)",model.isNotUsedCount],[NSString stringWithFormat:@"已使用(%@)",model.isUsedCount]];
            if (isReload) {
                [self.categoryView reloadData];
            }
            NSString *count = model.totalCount;
            NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@个",count]];
            NSRange range = NSMakeRange(0,count.length);
            [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_R(55) range:range];
            self.numL.attributedText = attributeMarket;
        }
    }];
}

- (void)getNotif{
    self.addBtn.hidden = YES;
}

- (void)addBtnClick{
    BuyTuanCodeViewController *vc = [[BuyTuanCodeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - JXPagingViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    TuanCodeContentViewController *vc = [[TuanCodeContentViewController alloc]init];
    vc.index = index;
    vc.searchStr = self.searchStr;
    return vc;
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
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

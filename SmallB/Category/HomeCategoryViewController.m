//
//  HomeCategoryViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/18.
//

#import "HomeCategoryViewController.h"
#import "CategoryLeftTableView.h"
#import "CategoryRightCollectionView.h"
#import "CategorySearchNavView.h"
#import "HomeMoreCommonViewController.h"

@interface HomeCategoryViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) CategoryLeftTableView *leftView;
@property (nonatomic, strong) CategoryRightCollectionView *rightView;
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) NSMutableArray *dataAry;

@end

@implementation HomeCategoryViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.selectedIndex = 0;
    self.view.backgroundColor = KWhiteBGColor;
    self.dataAry = [NSMutableArray array];
    
    CategorySearchNavView *nav= [[CategorySearchNavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight)];
    [self.view addSubview:nav];
    
    CategoryLeftTableView * leftView = [[CategoryLeftTableView alloc] initWithFrame:CGRectMake(0, KNavBarHeight+10, 105, ScreenHeight - KNavBarHeight-10) style:UITableViewStylePlain];
    leftView.showsVerticalScrollIndicator = 0;
    self.leftView = leftView;
    self.leftView.selectedRow = self.selectedIndex;
    self.leftView.bounces = NO;
    leftView.backgroundColor = kRGB(245, 245, 245);
    [self.view addSubview:leftView];
 
    __weak typeof(self) weakSelf = self;
    [leftView setCellSelectedBlock:^(NSIndexPath *indexPath) {
        weakSelf.selectedIndex = indexPath.row;
        weakSelf.rightView.selectedRow = indexPath.row;
        [weakSelf.rightView setDataWithDataAry:weakSelf.dataAry withSelectedRow:weakSelf.selectedIndex];
    }];

    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 8;
    flowLayout.minimumInteritemSpacing = 8;
    CGFloat width = ScreenWidth - 109 - 32;
    flowLayout.itemSize = CGSizeMake(width/3.0, width/3.0+40);
    flowLayout.headerReferenceSize = CGSizeMake(width, 43);
    //flowLayout.footerReferenceSize = CGSizeMake(width, 10);
    flowLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
    
    CategoryRightCollectionView *rightView = [[CategoryRightCollectionView alloc] initWithFrame:CGRectMake(105, KNavBarHeight + 10, ScreenWidth - 109, ScreenHeight - KNavBarHeight - 10) collectionViewLayout:flowLayout];
    rightView.backgroundColor = KWhiteBGColor;
    rightView.showsHorizontalScrollIndicator = 0;
    rightView.showsVerticalScrollIndicator = 0;
    rightView.bounces = NO;
    self.rightView = rightView;
    [self.view addSubview:rightView];
    
    [self.view sendSubviewToBack:leftView];
    [self.view sendSubviewToBack:rightView];
    
    CJWeakSelf()
    self.rightView.CellSelectedBlock = ^(NSString * _Nonnull title, NSString * _Nonnull categoryID) {
        CJStrongSelf()
        HomeMoreCommonViewController *vc = [[HomeMoreCommonViewController alloc]init];
        vc.homeMoreCommonType = HomeMoreCommonType_Category;
        vc.titleStr = title;
        vc.categoryId = categoryID;
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self getHomeData];
}

- (void)getHomeData{
    [self startLoadingHUD];
    [THHttpManager GET:@"goods/goodsCategory/list" parameters:@{} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200 && [data isKindOfClass:[NSArray class]]) {
        
            for (NSDictionary *dica in (NSArray *)data) {
                GoodsCategoryListVosModel *model = [GoodsCategoryListVosModel mj_objectWithKeyValues:dica];
                [self.dataAry addObject:model];
            }
            self.leftView.dataAry = self.dataAry;
            self.rightView.dataAry = self.dataAry;
        }
    }];
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

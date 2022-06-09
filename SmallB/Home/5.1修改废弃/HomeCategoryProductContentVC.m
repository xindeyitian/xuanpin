//
//  HomeCategoryProductContentVC.m
//  SmallB
//
//  Created by zhang on 2022/4/22.
//

#import "HomeCategoryProductContentVC.h"

@interface HomeCategoryProductContentVC ()

@end

@implementation HomeCategoryProductContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topView.frame = CGRectMake(0, 0, ScreenWidth, 50);
    self.tableView.frame = CGRectMake(0, 62, ScreenWidth, ScreenHeight - KNavBarHeight - 62 - 44 - KSafeAreaBottomHeight);
    self.collectionView.frame = CGRectMake(0, 62, ScreenWidth, ScreenHeight - 44 - KNavBarHeight - 62 - KSafeAreaBottomHeight);
}

- (UIView *)listView {
    return self.view;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SetIOS13;
    [navigationController setNavigationBarHidden:YES animated:YES];
}

@end

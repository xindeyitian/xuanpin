//
//  THBaseNavigationViewController.m
//  Xtecher
//
//  Created by 王剑亮 on 2017/7/5.
//  Copyright © 2017年 王剑亮. All rights reserved.
//

#import "THBaseNavigationViewController.h"

@interface THBaseNavigationViewController ()

@end

@implementation THBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navLeftButton = [BaseButton CreateBaseButtonTitle:nil Target:self Action:@selector(backUp) Font:nil BackgroundColor:nil Color:nil Frame:CGRectMake(0, 0, 20, 20) Alignment:0 Tag:0];
    [self.navLeftButton.imageView setImage:IMAGE_NAMED(@"return")];
    
    //navigation标题文字颜色
    NSDictionary *dic = @{NSForegroundColorAttributeName : UIColor.blackColor,
                          NSFontAttributeName : [UIFont systemFontOfSize:18 weight:UIFontWeightMedium]};
    
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
        [barApp configureWithOpaqueBackground];
        barApp.backgroundColor = UIColor.groupTableViewBackgroundColor;
        barApp.titleTextAttributes = dic;
        self.navigationController.navigationBar.scrollEdgeAppearance = barApp;
        self.navigationController.navigationBar.standardAppearance = barApp;
    }else{
        //背景色
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.navigationBar.tintColor = nil;
    }
    //不透明
    self.navigationController.navigationBar.translucent = YES;
    //navigation控件颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

-(void)backUp{
    
    [self popViewControllerAnimated:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.viewControllers.count >= 1) {
          viewController.hidesBottomBarWhenPushed = YES;
    }

    [super pushViewController:viewController animated:animated];
}

//-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
//
//    UIViewController *VC = self.navigationController.viewControllers.lastObject;
// 
//    //这里判断
//    
//    return VC;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

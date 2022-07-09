//
//  THAPPService.m
//
//  Copyright © 2017年 王剑亮. All rights reserved.
//

#import "THAPPService.h"
#import "AppDelegate.h"
@implementation THAPPService

+ (instancetype)shareAppService{
    static id obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        obj = [[self alloc]init];
    });
    return obj;
}

+ (UIViewController *)WindowRootViewController{

    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *delegate = (AppDelegate *)app.delegate;
     return  delegate.window.rootViewController;
}

+ (void)setWindowRootViewController:(UIViewController *)VC{
    
    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *delegate = (AppDelegate *)app.delegate;
    delegate.window.rootViewController = VC;
}

@end

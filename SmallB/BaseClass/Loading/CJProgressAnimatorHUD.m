//
//  CJProgressAnimatorHUD.m
//  CJ Dropshipping
//
//  Created by Architray on 2020/4/21.
//  Copyright © 2020 CuJia. All rights reserved.
//

#import "CJProgressAnimatorHUD.h"


@implementation CJProgressAnimatorHUD

+ (instancetype)showHUDAddedTo:(UIView *)view animated:(BOOL)animated
{
    CJProgressAnimatorHUD *hud = [super showHUDAddedTo:view animated:animated];
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = UIColor.clearColor;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = UIColor.clearColor;
    hud.mode = MBProgressHUDModeCustomView;
    
//    LOTAnimationView *animation = [LOTAnimationView animationNamed:@"cjLoading"];
//    [animation mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.equalTo(@(CGSizeMake(kCJScreenWRatio(60), kCJScreenWRatio(60))));
//    }];
//    hud.customView = animation;
//    animation.loopAnimation = YES;
//    animation.contentMode = UIViewContentModeScaleAspectFit;
//    hud.completionBlock = ^{
//        [animation stop];
//    };
//
//    [animation playWithCompletion:^(BOOL animationFinished) {}];
//
    return hud;
}

+ (instancetype)showNoRepeatHUDAddedTo:(UIView *)view animated:(BOOL)animated
{
    MBProgressHUD *preHUD = [self HUDForView:view];
    
    BOOL needInitHUD = NO;
    if (preHUD) {
        if (preHUD.superview == nil) {
            needInitHUD = YES;
        }
    }else{
        needInitHUD = YES;
    }
    if (needInitHUD) {
        MBProgressHUD *hud = [self showHUDAddedTo:view animated:YES];
        preHUD = hud;
        
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.backgroundView.color = UIColor.clearColor;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = UIColor.clearColor;
    }
    preHUD.mode = MBProgressHUDModeCustomView;
    
//    LOTAnimationView *animation;
//    if (preHUD.customView) {
//        if ([preHUD.customView isKindOfClass:[LOTAnimationView class]]) {
//            animation = (LOTAnimationView *)preHUD.customView;
//        }
//    }
//    if (animation == nil) {
//        animation = [LOTAnimationView animationNamed:@"cjLoading"];
//        [animation mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.equalTo(@(CGSizeMake(kCJScreenWRatio(60), kCJScreenWRatio(60))));
//        }];
//        preHUD.customView = animation;
//        animation.loopAnimation = YES;
//        animation.contentMode = UIViewContentModeScaleAspectFit;
//        preHUD.completionBlock = ^{
//            [animation stop];
//        };
//    }
    
    //[animation playWithCompletion:^(BOOL animationFinished) {}];
    
    return (CJProgressAnimatorHUD *)preHUD;
}

@end

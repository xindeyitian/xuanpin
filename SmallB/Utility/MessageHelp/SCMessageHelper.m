//
//  SCMessageHelper.m
//  LDSpecialCarService
//
//  Created by Mac on 2017/2/18.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "SCMessageHelper.h"
#import "UIAlertView+SCExtension.h"
//#import "UIView+Toast.h"


@implementation SCMessageHelper

+ (void)showMessage:(NSString *)message
{

    [UIAlertView alertWithTitle:@"提示" message:message cancleButtonTitle:@"确定" otherButtonTitle:nil block:nil];
}

+ (void)showAutoMessage:(NSString *)message block:(void (^)(UIAlertView *, NSInteger))block
{
     [UIAlertView autoAlertWithMessage:message block:block];

}

+ (void)showAutoMessage:(NSString *)message
{

    [self showAutoMessage:message block:nil];
    
}
@end

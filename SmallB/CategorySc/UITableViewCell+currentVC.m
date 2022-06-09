//
//  UITableViewCell+currentVC.m
//  Xtecher
//
//  Created by 王剑亮 on 2017/7/5.
//  Copyright © 2017年 王剑亮. All rights reserved.
//

#import "UITableViewCell+currentVC.h"

@implementation UITableViewCell (currentVC)
- (THBaseViewController *)currentViewController
{
    
    return [THAPPService shareAppService].currentViewController;
}

@end

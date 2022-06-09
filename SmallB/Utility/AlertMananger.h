//
//  AlertMananger.h
//  AlertController
//
//  Created by 郑信鸿 on 16/7/16.
//  Copyright © 2016年 郑信鸿. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^AlertIndexBlock)(NSInteger index);

@interface AlertMananger : NSObject

+ (AlertMananger *)shareManager;

- (AlertMananger *)creatAlertWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle cancelTitle:(NSString *)canceTitle otherTitle:(NSString *)otherTitle,...NS_REQUIRES_NIL_TERMINATION;

- (void)showWithViewController:(UIViewController *)viewController IndexBlock:(AlertIndexBlock)indexBlock;

@end

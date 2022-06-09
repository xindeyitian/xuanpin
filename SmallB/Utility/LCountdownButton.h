//
//  LCountdownButton.h
//  CreditManager
//
//  Created by 李经纬 on 2017/8/31.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCountdownButton : UIButton

@property (nonatomic, assign) BOOL isRadius;
- (void)buttonWithCountdown:(NSInteger)time normalTitle:(NSString *)normalTitle animationTitle:(NSString *)animationTitle;
@end

//
//  MessageView.h
//  ZhongbenKaGuanJia
//
//  Created by 李经纬 on 2018/8/15.
//  Copyright © 2018年 李经纬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MassageView : UIView

+(instancetype) shareInstance;

- (void)messageShowWithTitle:(NSString *)title SecondTitle:(NSString *)secTitle Content:(NSString *)content;

@end

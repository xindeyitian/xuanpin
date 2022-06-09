//
//  LCountdownButton.m
//  CreditManager
//
//  Created by 李经纬 on 2017/8/31.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "LCountdownButton.h"

@implementation LCountdownButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    
//    ViewRadius(self, 5);
//    ViewBorderRadius(self, 5, 1, kRGBColor16Bit(0xcccccc));
    
}

- (void)setIsRadius:(BOOL)isRadius
{
    _isRadius = isRadius;
    if (_isRadius == NO) {
        ViewBorderRadius(self, 5, 0, [UIColor clearColor]);
    }
    
}




- (void)buttonWithCountdown:(NSInteger)time normalTitle:(NSString *)normalTitle animationTitle:(NSString *)animationTitle {
    __block int timeout = (int)time; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:normalTitle forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:[NSString stringWithFormat:@"%@%@",strTime, animationTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

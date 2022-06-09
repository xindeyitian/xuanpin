//
//  UIButton+Extension.m
//  ZBank
//
//  Created by sundan on 2017/5/17.
//  Copyright © 2017年 yonyou. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>

static BOOL isIgnoreTouchEvent = NO;//是否可点击
static const void *timeStrKey = &timeStrKey;
static const void *durationKey = &durationKey;

@implementation UIButton (Extension)

@dynamic timeStr;
@dynamic defaultDuration;

- (void)setDefaultDuration:(NSString *)defaultDuration {
    return objc_setAssociatedObject(self, durationKey, defaultDuration, 1);
}

- (NSString *)defaultDuration {
    return objc_getAssociatedObject(self, durationKey);
}

- (void)setTimeStr:(NSString *)timeStr {
    return objc_setAssociatedObject(self, timeStrKey, timeStr, 1);
}

- (NSString *)timeStr {
    return objc_getAssociatedObject(self, timeStrKey);
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd,yyyy HH:mm tt"];
    NSDate *date = [formatter dateFromString:self.timeStr];
    if (self.defaultDuration.length == 0) {
        
    }
    NSDate *defaultDate = [formatter dateFromString:self.defaultDuration];
    NSTimeInterval timer = [date timeIntervalSince1970];
    NSTimeInterval defaultTimer = [defaultDate timeIntervalSince1970];
    
    timer = timer == 0?defaultTimer:timer;
    if (isIgnoreTouchEvent) {
        return;
    }
    if (timer > 0) {
        isIgnoreTouchEvent = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timer * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            isIgnoreTouchEvent = NO;
        });
        [super sendAction:action to:target forEvent:event];
    }
    else{
        [super sendAction:action to:target forEvent:event];
    }

}


+ (void)setNewVesionBtnEnabeld:(UIButton *)btn status:(BOOL)isEnabeld {
    //    [btn setUserInteractionEnabled:isEnabeld];
    btn.backgroundColor =   [UIColor colorWithHexString:@"#2e64af"];
    if (isEnabeld) {
        btn.alpha = 1;
    }else{
        btn.alpha = 0.5;
    }
    [btn setEnabled:isEnabeld];
}
+ (void)setButtonContentCenter:(UIButton *) btn
{
    CGSize imgViewSize,titleSize,btnSize;
    UIEdgeInsets imageViewEdge,titleEdge;
    CGFloat heightSpace = 0;
    //设置按钮内边距
    imgViewSize = btn.imageView.bounds.size;
    titleSize = btn.titleLabel.bounds.size;
    btnSize = btn.bounds.size;
    imageViewEdge = UIEdgeInsetsMake(heightSpace,0.0, btnSize.height -imgViewSize.height - heightSpace, - titleSize.width);
    [btn setImageEdgeInsets:imageViewEdge];
    titleEdge = UIEdgeInsetsMake(imgViewSize.height +heightSpace, - imgViewSize.width, 0.0, 0.0);
    [btn setTitleEdgeInsets:titleEdge];
}

@end

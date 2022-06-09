//
//  AllNoticePopUtility.m
//  SmallB
//
//  Created by 张昊男 on 2022/3/25.
//

#import "AllNoticePopUtility.h"

static AllNoticePopUtility* _instance = nil;

@implementation AllNoticePopUtility

+ (instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        
        _instance = [[AllNoticePopUtility alloc] init];
    }) ;
    return _instance ;
}
- (void)popViewWithTitle:(NSString *)title AndType:(noticeType )type AnddataBlock:(popSuccessBlock )block{
    
    LSTPopViewqqtopView *view = [[[NSBundle mainBundle] loadNibNamed:@"LSTPopViewqqtopView" owner:self options:nil] lastObject];
    view.frame = CGRectMake(0, RootStatusBarHeight, ScreenWidth-40, 60);
    view.layer.cornerRadius = 5;
    view.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    view.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.12].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,3);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 35;
    view.type = type;
    view.noticeTitle = title;
    LSTPopView *popView = [LSTPopView initWithCustomView:view popStyle:LSTPopStyleSmoothFromTop dismissStyle:LSTDismissStyleSmoothToTop];
    LSTPopViewWK(popView)
    popView.hemStyle = LSTHemStyleTop;
    popView.popDuration = 0.25;
    popView.dismissDuration = 0.25;
    popView.adjustY = RootStatusBarHeight;
    popView.isClickFeedback = YES;
    popView.bgColor = UIColor.blackColor;
    popView.isHideBg = YES;
    popView.isSingle = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        block();
        [wk_popView dismiss];
    });
    
    [popView pop];
}

@end

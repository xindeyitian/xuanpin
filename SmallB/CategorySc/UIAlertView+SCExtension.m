
#import "UIAlertView+SCExtension.h"
#import <objc/runtime.h>


@interface UIAlertView () <UIAlertViewDelegate>

@end

@implementation UIAlertView (Additional)

+ (void)autoAlertWithMessage:(NSString *)message block:(void(^)(UIAlertView *alert, NSInteger buttonIndex))block;
{

  UIAlertView *alert = [self alertWithTitle:@"提示" message:message cancleButtonTitle:nil otherButtonTitle:nil block:block];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [alert dismiss:alert];
    });

}

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message cancleButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle block:(void(^)(UIAlertView *, NSInteger))block
{
    if (title == nil) {
        
        title = @"提示";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil];
    
    alert.delegate = alert;
    
    objc_setAssociatedObject(alert, @"block", block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [alert show];
    
    return alert;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void(^handler)(UIAlertView *, NSInteger) = objc_getAssociatedObject(alertView, @"block");
    if (handler) {
        handler(alertView, buttonIndex);
    }
}

- (void)dismiss:(UIAlertView *)alertView
{
    
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    
    void(^handler)(UIAlertView *, NSInteger) = objc_getAssociatedObject(alertView, @"block");
    if (handler) {
        handler(alertView, 0);
    }
}

- (void)dealloc
{
    objc_removeAssociatedObjects(self);
}

@end

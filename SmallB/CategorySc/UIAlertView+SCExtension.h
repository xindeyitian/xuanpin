//

#import <UIKit/UIKit.h>

@interface UIAlertView (SCExtension)

+ (instancetype)alertWithTitle:(NSString *)title
               message:(NSString *)message
     cancleButtonTitle:(NSString *)cancelButtonTitle
      otherButtonTitle:(NSString *)otherButtonTitle
               block:(void(^)(UIAlertView *alert, NSInteger buttonIndex))block;


+ (void)autoAlertWithMessage:(NSString *)message block:(void(^)(UIAlertView *alert, NSInteger buttonIndex))block;;

@end

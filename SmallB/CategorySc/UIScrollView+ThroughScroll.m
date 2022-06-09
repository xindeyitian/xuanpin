//
//  UIScrollView+ThroughScroll.m
//  SeaEgret
//
//  Created by MAC on 2021/3/25.
//

#import "UIScrollView+ThroughScroll.h"
#import <objc/runtime.h>

@implementation UIScrollView (ThroughScroll)

- (void)setShouldThrough:(NSString *)shouldThrough {
    objc_setAssociatedObject(self, "shouldThrough", shouldThrough, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)shouldThrough {
    return objc_getAssociatedObject(self, "shouldThrough");
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {

    if ([self.shouldThrough isEqualToString:@"1"]) {
        return true;
    }
    
    return false;
}

@end

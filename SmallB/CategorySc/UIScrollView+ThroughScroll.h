//
//  UIScrollView+ThroughScroll.h
//  SeaEgret
//
//  Created by MAC on 2021/3/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (ThroughScroll)
/// 手势穿透
@property (nonatomic, strong) NSString *shouldThrough;
@end

NS_ASSUME_NONNULL_END

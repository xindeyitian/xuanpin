//
//  CALayer+XibConfiguration.h
//  palmlife
//
//  Created by MAC on 2019/11/19.
//  Copyright © 2019 王剑亮. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (XibConfiguration)

@property(nonatomic, assign) UIColor *borderUIColor;
@property(nonatomic, assign) UIColor *shadowUIColor;
 - (void)setBorderColorFromUIColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END

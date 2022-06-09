//
//  UIColor+Category.m
//  lhxk
//
//  Created by Ethan on 14-4-3.
//  Copyright (c) 2014年 mac iko. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

+ (instancetype)bm_colorGradientChangeWithSize:(CGSize)size
                                    direction:(IHGradientChangeDirection)direction
                                   startColor:(UIColor *)startcolor
                                     endColor:(UIColor *)endColor {
    
    if (CGSizeEqualToSize(size, CGSizeZero) || !startcolor || !endColor) {
        return nil;
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    
    CGPoint startPoint = CGPointZero;
    if (direction == IHGradientChangeDirectionDownDiagonalLine) {
        startPoint = CGPointMake(0.0, 1.0);
    }
    gradientLayer.startPoint = startPoint;
    
    CGPoint endPoint = CGPointZero;
    switch (direction) {
        case IHGradientChangeDirectionLevel:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        case IHGradientChangeDirectionVertical:
            endPoint = CGPointMake(0.0, 1.0);
            break;
        case IHGradientChangeDirectionUpwardDiagonalLine:
            endPoint = CGPointMake(1.0, 1.0);
            break;
        case IHGradientChangeDirectionDownDiagonalLine:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        default:
            break;
    }
    gradientLayer.endPoint = endPoint;
    
    gradientLayer.colors = @[(__bridge id)startcolor.CGColor, (__bridge id)endColor.CGColor];
    UIGraphicsBeginImageContext(size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    
	return [UIColor colorWithHexString:hexString alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    if ([hexString length] <= 0)
        return nil;
    
	// Remove '#'
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
	
	// Invalid if not 3, or 6 characters
	NSUInteger length = [hexString length];
	if (length != 3 && length != 6) {
		return nil;
	}
    
	NSUInteger digits = length / 3;
	CGFloat maxValue = ((digits == 1) ? 15.0 : 255.0);
	
    NSString *redString = [hexString substringWithRange:NSMakeRange(0, digits)];
    NSString *greenString = [hexString substringWithRange:NSMakeRange(digits, digits)];
    NSString *blueString = [hexString substringWithRange:NSMakeRange(2 * digits, digits)];
    
    NSUInteger red = 0;
    NSUInteger green = 0;
    NSUInteger blue = 0;
    
	sscanf([redString UTF8String], "%x", &red);
    sscanf([greenString UTF8String], "%x", &green);
    sscanf([blueString UTF8String], "%x", &blue);
    
	return [UIColor colorWithRed:red/maxValue green:green/maxValue blue:blue/maxValue alpha:alpha];
}

+ (UIColor *)randomColor {
	return [UIColor colorWithRed:((CGFloat)arc4random()) / (CGFloat)RAND_MAX
						   green:((CGFloat)arc4random()) / (CGFloat)RAND_MAX
							blue:((CGFloat)arc4random()) / (CGFloat)RAND_MAX
						   alpha:1.0];
}


#pragma mark - Components

- (CGFloat)red {
	if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) != kCGColorSpaceModelRGB) {
		return -1.0;
	}
	CGFloat const *components = CGColorGetComponents(self.CGColor);
	return components[0];
}

- (CGFloat)green {
	if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) != kCGColorSpaceModelRGB) {
		return -1.0;
	}
	CGFloat const *components = CGColorGetComponents(self.CGColor);
	return components[1];
}

- (CGFloat)blue {
	if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) != kCGColorSpaceModelRGB) {
		return -1.0;
	}
	CGFloat const *components = CGColorGetComponents(self.CGColor);
	return components[2];
}

- (CGFloat)alpha {
	return CGColorGetAlpha(self.CGColor);
}


// Inspired by https://github.com/Cocoanetics/NSAttributedString-Additions-for-HTML
- (NSString *)hexString {
	size_t count = CGColorGetNumberOfComponents(self.CGColor);
	const CGFloat *components = CGColorGetComponents(self.CGColor);
	
	static NSString *stringFormat = @"%02x%02x%02x";
	
	if (count == 2) {
        // Grayscale
		NSUInteger white = (NSUInteger)(components[0] * 255.0);
		return [NSString stringWithFormat:stringFormat, white, white, white];
	} else if (count == 4) {
        // RGB
		return [NSString stringWithFormat:stringFormat,
                (NSUInteger)(components[0] * 255.0),
                (NSUInteger)(components[1] * 255.0),
                (NSUInteger)(components[2] * 255.0)];
	}
	
	// Unsupported color space
	return nil;
}

@end

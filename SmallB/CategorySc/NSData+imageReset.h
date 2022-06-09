//
//  NSData+imageReset.h
//  palmlife
//
//  Created by MAC on 2020/4/23.
//  Copyright © 2020 王剑亮. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (imageReset)

+ (NSData *)resetSizeOfImageData:(UIImage *)sourceImage maxSize:(NSInteger)maxSize;

@end

NS_ASSUME_NONNULL_END

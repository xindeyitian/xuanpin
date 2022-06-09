//
//  NSObject+toJSON.h
//  CJ Dropshipping
//
//  Created by Architray on 2019/5/7.
//  Copyright © 2019 Atom. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (toJSON)

- (NSData *)toJSONData;
- (NSString *)toJSONStr;

@end

@interface NSDictionary (toJSON)

@end

@interface NSArray (toJSON)

@end

NS_ASSUME_NONNULL_END

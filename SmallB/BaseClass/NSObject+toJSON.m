//
//  NSObject+toJSON.m
//  CJ Dropshipping
//
//  Created by Architray on 2019/5/7.
//  Copyright © 2019 Atom. All rights reserved.
//

#import "NSObject+toJSON.h"

@implementation NSObject (toJSON)

- (NSData *)toJSONData {
    return nil;
}
- (NSString *)toJSONStr {
    return nil;
}

@end

@implementation NSDictionary (toJSON)

- (NSData *)toJSONData {
    if (@available(iOS 11.0, *)) {
        return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingSortedKeys error:nil];
    } else {
        return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    }
}

- (NSString *)toJSONStr {
    return [[NSString alloc] initWithData:[self toJSONData] encoding:NSUTF8StringEncoding];
}

@end

@implementation NSArray (toJSON)

- (NSData *)toJSONData {
    if (@available(iOS 11.0, *)) {
        return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingSortedKeys error:nil];
    } else {
        return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    }
}

- (NSString *)toJSONStr {
    return [[NSString alloc] initWithData:[self toJSONData] encoding:NSUTF8StringEncoding];
}

@end

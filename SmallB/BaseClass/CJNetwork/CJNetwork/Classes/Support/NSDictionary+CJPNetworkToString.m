//
//  NSDictionary+CJPNetworkToString.m
//  AFNetworking
//
//  Created by Architray on 2019/10/17.
//

#import "NSDictionary+CJPNetworkToString.h"

@implementation NSDictionary (CJPNetworkToString)

- (NSString *)cjpNetworkToJSON
{
    return [[NSString alloc] initWithData:[self pcjpNetwork_toJSONData] encoding:NSUTF8StringEncoding];
}

- (NSData *)pcjpNetwork_toJSONData {
    if (@available(iOS 11.0, *)) {
        return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingSortedKeys error:nil];
    } else {
        return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    }
}

@end

//
//  NSObject+CJPNetworkAutoCancel.m
//  AFNetworking
//
//  Created by Architray on 2019/8/29.
//

#import "NSObject+CJPNetworkAutoCancel.h"

#import <objc/runtime.h>

@implementation NSObject (CJPNetworkAutoCancel)

- (CJPNetworkAutoCancelProperty *)networkAutoCancelProperty{
    CJPNetworkAutoCancelProperty *property = objc_getAssociatedObject(self, @selector(networkAutoCancelProperty));
    if (property == nil) {
        property = [[CJPNetworkAutoCancelProperty alloc]init];
        objc_setAssociatedObject(self, @selector(networkAutoCancelProperty), property, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return property;
}

@end

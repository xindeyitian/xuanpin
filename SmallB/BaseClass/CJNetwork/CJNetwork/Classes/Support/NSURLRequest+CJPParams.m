//
//  NSURLRequest+CJPParams.m
//  AFNetworking
//
//  Created by Architray on 2019/10/17.
//

#import "NSURLRequest+CJPParams.h"
#import <objc/runtime.h>

static void *CTNetworkingRequestParams;

@implementation NSURLRequest (CJPParams)

- (void)setRequestParams:(NSDictionary *)requestParams
{
    objc_setAssociatedObject(self, &CTNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams
{
    return objc_getAssociatedObject(self, &CTNetworkingRequestParams);
}

@end

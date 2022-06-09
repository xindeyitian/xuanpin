//
//  CJPNetLoger.m
//  AFNetworking
//
//  Created by Architray on 2019/10/12.
//

#import "CJPNetLoger.h"

#import "CJPNetworkConfig.h"
#import "NSURLRequest+CJPParams.h"
#import "NSDictionary+CJPNetworkToString.h"

@interface CJPNetLoger ()

@end

@implementation CJPNetLoger

+ (void)logRequestInfo:(CJPNetworkRequestModel *)requestModel headerDict:(NSDictionary *)headerDict
{
    if ([CJPNetworkConfig shared].totalLogable) {
        NSLog(@"\n********************************************RequestInfo-Model-start******************************************\n");
        if ([CJPNetworkConfig shared].requestLogable) {
            NSLog(@"\nCJPNetwork---->\n---->extheader:%@\n---->URL:%@\n---->params:%@",
                       ([CJPNetworkConfig shared].extHeaderLogable ? requestModel.extHeaderDict : headerDict),
                       requestModel.url,
                       requestModel.parameters);
            switch (requestModel.requestType) {
                case CJPNetworkRequestTypeGET:{
                    NSLog(@"\nCJPNetwork---->requestType:GET");
                }
                    break;
                case CJPNetworkRequestTypePOST:{
                    NSLog(@"\nCJPNetwork---->requestType:POST");
                }
                    break;
                    
                default:
                    NSLog(@"\n\
                          !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\
                          !!CJPNetwork---->requestType:Default:GET!!\n\
                          !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    break;
            }
        }else{
            NSLog(@"\nCJPNetwork---->\n");
        }
        NSLog(@"\n********************************************RequestInfo--end******************************************\n");
    }
}

+ (void)logURLRequest:(NSURLRequest *)request
{
    if (![CJPNetworkConfig shared].totalLogable) {
        return;
    }
    NSMutableString *logStr = [NSMutableString stringWithString:@"\n********************************************RequestInfo-start******************************************\n"];
    if ([CJPNetworkConfig shared].requestLogable) {
        [logStr appendString:[NSString stringWithFormat:@"\nCJPNetwork---->\n---->header:%@\n---->URL:%@\n---->params:%@", request.allHTTPHeaderFields, request.URL.absoluteString, request.requestParams]];
        [logStr appendString:[NSString stringWithFormat:@"\nCJPNetwork---->requestType:%@\n", request.HTTPMethod]];
    }else{
        [logStr appendString:@"\nCJPNetwork---->Start\n"];
    }
    [logStr appendString:@"\n********************************************RequestInfo-end******************************************\n"];
    NSLog(@"%@", logStr);
}

+ (void)logCacheInfo:(id)data
{
    [self logCacheInfo:data forRequest:nil];
}

+ (void)logCacheInfo:(id)data forRequest:(NSURLRequest *)request
{
    if (![CJPNetworkConfig shared].totalLogable) {
        return;
    }
    NSMutableString *logStr = [NSMutableString stringWithString:@"\n********************************************CacheInfo-start******************************************\n"];
    [logStr appendString:[self pcj_logRequest:request]];
    if ([CJPNetworkConfig shared].cacheLogable) {
        [logStr appendString:[NSString stringWithFormat:@"\nCJPNetwork---->cacheData:\ncacheData:%@", data]];
    }else{
        [logStr appendString:@"\nCJPNetwork---->cacheData:\n"];
    }
    [logStr appendString:@"\n********************************************CacheInfo-end******************************************\n"];
    NSLog(@"%@", logStr);
}

+ (void)logProgressInfo:(NSProgress *)uploadProgress
{
    [self logProgressInfo:uploadProgress forRequest:nil];
}

+ (void)logProgressInfo:(NSProgress *)uploadProgress forRequest:(NSURLRequest *)request
{
    if (![CJPNetworkConfig shared].totalLogable) {
        return;
    }
    NSMutableString *logStr = [NSMutableString stringWithString:@"\n********************************************UploadProgress-start******************************************\n"];
    [logStr appendString:[self pcj_logRequest:request]];
    if ([CJPNetworkConfig shared].progressLogable) {
        [logStr appendString:[NSString stringWithFormat:@"\nCJPNetwork---->Progress:\nprogress:%@", uploadProgress]];
    }else{
        [logStr appendString:@"\nCJPNetwork---->Progress:\n"];
    }
    [logStr appendString:@"\n********************************************UploadProgress-end******************************************\n"];
    NSLog(@"%@", logStr);
}

+ (void)logDownloadProgressInfo:(NSProgress *)uploadProgress forRequest:(nullable NSURLRequest *)request
{
    if (![CJPNetworkConfig shared].totalLogable) {
        return;
    }
    NSMutableString *logStr = [NSMutableString stringWithString:@"\n********************************************DownloadProgress-start******************************************\n"];
    [logStr appendString:[self pcj_logRequest:request]];
    if ([CJPNetworkConfig shared].progressLogable) {
        [logStr appendString:[NSString stringWithFormat:@"\nCJPNetwork---->DownloadProgress:\nprogress:%@", uploadProgress]];
    }else{
        [logStr appendString:@"\nCJPNetwork---->DownloadProgress:\n"];
    }
    [logStr appendString:@"\n********************************************DownloadProgress-end******************************************\n"];
    NSLog(@"%@", logStr);
}

+ (void)logSuccessInfo:(id)data
{
    [self logSuccessInfo:data forRequest:nil];
}

+ (void)logSuccessInfo:(id)data forRequest:(NSURLRequest *)request
{
    if (![CJPNetworkConfig shared].totalLogable) {
        return;
    }
    NSMutableString *logStr = [NSMutableString stringWithString:@"\n********************************************SuccessInfo-start******************************************\n"];
    [logStr appendString:[self pcj_logRequest:request]];
    if ([CJPNetworkConfig shared].successLogable) {
        [logStr appendString:[NSString stringWithFormat:@"\nCJPNetwork---->success:\n\n\n%@", data]];
    }else{
        [logStr appendString:@"\nCJPNetwork---->success:\n"];
    }
    [logStr appendString:@"\n********************************************SuccessInfo-end******************************************\n"];
    NSLog(@"%@", logStr);
}

+ (void)logFailureInfo:(NSError *)error
{
    [self logFailureInfo:error forRequest:nil];
}

+ (void)logFailureInfo:(NSError *)error forRequest:(NSURLRequest *)request
{
    if (![CJPNetworkConfig shared].totalLogable) {
        return;
    }
    NSMutableString *logStr = [NSMutableString stringWithString:@"\n********************************************FailureInfo-start******************************************\n"];
    [logStr appendString:[self pcj_logRequest:request]];
    if ([CJPNetworkConfig shared].failureLogable) {
        [logStr appendString:[NSString stringWithFormat:@"\nCJPNetwork---->error:\nerror:%@", error]];
    }else{
        [logStr appendString:@"\nCJPNetwork---->error:\n"];
    }
    [logStr appendString:@"\n********************************************FailureInfo-end******************************************\n"];
    NSLog(@"%@", logStr);
}

+ (NSString *)pcj_logRequest:(NSURLRequest *)request
{
    NSString *reStr;
    if (request) {
        reStr = [NSString stringWithFormat:@"\nRequest---->URL:\n%@\nParams:---->\n%@",
        request.URL.absoluteString,
        request.requestParams];
    }
    return reStr;
}

@end

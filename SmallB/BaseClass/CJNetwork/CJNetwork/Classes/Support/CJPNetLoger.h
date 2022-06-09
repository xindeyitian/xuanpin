//
//  CJPNetLoger.h
//  AFNetworking
//
//  Created by Architray on 2019/10/12.
//

#import <Foundation/Foundation.h>

#import "CJPNetworkRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJPNetLoger : NSObject

#pragma mark - Request Log
+ (void)logRequestInfo:(CJPNetworkRequestModel *)requestModel headerDict:(NSDictionary *)headerDict;
+ (void)logURLRequest:(NSURLRequest *)request;

#pragma mark - Cache Log
+ (void)logCacheInfo:(id)data;
+ (void)logCacheInfo:(id)data forRequest:(nullable NSURLRequest *)request;

#pragma mark - Progress Log
+ (void)logProgressInfo:(NSProgress *)uploadProgress;
+ (void)logProgressInfo:(NSProgress *)uploadProgress forRequest:(nullable NSURLRequest *)request;

+ (void)logDownloadProgressInfo:(NSProgress *)uploadProgress forRequest:(nullable NSURLRequest *)request;

#pragma mark - Success Log
+ (void)logSuccessInfo:(id)data;
+ (void)logSuccessInfo:(id)data forRequest:(nullable NSURLRequest *)request;

#pragma mark - Failure Log
+ (void)logFailureInfo:(NSError *)error;
+ (void)logFailureInfo:(NSError *)error forRequest:(nullable NSURLRequest *)request;

@end

NS_ASSUME_NONNULL_END

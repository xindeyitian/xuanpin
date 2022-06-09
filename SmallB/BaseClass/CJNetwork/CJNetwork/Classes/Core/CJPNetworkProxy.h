//
//  CJPNetworkProxy.h
//  AFNetworking
//
//  Created by Architray on 2019/10/17.
//

#import <Foundation/Foundation.h>

#import "CJPNetworkRequestTask.h"
#import "CJPNetworkBaseReqModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJPNetworkProxy : NSObject

+ (instancetype)sharedInstance;

- (NSNumber *)callWithRequest:(NSURLRequest *)request
               uploadProgress:(nullable CJPNetUploadProgress)uploadProgress
             downloadProgress:(nullable CJPNetDownloadProgress)downloadProgress
                   completion:(CJPNetCompletion)completion;

- (NSNumber *)callWithRequest:(NSURLRequest *)request
               uploadProgress:(nullable CJPNetUploadProgress)uploadProgress
             downloadProgress:(nullable CJPNetDownloadProgress)downloadProgress
             cacheCompletion:(nullable CJPNetCacheCompletion)cacheCompletion
                   completion:(CJPNetCompletion)completion;

@end


/**
 服务器网络请求
 (推荐使用)
 */
@interface CJPNetworkProxy (CJServer)

- (CJPRequestID)callGETWithServiceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName params:(id)params completion:(CJPNetCompletion)completion;
- (CJPRequestID)callPOSTWithServiceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName params:(id)params completion:(CJPNetCompletion)completion;
- (CJPRequestID)callPUTWithServiceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName params:(id)params completion:(CJPNetCompletion)completion;
- (CJPRequestID)callDELETEWithServiceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName params:(id)params completion:(CJPNetCompletion)completion;

- (CJPRequestID)callGETWithServiceIdentifier:(NSString *)servieIdentifier
                                  methodName:(NSString *)methodName
                                      params:(id)params
                              uploadProgress:(nullable CJPNetUploadProgress)uploadProgress
                            downloadProgress:(nullable CJPNetDownloadProgress)downloadProgress
                             cacheCompletion:(nullable CJPNetCacheCompletion)cacheCompletion
                                  completion:(CJPNetCompletion)completion;
- (CJPRequestID)callPOSTWithServiceIdentifier:(NSString *)servieIdentifier
                                   methodName:(NSString *)methodName
                                       params:(id)params
                               uploadProgress:(nullable CJPNetUploadProgress)uploadProgress
                             downloadProgress:(nullable CJPNetDownloadProgress)downloadProgress
                              cacheCompletion:(nullable CJPNetCacheCompletion)cacheCompletion
                                   completion:(CJPNetCompletion)completion;
- (CJPRequestID)callPUTWithServiceIdentifier:(NSString *)servieIdentifier
                                  methodName:(NSString *)methodName
                                      params:(id)params
                              uploadProgress:(nullable CJPNetUploadProgress)uploadProgress
                            downloadProgress:(nullable CJPNetDownloadProgress)downloadProgress
                             cacheCompletion:(nullable CJPNetCacheCompletion)cacheCompletion
                                  completion:(CJPNetCompletion)completion;
- (CJPRequestID)callDELETEWithServiceIdentifier:(NSString *)servieIdentifier
                                     methodName:(NSString *)methodName
                                         params:(id)params
                                 uploadProgress:(nullable CJPNetUploadProgress)uploadProgress
                               downloadProgress:(nullable CJPNetDownloadProgress)downloadProgress
                                cacheCompletion:(nullable CJPNetCacheCompletion)cacheCompletion
                                     completion:(CJPNetCompletion)completion;

- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;

- (NSURLSessionTask *)taskWithRequestID:(NSNumber *)requestID;

@end

@interface CJPNetworkProxy (CJRequestModel)

- (CJPNetworkRequestTask *)requestWithModel:(CJPNetworkBaseReqModel *)requestModel;

@end

NS_ASSUME_NONNULL_END

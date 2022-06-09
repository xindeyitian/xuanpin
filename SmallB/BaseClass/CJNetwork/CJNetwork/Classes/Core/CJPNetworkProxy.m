//
//  CJPNetworkProxy.m
//  AFNetworking
//
//  Created by Architray on 2019/10/17.
//

#import "CJPNetworkProxy.h"

#import "CJPNetworkResponse.h"
#import "CJPNetworkCache.h"
#import "CJPNetworkConfig.h"
#import "CJPNetworkDefines.h"
#import "CJPNetLoger.h"
#import "CJPRequestGenerator.h"
#import "NSURLRequest+CJPParams.h"

#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface CJPNetworkProxy ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableDictionary *dispatchTable;

@end

@implementation CJPNetworkProxy

#pragma mark ================ Configs ================

#pragma mark ================ LiftCircles ================

#pragma mark ================ Systems ================

#pragma mark ================ Target-Actions ================

#pragma mark ================ Interfaces ================
/**
 开始监测网络状态
 */
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static CJPNetworkProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CJPNetworkProxy alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    
    self = [super init];
    [self initialRequestGenerator];
    return self;
}

- (void)initialRequestGenerator {
    
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.requestSerializer.timeoutInterval = [CJPNetworkConfig shared].defaultTimeOutSeconds;
    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/pdf", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    // 打开状态栏的等待菊花
#ifdef TODAY_EXTENSION
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
#endif
}

- (NSNumber *)callWithRequest:(NSURLRequest *)request uploadProgress:(CJPNetUploadProgress)uploadProgress downloadProgress:(CJPNetDownloadProgress)downloadProgress completion:(CJPNetCompletion)completion
{
    return [self callWithRequest:request uploadProgress:uploadProgress downloadProgress:downloadProgress cacheCompletion:nil completion:completion];
}

- (NSNumber *)callWithRequest:(NSURLRequest *)request uploadProgress:(CJPNetUploadProgress)uploadProgress downloadProgress:(CJPNetDownloadProgress)downloadProgress cacheCompletion:(CJPNetCacheCompletion)cacheCompletion completion:(CJPNetCompletion)completion
{
    if (cacheCompletion) {
        id cacheData = [CJPNetworkCache httpCacheForURL:request.URL.absoluteString parameters:request.requestParams];
        [CJPNetLoger logCacheInfo:cacheData forRequest:request];
        if (cacheData) {
            cacheCompletion(cacheData, nil);
        }
    }
    
    [CJPNetLoger logURLRequest:request];
    
    CJPNetUploadProgress uploadProgressBlk = ^(NSProgress * _Nonnull progress) {
        // 输出请求进度日志
        [CJPNetLoger logProgressInfo:progress forRequest:request];
        if (uploadProgress) {
            uploadProgress(progress);
        }
    };
    
    CJPNetDownloadProgress downloadProgressBlk = ^(NSProgress * _Nonnull progress) {
        // 输出下载进度日志
        [CJPNetLoger logDownloadProgressInfo:progress forRequest:request];
        if (downloadProgress) {
            downloadProgress(progress);
        }
    };
    
    CJPNetCompletion completionBlk = ^(id  _Nullable data, CJPNetError * _Nullable error) {
        if (!error) {
            // 输出请求成功日志
            [CJPNetLoger logSuccessInfo:data forRequest:request];
            
            completion(data, nil);
            cacheCompletion!=nil ? [CJPNetworkCache setHttpCache:data URL:request.URL.absoluteString parameters:request.requestParams] : nil;
        }else{
            // 输出请求失败日志
            [CJPNetLoger logFailureInfo:error forRequest:request];
            completion(nil, error);
        }
    };
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:request uploadProgress:uploadProgressBlk downloadProgress:downloadProgressBlk completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSNumber *requestID = @([dataTask taskIdentifier]);
        [self.dispatchTable removeObjectForKey:requestID];
        
        completionBlk(responseObject, [CJPNetError errorWithNSError:error]);
    }];
    
    NSNumber *requestId = @([dataTask taskIdentifier]);
    
    self.dispatchTable[requestId] = dataTask;
    [dataTask resume];
    
    return requestId;
}

#pragma mark ================ Privates ================

#pragma mark ================ Delegates ================

#pragma mark ================ Getters-Setters ================
#pragma mark LazyLoad
- (NSMutableDictionary *)dispatchTable
{
    if (!_dispatchTable) {
        _dispatchTable = [NSMutableDictionary dictionary];
    }
    return _dispatchTable;
}

@end

@implementation CJPNetworkProxy (CJServer)

- (CJPRequestID)callGETWithServiceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName params:(id)params completion:(CJPNetCompletion)completion
{
    return [self callGETWithServiceIdentifier:servieIdentifier methodName:methodName params:params uploadProgress:nil downloadProgress:nil cacheCompletion:nil completion:completion];
}

- (CJPRequestID)callPOSTWithServiceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName params:(id)params completion:(CJPNetCompletion)completion
{
    return [self callPOSTWithServiceIdentifier:servieIdentifier methodName:methodName params:params uploadProgress:nil downloadProgress:nil cacheCompletion:nil completion:completion];
}

- (CJPRequestID)callPUTWithServiceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName params:(id)params completion:(CJPNetCompletion)completion
{
    return [self callPUTWithServiceIdentifier:servieIdentifier methodName:methodName params:params uploadProgress:nil downloadProgress:nil cacheCompletion:nil completion:completion];
}

- (CJPRequestID)callDELETEWithServiceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName params:(id)params completion:(CJPNetCompletion)completion
{
    return [self callDELETEWithServiceIdentifier:servieIdentifier methodName:methodName params:params uploadProgress:nil downloadProgress:nil cacheCompletion:nil completion:completion];
}

- (CJPRequestID)callGETWithServiceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName params:(id)params uploadProgress:(CJPNetUploadProgress)uploadProgress downloadProgress:(CJPNetDownloadProgress)downloadProgress cacheCompletion:(CJPNetCacheCompletion)cacheCompletion completion:(CJPNetCompletion)completion
{
    NSURLRequest *request = [[CJPRequestGenerator sharedInstance] generateGETRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self pcj_callWithRequest:request uploadProgress:uploadProgress downloadProgress:downloadProgress cacheCompletion:cacheCompletion completion:completion];
    return [requestId integerValue];
}

- (CJPRequestID)callPOSTWithServiceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName params:(id)params uploadProgress:(CJPNetUploadProgress)uploadProgress downloadProgress:(CJPNetDownloadProgress)downloadProgress cacheCompletion:(CJPNetCacheCompletion)cacheCompletion completion:(CJPNetCompletion)completion
{
    NSURLRequest *request = [[CJPRequestGenerator sharedInstance] generatePOSTRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self pcj_callWithRequest:request uploadProgress:uploadProgress downloadProgress:downloadProgress cacheCompletion:cacheCompletion completion:completion];
    return [requestId integerValue];
}

- (CJPRequestID)callPUTWithServiceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName params:(id)params uploadProgress:(CJPNetUploadProgress)uploadProgress downloadProgress:(CJPNetDownloadProgress)downloadProgress cacheCompletion:(CJPNetCacheCompletion)cacheCompletion completion:(CJPNetCompletion)completion
{
    NSURLRequest *request = [[CJPRequestGenerator sharedInstance] generatePUTRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self pcj_callWithRequest:request uploadProgress:uploadProgress downloadProgress:downloadProgress cacheCompletion:cacheCompletion completion:completion];
    return [requestId integerValue];
}

- (CJPRequestID)callDELETEWithServiceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName params:(id)params uploadProgress:(CJPNetUploadProgress)uploadProgress downloadProgress:(CJPNetDownloadProgress)downloadProgress cacheCompletion:(CJPNetCacheCompletion)cacheCompletion completion:(CJPNetCompletion)completion
{
    NSURLRequest *request = [[CJPRequestGenerator sharedInstance] generateDELETERequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self pcj_callWithRequest:request uploadProgress:uploadProgress downloadProgress:downloadProgress cacheCompletion:cacheCompletion completion:completion];
    return [requestId integerValue];
}

- (NSNumber *)pcj_callWithRequest:(NSURLRequest *)request uploadProgress:(CJPNetUploadProgress)uploadProgress downloadProgress:(CJPNetDownloadProgress)downloadProgress cacheCompletion:(CJPNetCacheCompletion)cacheCompletion completion:(CJPNetCompletion)completion
{
    return [self callWithRequest:request
                  uploadProgress:uploadProgress
                downloadProgress:downloadProgress
                 cacheCompletion:cacheCompletion
                      completion:completion];
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID
{
    NSURLSessionDataTask *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList
{
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}

- (NSURLSessionTask *)taskWithRequestID:(NSNumber *)requestID
{
    NSURLSessionDataTask *task = self.dispatchTable[requestID];
    return task;
}

@end

@implementation CJPNetworkProxy (CJRequestModel)

- (CJPNetworkRequestTask *)requestWithModel:(CJPNetworkRequestModel *)requestModel
{
    NSURLRequest *request = [[CJPRequestGenerator sharedInstance] generateRequestWithRequestWithModel:requestModel];
    
    // 从缓存中取数据
    if (requestModel.responseCacheBlock) {
        id cacheData = [CJPNetworkCache httpCacheForURL:requestModel.url parameters:requestModel.parameters];
        if (cacheData) {
            requestModel.responseCacheBlock([CJPNetworkResponse responseWithData:cacheData error:nil]);
        }
    }
    
    // 设置请求头
    if (requestModel.extHeaderDict && requestModel.extHeaderDict.allKeys.count > 0) {
        for (NSString *key in requestModel.extHeaderDict.allKeys) {
            id value = requestModel.extHeaderDict[key];
            [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }
    
    // 进度回调处理
    void (^progressBlock)(NSProgress * _Nonnull uploadProgress) = ^(NSProgress * _Nonnull uploadProgress) {
        // 输出请求进度日志
        if (requestModel.progressBlock) {
            requestModel.progressBlock(uploadProgress);
        }
    };
    // 回调处理
    CJPNetCompletion completion = ^(id _Nullable data, CJPNetError *_Nullable error) {
        if (!error) {
            // 输出请求成功日志
            if (requestModel.responseBlock) {
                requestModel.responseBlock([CJPNetworkResponse responseWithData:data error:nil]);
            }
            //对数据进行异步缓存
            requestModel.responseCacheBlock!=nil ? [CJPNetworkCache setHttpCache:data URL:requestModel.url parameters:requestModel.parameters] : nil;
        }else{
            // 输出请求失败日志
            if (requestModel.responseBlock) {
                requestModel.responseBlock([CJPNetworkResponse responseWithData:nil error:error]);
            }
        }
    };
    
    NSNumber *requestId = [self callWithRequest:request uploadProgress:progressBlock downloadProgress:nil completion:completion];
    
    NSURLSessionTask *dataTask = self.dispatchTable[requestId];
    
    return [CJPNetworkRequestTask taskWithSessionTask:dataTask];
}

@end

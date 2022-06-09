//
//  CJPNetworkRequestProxy.m
//  AFNetworking
//
//  Created by Architray on 2019/11/19.
//

#import "CJPNetworkRequestProxy.h"

#import "CJPNetworkDefines.h"
#import "CJPRequestGenerator.h"
#import "CJPNetworkProxy.h"

#import "CJPServerFactory.h"
#import "CJPNetworkConfig.h"
#import "CJPBaseServer.h"
//#import "NSURLRequest+CJPParams.h"
//#import "CJPSignatureGenerator.h"

@interface CJPNetworkRequestProxy ()

@property (nonatomic, copy) NSString *requestMethod;

@property (nonatomic, assign) CJPNetworkRequestType requestType;
/**
 请求超时时间(秒)
 */
@property (nonatomic, copy, nullable) NSNumber *requestTimeout;
/**
 默认为CJPRequestSerializerTypeJSON
 */
@property (nonatomic, assign) CJPRequestSerializerType requestSerializerType;

@property (nonatomic, copy, nullable) CJPNetworkRequestFormDataBlock formDataBlock;

@property (nonatomic, copy, nullable) NSDictionary *requestExtHeader;

@property (nonatomic, copy, nullable) NSString *requestExtPreMethodPath;

@end

/**
 CJNetworkCall公用私有类
 */
@interface CJPNetworkRequestProxy (CJNetworkCall)

//根据Service拼接额外参数
- (NSDictionary *)pcj_totalRequestParamsByService:(CJPBaseServer *)service requestParams:(NSDictionary *)requestParams;

- (NSURLRequest *)pcj_generateRequestWithSerializerModel:(CJPNetworkRequestSerializerModel *)serializerModel urlString:(NSString *)urlString requestParams:(NSDictionary *)requestParams extraHttpHeadParmas:(NSDictionary *)extraHttpHeadParmas requestWithMethod:(NSString *)method;

@end

static AFHTTPRequestSerializer *kCJhHttpRequestSerializer;

@implementation CJPNetworkRequestProxy

- (instancetype)init
{
    if (self = [super init]) {
        self.requestType = CJPNetworkRequestTypePOST;
        self.requestSerializerType = CJPRequestSerializerTypeJSON;
        self.formDataBlock = nil;
    }
    return self;
}

+ (instancetype)POST
{
    CJPNetworkRequestProxy *requestProxy = self.new;
    requestProxy.requestType = CJPNetworkRequestTypePOST;
    return requestProxy;
}

+ (instancetype)GET
{
    CJPNetworkRequestProxy *requestProxy = self.new;
    requestProxy.requestType = CJPNetworkRequestTypeGET;
    return requestProxy;
}

+ (CJPNetworkRequestProxyAlloc)METHOD
{
    return ^(NSString *method) {
        CJPNetworkRequestProxy *requestProxy = self.new;
        requestProxy.requestType = CJPNetworkRequestTypePOST;
        requestProxy.requestMethod = method;
        return requestProxy;
    };
}

+ (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (!kCJhHttpRequestSerializer) {
        kCJhHttpRequestSerializer = [AFJSONRequestSerializer serializer];
        kCJhHttpRequestSerializer.timeoutInterval = [CJPNetworkConfig shared].defaultTimeOutSeconds;
        kCJhHttpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return kCJhHttpRequestSerializer;
}

- (NSString *)requestMethod
{
    switch (self.requestType) {
        case CJPNetworkRequestTypeGET:
            return @"GET";
            break;
        case CJPNetworkRequestTypePOST:
            return @"POST";
            break;
        case CJPNetworkRequestTypeCustom:
        {
            NSString *method;
            if (_requestMethod) {
                method =  [NSString stringWithFormat:@"%@", method];
            }
            // TODO: 增加过滤
            return method;
            break;
        }
            
        default:
            return @"POST";
            break;
    }
}

@end

@implementation CJPNetworkRequestProxy (CJRequestExpand)

+ (void)cancelRequestWithRequestID:(NSNumber *)requestID
{
    [[CJPNetworkProxy sharedInstance] cancelRequestWithRequestID:requestID];
}

+ (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList
{
    [[CJPNetworkProxy sharedInstance] cancelRequestWithRequestIDList:requestIDList];
}

- (CJPNetworkRequestProxyTimeout)timeout
{
    return ^(NSTimeInterval timeout) {
        self.requestTimeout = @(timeout);
        return self;
    };
}

- (CJPNetworkRequestProxySerializerType)serializerType
{
    return ^(CJPRequestSerializerType requestSerializerType) {
        self.requestSerializerType = requestSerializerType;
        return self;
    };
}

- (CJPNetworkRequestProxyFormData)formData
{
    return ^(CJPNetworkRequestFormDataBlock formDataBlock) {
        self.formDataBlock = formDataBlock;
        return self;
    };
}

- (CJPNetworkRequestProxyExtHeader)extHeader
{
    return ^(NSDictionary *extHeader) {
        if ([extHeader isKindOfClass:[NSDictionary class]]) {
            self.requestExtHeader = extHeader;
        }
        return self;
    };
}

- (CJPNetworkRequestProxyExtPreMethodPath)extPreMethodPath
{
    return ^(NSString *extPreMethodPath) {
        self.requestExtPreMethodPath = extPreMethodPath;
        return self;
    };
}

@end

@implementation CJPNetworkRequestProxy (CJNetworkCall)

//根据Service拼接额外参数
- (NSDictionary *)pcj_totalRequestParamsByService:(CJPBaseServer *)service requestParams:(NSDictionary *)requestParams
{
    if (![requestParams isKindOfClass:[NSDictionary class]]) {
        return requestParams;
    }
    NSMutableDictionary *totalRequestParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    
    if ([service.child respondsToSelector:@selector(extraParmas)]) {
        if ([service.child extraParmas]) {
            [[service.child extraParmas] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [totalRequestParams setObject:obj forKey:key];
            }];
        }
    }
    return [totalRequestParams copy];
}

- (NSURLRequest *)pcj_generateRequestWithSerializerModel:(CJPNetworkRequestSerializerModel *)serializerModel urlString:(NSString *)urlString requestParams:(NSDictionary *)requestParams extraHttpHeadParmas:(NSDictionary *)extraHttpHeadParmas requestWithMethod:(NSString *)method
{
    return [[CJPRequestGenerator sharedInstance] generateRequestWithSerializerModel:serializerModel urlString:urlString requestParams:requestParams extraHttpHeadParmas:extraHttpHeadParmas requestWithMethod:method];
}

@end

@implementation CJPNetworkRequestProxy (CJNetworkCallServer)

- (CJPNetworkTaskID)callWithServerIdentifier:(NSString *)serverIdentifier methodName:(NSString *)methodName params:(id)params completion:(CJPNetCompletion)completion
{
    return [self callWithServerIdentifier:serverIdentifier methodName:methodName params:params uploadProgress:nil downloadProgress:nil cacheCompletion:nil completion:completion];
}

- (CJPNetworkTaskID)callWithServerIdentifier:(NSString *)serverIdentifier methodName:(NSString *)methodName params:(id)params uploadProgress:(CJPNetUploadProgress)uploadProgress downloadProgress:(CJPNetDownloadProgress)downloadProgress cacheCompletion:(CJPNetCacheCompletion)cacheCompletion completion:(CJPNetCompletion)completion
{
    NSString *requestMethod = self.requestMethod;
    
    CJPBaseServer *service = [[CJPServerFactory sharedInstance] serverWithIdentifier:serverIdentifier];
    
    // 方法名有额外扩展路径
    NSString *fullMethodName = methodName;
    if (self.requestExtPreMethodPath) {
        fullMethodName = [NSString stringWithFormat:@"%@/%@", self.requestExtPreMethodPath, methodName];
    }
    NSString *urlString = [service urlGeneratingRuleByMethodName:fullMethodName];
    CJNetDeLog(@"网络请求===完整URL-====%@====",urlString);
    // 整合所有参数
    NSDictionary *totalRequestParams = [self pcj_totalRequestParamsByService:service requestParams:params];
    
    NSDictionary *extraHttpHeadParmas;
    if ([service.child respondsToSelector:@selector(extraHttpHeadParmasWithMethodName:)]) {
        extraHttpHeadParmas = [service.child extraHttpHeadParmasWithMethodName:methodName];
    }
    if (self.requestExtHeader) {
        if (extraHttpHeadParmas) {
            extraHttpHeadParmas = self.requestExtHeader;
        }else{
            NSMutableDictionary *fullExtHeader = [self.requestExtHeader mutableCopy];
            [extraHttpHeadParmas enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [fullExtHeader setValue:obj forKey:key];
            }];
            extraHttpHeadParmas = [fullExtHeader copy];
        }
    }
    
    NSNumber *serializerType = @(self.requestSerializerType);
    if (serializerType) {
        if ([service.child respondsToSelector:@selector(serializerTypeByMethodName:)]) {
            serializerType = @([service.child serializerTypeByMethodName:methodName]);
        }
    }
    NSNumber *timeout = self.requestTimeout;
    if (timeout) {
        if ([service.child respondsToSelector:@selector(timeoutByMethodName:)]) {
            timeout = @([service.child timeoutByMethodName:methodName]);
        }
    }
    CJPNetworkRequestSerializerModel *seriConfig;
    if (serializerType || timeout || self.formDataBlock) {
        seriConfig = [CJPNetworkRequestSerializerModel modelWithSerializerType:serializerType timeout:timeout];
    }
    seriConfig.formDataBlock = self.formDataBlock;
    
    NSURLRequest *request = [self pcj_generateRequestWithSerializerModel:seriConfig urlString:urlString requestParams:totalRequestParams extraHttpHeadParmas:extraHttpHeadParmas requestWithMethod:requestMethod];
    NSNumber *requestNum = [[CJPNetworkProxy sharedInstance] callWithRequest:request uploadProgress:uploadProgress downloadProgress:downloadProgress cacheCompletion:cacheCompletion completion:completion];
    return [requestNum unsignedIntegerValue];
}

@end

@implementation CJPNetworkRequestProxy (CJNetworkCallURL)

- (CJPNetworkTaskID)requestWithModel:(CJPNetworkBaseReqModel *)requestModel
{
//    requestModel.requestType = self.requestType;
//    requestModel.requestSerializerConfig.requestSerializerType = self.requestSerializerType;
//    requestModel.requestSerializerConfig.timeoutSeconds = self.requestTimeout;
//    requestModel.requestSerializerConfig.formDataBlock = self.formDataBlock;
    return [[CJPNetworkProxy sharedInstance] requestWithModel:requestModel].task.taskIdentifier;
}

- (CJPNetworkTaskID)callWithURL:(NSString *)urlString methodName:(NSString *)methodName params:(id)params completion:(CJPNetCompletion)completion
{
    return [self callWithURL:urlString methodName:methodName params:params uploadProgress:nil downloadProgress:nil cacheCompletion:nil completion:completion];
}

- (CJPNetworkTaskID)callWithURL:(NSString *)urlString methodName:(NSString *)methodName params:(id)params uploadProgress:(CJPNetUploadProgress)uploadProgress downloadProgress:(CJPNetDownloadProgress)downloadProgress cacheCompletion:(CJPNetCacheCompletion)cacheCompletion completion:(CJPNetCompletion)completion
{
    NSString *requestMethod = self.requestMethod;
    
    // 方法名有额外扩展路径
    NSString *fullMethodName = methodName;
    if (self.requestExtPreMethodPath) {
        fullMethodName = [NSString stringWithFormat:@"%@/%@", self.requestExtPreMethodPath, methodName];
    }
    
    urlString = [NSString stringWithFormat:@"%@/%@", urlString, fullMethodName];
    
    NSDictionary *extraHttpHeader;
    if (self.requestExtHeader) {
        extraHttpHeader = self.requestExtHeader;
    }
    
    CJPNetworkRequestSerializerModel *seriConfig = [CJPNetworkRequestSerializerModel modelWithSerializerType:@(self.requestSerializerType) timeout:self.requestTimeout];
    seriConfig.formDataBlock = self.formDataBlock;
    
    NSURLRequest *request = [self pcj_generateRequestWithSerializerModel:seriConfig urlString:urlString requestParams:params extraHttpHeadParmas:extraHttpHeader requestWithMethod:requestMethod];
    NSNumber *requestNum = [[CJPNetworkProxy sharedInstance] callWithRequest:request uploadProgress:uploadProgress downloadProgress:downloadProgress cacheCompletion:cacheCompletion completion:completion];
    return [requestNum unsignedIntegerValue];
}

@end

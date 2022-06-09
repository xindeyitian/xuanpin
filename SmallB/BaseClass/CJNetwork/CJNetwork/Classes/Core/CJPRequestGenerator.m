//
//  CJPRequestGenerator.m
//  AFNetworking
//
//  Created by Architray on 2019/10/12.
//

#import "CJPRequestGenerator.h"

#import "CJPServerFactory.h"
#import "CJPNetworkConfig.h"
#import <AFNetworking/AFNetworking.h>
#import "CJPBaseServer.h"
#import "NSURLRequest+CJPParams.h"
#import "CJPSignatureGenerator.h"
//#import "NSDictionary+CJPNetworkingMethods.h"

@interface CJPRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation CJPRequestGenerator

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static CJPRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[CJPRequestGenerator alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    
    self = [super init];
    [self initialRequestGenerator];
    return self;
}

- (void)initialRequestGenerator {
    
    _httpRequestSerializer = [AFJSONRequestSerializer serializer];
    _httpRequestSerializer.timeoutInterval = [CJPNetworkConfig shared].defaultTimeOutSeconds;
    _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    
}

#pragma mark - private method
- (NSURLRequest *)generateRequestWithSerializerModel:(CJPNetworkRequestSerializerModel *)serializerModel urlString:(NSString *)urlString requestParams:(id)requestParams extraHttpHeadParmas:(NSDictionary *)extraHttpHeadParmas requestWithMethod:(NSString *)method
{
    AFHTTPRequestSerializer *serializer = [self serializerForSerializerModel:serializerModel];
    NSMutableURLRequest *request;
    BOOL multiData = NO;
    if (serializerModel.formDataBlock) {
        if (![method isEqualToString:@"GET"] && ![method isEqualToString:@"HEAD"]) {
            multiData = YES;
        }else{
            NSLog(@"========form-data不能为GET或HEAD请求========");
        }
    }
    if (multiData) {
        request = [serializer multipartFormRequestWithMethod:method URLString:urlString parameters:requestParams constructingBodyWithBlock:serializerModel.formDataBlock error:NULL];
    }else{
        request = [serializer requestWithMethod:method URLString:urlString parameters:requestParams error:NULL];
    }
    if (extraHttpHeadParmas) {
        [extraHttpHeadParmas enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [request setValue:obj forHTTPHeaderField:key];
        }];
    }
    request.requestParams = requestParams;
    return request;
}

- (AFHTTPRequestSerializer *)serializerForSerializerModel:(CJPNetworkRequestSerializerModel *)serializerModel
{
    if (!serializerModel) {
        return self.httpRequestSerializer;
    }
    AFHTTPRequestSerializer *serializer;
    NSTimeInterval timeout = (serializerModel.timeoutSeconds ? serializerModel.timeoutSeconds.doubleValue : [CJPNetworkConfig shared].defaultTimeOutSeconds);
    switch (serializerModel.requestSerializerType) {
        case CJPRequestSerializerTypeJSON:{
            if (serializerModel.timeoutSeconds) {
                serializer = [AFJSONRequestSerializer serializer];
                serializer.timeoutInterval = timeout;
            }
        }
            break;
        case CJPRequestSerializerTypeHTTP:{
            if (serializerModel.timeoutSeconds) {
                timeout = serializerModel.timeoutSeconds.doubleValue;
            }
            serializer = [AFHTTPRequestSerializer serializer];
            serializer.timeoutInterval = timeout;
        }
            break;
        case CJPRequestSerializerTypePList:{
            if (serializerModel.timeoutSeconds) {
                timeout = serializerModel.timeoutSeconds.doubleValue;
            }
            serializer = [AFPropertyListRequestSerializer serializer];
            serializer.timeoutInterval = timeout;
        }
            break;
            
        default:
            break;
    }
    if (!serializer) {
        serializer = self.httpRequestSerializer;
    }
    return serializer;
}

@end

@implementation CJPRequestGenerator (CJServer)

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(id)requestParams methodName:(NSString *)methodName
{
    return [self generateRequestWithServiceIdentifier:serviceIdentifier requestParams:requestParams methodName:methodName requestWithMethod:@"GET"];
}

- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(id)requestParams methodName:(NSString *)methodName
{
    return [self generateRequestWithServiceIdentifier:serviceIdentifier requestParams:requestParams methodName:methodName requestWithMethod:@"POST"];
}

- (NSURLRequest *)generatePUTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(id)requestParams methodName:(NSString *)methodName
{
    return [self generateRequestWithServiceIdentifier:serviceIdentifier requestParams:requestParams methodName:methodName requestWithMethod:@"PUT"];
}

- (NSURLRequest *)generateDELETERequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(id)requestParams methodName:(NSString *)methodName
{
    return [self generateRequestWithServiceIdentifier:serviceIdentifier requestParams:requestParams methodName:methodName requestWithMethod:@"DELETE"];
}

//Extension
- (NSURLRequest *)generateRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(id)requestParams methodName:(NSString *)methodName requestWithMethod:(NSString *)method
{
    CJPBaseServer *service = [[CJPServerFactory sharedInstance] serverWithIdentifier:serviceIdentifier];
    
    NSString *urlString = [service urlGeneratingRuleByMethodName:methodName];
    
    NSDictionary *totalRequestParams = [self totalRequestParamsByService:service requestParams:requestParams];
    
    NSDictionary *extraHttpHeadParmas;
    if ([service.child respondsToSelector:@selector(extraHttpHeadParmasWithMethodName:)]) {
        extraHttpHeadParmas = [service.child extraHttpHeadParmasWithMethodName:methodName];
    }
    
    NSNumber *serializerType;
    if ([service.child respondsToSelector:@selector(serializerTypeByMethodName:)]) {
        serializerType = @([service.child serializerTypeByMethodName:methodName]);
    }
    NSNumber *timeout;
    if ([service.child respondsToSelector:@selector(timeoutByMethodName:)]) {
        timeout = @([service.child timeoutByMethodName:methodName]);
    }
    CJPNetworkRequestSerializerModel *seriConfig;
    if (serializerType || timeout) {
        seriConfig = [CJPNetworkRequestSerializerModel modelWithSerializerType:serializerType timeout:timeout];
    }
    return [self generateRequestWithSerializerModel:seriConfig urlString:urlString requestParams:totalRequestParams extraHttpHeadParmas:extraHttpHeadParmas requestWithMethod:method];
}

#pragma mark - private method
//根据Service拼接额外参数
- (NSDictionary *)totalRequestParamsByService:(CJPBaseServer *)service requestParams:(id)requestParams {
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

@end

@implementation CJPRequestGenerator (CJURL)

- (nullable NSURLRequest *)generateRequestWithRequestWithModel:(CJPNetworkRequestModel *)requestModel
{
    NSString *method;
    switch (requestModel.requestType) {
        case CJPNetworkRequestTypeGET:
            method = @"GET";
            break;
        case CJPNetworkRequestTypePOST:
            method = @"POST";
            break;
            
        default:
            return nil;
            break;
    }
    NSNumber *serializerType = @(requestModel.requestSerializerConfig.requestSerializerType);
    CJPNetworkRequestSerializerModel *seriConfig =  [CJPNetworkRequestSerializerModel modelWithSerializerType:serializerType timeout:requestModel.requestSerializerConfig.timeoutSeconds];
    return [self generateRequestWithSerializerModel:seriConfig urlString:requestModel.url requestParams:requestModel.parameters extraHttpHeadParmas:requestModel.extHeaderDict requestWithMethod:method];
}

@end

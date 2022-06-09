//
//  CJPBaseNetworkEngine.m
//  AFNetworking
//
//  Created by Architray on 2019/8/29.
//

#import "CJPBaseNetworkEngine.h"

#import "CJPNetworkProxy.h"
//#import "CJPNetworkManager.h"
#import "CJPNetworkRequestModel.h"
#import "NSObject+CJPNetworkAutoCancel.h"

@interface CJPBaseNetworkEngine ()

@property (nonatomic, strong, readwrite) CJPNetworkRequestTask *requestTask;

@end

@implementation CJPBaseNetworkEngine

#pragma mark ================ Configs ================

#pragma mark ================ LiftCircles ================

#pragma mark ================ Systems ================

#pragma mark ================ Target-Actions ================

#pragma mark ================ Interfaces ================
+ (CJPNetworkRequestTask *)GET:(NSString *)host uriPath:(NSString *)uriPath extHeaderDict:(nullable NSDictionary *)extHeaderDict target:(nullable NSObject *)target parameters:(id)parameters completion:(CJPNetworkResponseCompletion)completion {
    return [self target:target
                   host:host
                uriPath:uriPath
                 params:parameters
          extHeaderDict:extHeaderDict
            requestType:CJPNetworkRequestTypeGET
             cacheBlock:nil
          progressBlock:nil
               complete:completion];
}

+ (CJPNetworkRequestTask *)POST:(NSString *)host uriPath:(NSString *)uriPath extHeaderDict:(nullable NSDictionary *)extHeaderDict target:(nullable NSObject *)target parameters:(id)parameters completion:(CJPNetworkResponseCompletion)completion {
    return [self target:target
                   host:host
                uriPath:uriPath
                 params:parameters
          extHeaderDict:extHeaderDict
            requestType:CJPNetworkRequestTypePOST
             cacheBlock:nil
          progressBlock:nil
               complete:completion];
}

+ (CJPNetworkRequestTask *)target:(nullable NSObject *)target host:(NSString *)host uriPath:(NSString *)uriPath params:(nullable NSDictionary *)parameters extHeaderDict:(nullable NSDictionary *)extHeaderDict requestType:(CJPNetworkRequestType)requestType cacheBlock:(nullable CJPNetworkCacheResponseCompletion)cacheBlock progressBlock:(nullable CJPNetworkProgress)progressBlock complete:(CJPNetworkResponseCompletion)responseBlock {
    CJPBaseNetworkEngine *engine = CJPBaseNetworkEngine.new;
    
    CJPNetworkRequestModel *requestModel = [CJPNetworkRequestModel new];
    requestModel.requestType = requestType;
    requestModel.host = host;
    requestModel.uriPath = uriPath;
    requestModel.parameters = parameters;
    requestModel.extHeaderDict = extHeaderDict;
    requestModel.responseCacheBlock = cacheBlock;
    requestModel.progressBlock = progressBlock;
    
    __weak typeof(target) weakTarget = target;
    requestModel.responseBlock = ^(CJPNetworkResponse *response) {
        if (responseBlock) {
            responseBlock(response);
        }
        [weakTarget.networkAutoCancelProperty removeEngineWithRequestID:engine.requestTask.requestID];
    };
    
    CJPNetworkRequestTask *requestTask = [engine pcj_target:target requestModel:requestModel];
    engine.requestTask = requestTask;
    return requestTask;
}

+ (CJPNetworkRequestTask *)target:(nullable NSObject *)target
                requestSerializer:(nullable CJPNetworkRequestSerializerModel *)requestSerializer
                             host:(NSString *)host
                          uriPath:(NSString *)uriPath
                           params:(nullable NSDictionary *)parameters
                    extHeaderDict:(nullable NSDictionary *)extHeaderDict
                      requestType:(CJPNetworkRequestType)requestType
                       cacheBlock:(nullable CJPNetworkCacheResponseCompletion)cacheBlock
                    progressBlock:(nullable CJPNetworkProgress)progressBlock
                         complete:(CJPNetworkResponseCompletion)responseBlock
{
    CJPBaseNetworkEngine *engine = CJPBaseNetworkEngine.new;
    
    CJPNetworkRequestModel *requestModel = [CJPNetworkRequestModel new];
    requestModel.requestType = requestType;
    requestModel.host = host;
    requestModel.uriPath = uriPath;
    requestModel.parameters = parameters;
    requestModel.extHeaderDict = extHeaderDict;
    requestModel.responseCacheBlock = cacheBlock;
    requestModel.progressBlock = progressBlock;
    requestModel.requestSerializerConfig = requestSerializer;
    
    __weak typeof(target) weakTarget = target;
    requestModel.responseBlock = ^(CJPNetworkResponse *response) {
        if (responseBlock) {
            responseBlock(response);
        }
        [weakTarget.networkAutoCancelProperty removeEngineWithRequestID:engine.requestTask.requestID];
    };
    
    CJPNetworkRequestTask *requestTask = [engine pcj_target:target requestModel:requestModel];
    engine.requestTask = requestTask;
    return requestTask;
}

#pragma mark ================ Privates ================
- (CJPNetworkRequestTask *)pcj_target:(nullable NSObject *)target
                         requestModel:(CJPNetworkRequestModel *)requestModel {
    CJPNetworkRequestTask *requestTask = [[CJPNetworkProxy sharedInstance] requestWithModel:requestModel];
    [target.networkAutoCancelProperty setEngine:self requestID:requestTask.requestID];
    return requestTask;
}

#pragma mark ================ Delegates ================

#pragma mark ================ Getters-Setters ================
#pragma mark LazyLoad

@end

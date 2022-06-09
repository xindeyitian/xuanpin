//
//  CJPBaseNetworkEngine.h
//  AFNetworking
//
//  Created by Architray on 2019/8/29.
//

#import <Foundation/Foundation.h>

#import "CJPNetworkRequestTask.h"
#import "CJPNetworkDefines.h"
#import "CJPNetworkBaseReqModel.h"
#import "CJPNetworkResponseCallback.h"

NS_ASSUME_NONNULL_BEGIN

/**
 网络请求接口基类, 使用时先继承该类
 */
@interface CJPBaseNetworkEngine : NSObject

@property (nonatomic, strong, readonly) CJPNetworkRequestTask *requestTask;

+ (CJPNetworkRequestTask *)GET:(NSString *)host
                       uriPath:(NSString *)uriPath
                 extHeaderDict:(nullable NSDictionary *)extHeaderDict
                        target:(nullable NSObject *)target
                    parameters:(id)parameters
                    completion:(CJPNetworkResponseCompletion)completion;

+ (CJPNetworkRequestTask *)POST:(NSString *)host
                        uriPath:(NSString *)uriPath
                  extHeaderDict:(nullable NSDictionary *)extHeaderDict
                         target:(nullable NSObject *)target
                     parameters:(id)parameters
                     completion:(CJPNetworkResponseCompletion)completion;

/**
 发起网络请求
 
 @param target 持有对象(释放时, 取消该对象持有的所有请求)
 @param host 服务器地址
 @param uriPath 请求路径
 @param parameters 请求参数
 @param extHeaderDict 请求头额外信息
 @param requestType 请求类型(GET, POST)
 @param cacheBlock 请求缓存回调
 @param progressBlock 请求进度回调
 @param responseBlock 请求回调
 @return task对象
 */
+ (CJPNetworkRequestTask *)target:(nullable NSObject *)target
                             host:(NSString *)host
                          uriPath:(NSString *)uriPath
                           params:(nullable NSDictionary *)parameters
                    extHeaderDict:(nullable NSDictionary *)extHeaderDict
                      requestType:(CJPNetworkRequestType)requestType
                       cacheBlock:(nullable CJPNetworkCacheResponseCompletion)cacheBlock
                    progressBlock:(nullable CJPNetworkProgress)progressBlock
                         complete:(CJPNetworkResponseCompletion)responseBlock;

+ (CJPNetworkRequestTask *)target:(nullable NSObject *)target
            requestSerializerType:(nullable CJPNetworkRequestSerializerModel *)requestSerializerType
                             host:(NSString *)host
                          uriPath:(NSString *)uriPath
                           params:(nullable NSDictionary *)parameters
                    extHeaderDict:(nullable NSDictionary *)extHeaderDict
                      requestType:(CJPNetworkRequestType)requestType
                       cacheBlock:(nullable CJPNetworkCacheResponseCompletion)cacheBlock
                    progressBlock:(nullable CJPNetworkProgress)progressBlock
                         complete:(CJPNetworkResponseCompletion)responseBlock;

@end

NS_ASSUME_NONNULL_END

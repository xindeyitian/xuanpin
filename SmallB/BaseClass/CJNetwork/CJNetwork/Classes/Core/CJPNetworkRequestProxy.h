//
//  CJPNetworkRequestProxy.h
//  AFNetworking
//
//  Created by Architray on 2019/11/19.
//

#import <Foundation/Foundation.h>

#import "CJPNetworkBaseReqModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 使用说明:
 
 例子1:
 [CJPNetworkRequestProxy.POST callWithURL:@"https://app.cjdropshipping.com" methodName:@"app/picture/searchImg" params:@{} completion:^(id  _Nullable data, CJPNetError * _Nullable error) {
 
 }];
 例子2:
 [CJPNetworkRequestProxy.POST callWithServerIdentifier:CJServerIdApp methodName:@"app/picture/searchImg" params:@{} completion:^(id  _Nullable data, CJPNetError * _Nullable error) {
 
 }];
 例子3:
 CJPNetworkTaskID rId = [CJPNetworkRequestProxy.POST.timeout(50).serializerType(CJPRequestSerializerTypeJSON).extHeader([@{@"o" : @"oo"} mutableCopy]).formData(^(id <CJPNetworkMultipartFormData> formData){
 NSData *data = [@"https://cf.shopee.co.id/file/3ce4881960c5ba3501f5e7278f10dff6" dataUsingEncoding:NSUTF8StringEncoding];
 [formData appendPartWithFormData:data name:@"imgUrl"];
 }) callWithURL:@"https://app.cjdropshipping.com" methodName:@"app/picture/searchImg" params:@{} completion:^(id  _Nullable data, CJPNetError * _Nullable error) {
 
 }];
 */

@class CJPNetworkRequestProxy;

typedef CJPRequestID CJPNetworkTaskID;

typedef CJPNetworkRequestProxy * _Nonnull(^CJPNetworkRequestProxyAlloc)(NSString *method);
typedef CJPNetworkRequestProxy * _Nonnull(^CJPNetworkRequestProxyTimeout)(NSTimeInterval timeout);
typedef CJPNetworkRequestProxy * _Nonnull(^CJPNetworkRequestProxySerializerType)(CJPRequestSerializerType requestSerializerType);
typedef CJPNetworkRequestProxy * _Nonnull(^CJPNetworkRequestProxyFormData)(CJPNetworkRequestFormDataBlock formDataBlock);
typedef CJPNetworkRequestProxy * _Nonnull(^CJPNetworkRequestProxyExtHeader)(NSDictionary *extHeader);
typedef CJPNetworkRequestProxy * _Nonnull(^CJPNetworkRequestProxyExtPreMethodPath)(NSString *extPreMethodPath);

/**
 网络请求代理类
 默认为POST请求
 */
@interface CJPNetworkRequestProxy : NSObject

+ (instancetype)POST;

+ (instancetype)GET;

+ (CJPNetworkRequestProxyAlloc)METHOD;

@end

/**
 网络请求代理类
 
 链式语法拼接参数
 */
@interface CJPNetworkRequestProxy (CJRequestExpand)

/**
 取消单个网络请求
 
 @param requestID CJPNetworkTaskID的NSNumber类型
 */
+ (void)cancelRequestWithRequestID:(NSNumber *)requestID;

/**
 批量取消网络请求
 
 @param requestIDList CJPNetworkTaskID的NSNumber类型数组
 */
+ (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;

/**
 */
- (CJPNetworkRequestProxyTimeout)timeout;

/**
 默认为CJPRequestSerializerTypeJSON
 */
- (CJPNetworkRequestProxySerializerType)serializerType;

/**
 二进制
 不支持GET,HEAD请求
 */
- (CJPNetworkRequestProxyFormData)formData;

/**
 额外的请求头
 不包含Server中配置的
 */
- (CJPNetworkRequestProxyExtHeader)extHeader;

/**
 请求方法前缀
 
 比如:在app/login前需要加"ROOT"路径
 调用方法:
 [CJPNetworkRequestProxy.POST...extPreMethodPath(@"ROOT")... call.....methodName:@"app/login"....]
 实际路径为: "ROOT/app/login"
 */
- (CJPNetworkRequestProxyExtPreMethodPath)extPreMethodPath;

@end

@interface CJPNetworkRequestProxy (CJNetworkCallServer)

/**
 Server类网络请求
 请求callWithServerIdentifier:methodName:params:uploadProgress:downloadProgress:cacheCompletion:completion:的便捷版
 */
- (CJPNetworkTaskID)callWithServerIdentifier:(NSString *)serverIdentifier
                                  methodName:(NSString *)methodName
                                      params:(id)params
                                  completion:(CJPNetCompletion)completion;

/**
 Server类网络请求
 如果Server中已经配置了额外信息,多数据类型会替换Server中重复的数据.
 比如:
 * 1. Server中已经设置了超时时间timeout(15),该类中的超时时间会代替Server中配置的超时时间timeout(10).最终结果会是timeout(10)
 * 2. Server中已经设置了额外请求头Header(@{@"token":@"myToken", @"userId":@"myUserId"}),
 该类中的超时时间会代替Server中配置的额外请求头Header中的重复字段Header(@{@"token":@"myNewToken", @"time":@"1970-01-01"}).
 最终结果会是Header(@{@"token":@"myNewToken", @"userId":@"myUserId", @"time":@"1970-01-01"})
 
 @param serverIdentifier 服务器Id(在App中配置的代号)
 */
- (CJPNetworkTaskID)callWithServerIdentifier:(NSString *)serverIdentifier
                                  methodName:(NSString *)methodName
                                      params:(id)params
                              uploadProgress:(nullable CJPNetUploadProgress)uploadProgress
                            downloadProgress:(nullable CJPNetDownloadProgress)downloadProgress
                             cacheCompletion:(nullable CJPNetCacheCompletion)cacheCompletion
                                  completion:(CJPNetCompletion)completion;

@end

@interface CJPNetworkRequestProxy (CJNetworkCallURL)

//- (CJPNetworkTaskID)requestWithModel:(CJPNetworkBaseReqModel *)requestModel;

/**
 普通URL类网络请求
 请求callWithURL:methodName:params:uploadProgress:downloadProgress:cacheCompletion:completion:的便捷版
 */
- (CJPNetworkTaskID)callWithURL:(NSString *)urlString
                     methodName:(NSString *)methodName
                         params:(id)params
                     completion:(CJPNetCompletion)completion;

/**
 普通URL类网络请求
 
 @param urlString 服务器IP地址
 */
- (CJPNetworkTaskID)callWithURL:(NSString *)urlString
                     methodName:(NSString *)methodName
                         params:(id)params
                 uploadProgress:(nullable CJPNetUploadProgress)uploadProgress
               downloadProgress:(nullable CJPNetDownloadProgress)downloadProgress
                cacheCompletion:(nullable CJPNetCacheCompletion)cacheCompletion
                     completion:(CJPNetCompletion)completion;

@end

NS_ASSUME_NONNULL_END

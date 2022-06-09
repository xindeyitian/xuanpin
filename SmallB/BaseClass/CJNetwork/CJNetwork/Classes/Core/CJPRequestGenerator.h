//
//  CJPRequestGenerator.h
//  AFNetworking
//
//  Created by Architray on 2019/10/12.
//

#import <Foundation/Foundation.h>

#import "CJPNetworkRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJPRequestGenerator : NSObject

+ (instancetype)sharedInstance;

- (NSURLRequest *)generateRequestWithSerializerModel:(CJPNetworkRequestSerializerModel *)serializerModel urlString:(NSString *)urlString requestParams:(id)requestParams extraHttpHeadParmas:(NSDictionary *)extraHttpHeadParmas requestWithMethod:(NSString *)method;

@end

/**
 Server型的请求调用
 (推荐)
 */
@interface CJPRequestGenerator (CJServer)

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(id)requestParams methodName:(NSString *)methodName;
- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(id)requestParams methodName:(NSString *)methodName;
- (NSURLRequest *)generatePUTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(id)requestParams methodName:(NSString *)methodName;
- (NSURLRequest *)generateDELETERequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(id)requestParams methodName:(NSString *)methodName;

//Extension
- (NSURLRequest *)generateRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(id)requestParams methodName:(NSString *)methodName requestWithMethod:(NSString *)method;

@end

/**
 传统通用型请求调用
 */
@interface CJPRequestGenerator (CJRequestModel)

- (nullable NSURLRequest *)generateRequestWithRequestWithModel:(CJPNetworkBaseReqModel *)requestModel;

@end

NS_ASSUME_NONNULL_END

//
//  CJPNetworkRequestModel.h
//  AFNetworking
//
//  Created by Architray on 2019/8/29.
//

#import "CJPNetworkBaseReqModel.h"

#import "CJPNetworkResponseCallback.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJPNetworkRequestModel : CJPNetworkBaseReqModel

/**
 请求服务器地址
 */
@property (nonatomic, copy, nonnull) NSString *host;
/**
 请求uriPath
 */
@property (nonatomic, copy, nonnull) NSString *uriPath;
/**
 请求参数
 */
@property (nonatomic, strong, nullable) NSDictionary *parameters;
/**
 请求着陆回调
 */
@property (nonatomic, copy) CJPNetworkResponseCompletion responseBlock;

/**
 请求头额外信息
 */
@property (nonatomic, strong, nullable) NSDictionary *extHeaderDict;

/**
 请求缓存回调
 */
@property (nonatomic, copy, nullable) CJPNetworkResponseCompletion responseCacheBlock;
/**
 请求进度回调
 */
@property (nonatomic, copy, nullable) CJPNetworkProgress progressBlock;

/**
 请求URL(只读: 根据 host + uriPath 自动生成)
 */
@property (nonatomic, strong, readonly, nonnull) NSString *url;

@end

NS_ASSUME_NONNULL_END

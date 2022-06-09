//
//  CJPNetworkConfig.h
//  AFNetworking
//
//  Created by Architray on 2019/8/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJPNetworkConfig : NSObject

/**
 默认超时时间(秒)
 */
@property (nonatomic, assign) NSTimeInterval defaultTimeOutSeconds;

/**
 是否输出日志
 */
@property (nonatomic, assign) BOOL totalLogable;
/**
 是否输出请求参数日志
 */
@property (nonatomic, assign) BOOL requestLogable;
/**
 是否只显示附加的Header信息
 */
@property (nonatomic, assign) BOOL extHeaderLogable;
/**
 是否输出请求缓存数据
 */
@property (nonatomic, assign) BOOL cacheLogable;
/**
 是否输出请求进度数据
 */
@property (nonatomic, assign) BOOL progressLogable;
/**
 是否输出请求回调数据
 */
@property (nonatomic, assign) BOOL successLogable;
/**
 是否输出请求错误
 */
@property (nonatomic, assign) BOOL failureLogable;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END

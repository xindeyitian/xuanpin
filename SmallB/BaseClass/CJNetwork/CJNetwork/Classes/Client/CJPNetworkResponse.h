//
//  CJPNetworkResponse.h
//  AFNetworking
//
//  Created by Architray on 2019/8/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CJPNetworkBaseResulting <NSObject>

+ (instancetype)resultWithDict:(id)data;

@end

/**
 请求回调类
 */
@interface CJPNetworkResponse<Type: id> : NSObject

@property (nonatomic, strong, readonly) Type requestData;
@property (nonatomic, strong, readonly) NSError *error;

+ (instancetype)responseWithData:(nullable id)data error:(nullable NSError *)error;
- (instancetype)initWithData:(nullable id)data error:(nullable NSError *)error;

/**
 根据传入的类, 解析requestData
 如果已经被解析,且类型正确,则不会生效
 如果解析失败, 则返回 NSNull
 */
- (nullable Type (^)(Class<CJPNetworkBaseResulting> dataClass))resolvingDataForClass;
/**
 更新requestData值

 @param data 新的requestData值
 */
- (void)updateData:(nullable Type)data;

@end

NS_ASSUME_NONNULL_END

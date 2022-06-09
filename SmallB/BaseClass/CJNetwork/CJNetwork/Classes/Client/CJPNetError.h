//
//  CJPNetError.h
//  AFNetworking
//
//  Created by Architray on 2019/10/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CJPNetErrorType) {
    /**
     iOS系统原生错误
     */
    CJPNetErrorTypeSystem = 0,
    /**
     CJ后台请求错误码
     */
    CJPNetErrorTypeCustom,
    /**
     本地自定错误
     */
    CJPNetErrorTypeLocal
};

FOUNDATION_EXTERN NSInteger const CJPNetErrorLocalErrorCode;
FOUNDATION_EXTERN NSErrorDomain const CJPNetErrorCustomErrorDomain;

@interface CJPNetError : NSError

@property (nonatomic, assign) CJPNetErrorType errorType;

/**
 生成类型为CJPNetErrorTypeSystem的Error
 
 系统初始化方法errorWithDomain:code:userInfo:生成的对象也为CJPNetErrorTypeSystem类型
 */
+ (instancetype)errorWithNSError:(NSError *)error;

/**
 生成类型为CJPNetErrorTypeCustom的Error
 */
+ (instancetype)errorWithErrorCode:(NSInteger)errorCode;

/**
 生成类型为CJPNetErrorTypeLocal的Error
 message存放在domain字段中
 code默认为CJPNetErrorLocalErrorCode
 */
+ (instancetype)errorWithMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END

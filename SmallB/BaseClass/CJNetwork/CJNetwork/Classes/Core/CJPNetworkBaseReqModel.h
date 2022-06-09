//
//  CJPNetworkBaseReqModel.h
//  AFNetworking
//
//  Created by Architray on 2019/10/15.
//

#import <Foundation/Foundation.h>

#import "CJPNetError.h"
#import "CJPNetworkDefines.h"
#import "CJPNetworkCallback.h"
#import <AFNetworking/AFURLRequestSerialization.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - CJPNetworkRequestTypeModel

typedef void (^CJPNetworkRequestFormDataBlock)(id <AFMultipartFormData> formData);

@interface CJPNetworkRequestSerializerModel : NSObject

/**
 默认为CJPRequestSerializerTypeJSON
 */
@property (nonatomic, assign) CJPRequestSerializerType requestSerializerType;
/**
 请求超时时间(秒)
 */
@property (nonatomic, copy, nullable) NSNumber *timeoutSeconds;

@property (nonatomic, copy, nullable) CJPNetworkRequestFormDataBlock formDataBlock;

+ (instancetype)modelWithSerializerType:(NSNumber *)serializerType timeout:(NSNumber *)timeout;

@end

#pragma mark - CJPNetworkBaseReqModel
@interface CJPNetworkBaseReqModel : NSObject

/**
 */
@property (nonatomic, strong) CJPNetworkRequestSerializerModel *requestSerializerConfig;
/**
 请求类型, 默认为POST
 */
@property (nonatomic, assign) CJPNetworkRequestType requestType;

@end

NS_ASSUME_NONNULL_END

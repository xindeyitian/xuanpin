//
//  CJPBaseServer.h
//  AFNetworking
//
//  Created by Architray on 2019/10/16.
//

#import <Foundation/Foundation.h>

#import "CJPNetworkBaseReqModel.h"

NS_ASSUME_NONNULL_BEGIN

/******************************************************
 
 *******************************************
 ****              特别说明               ****
 *******************************************
 ****项目为Release配置下,只会使用RELEASE模式****
 *******************************************
 *******************************************
 
 
 使用说明:
 
 使用时继承CJPBaseServer并遵守CJPBaseServerProtocol协议,否则会失效
 
 设置environmentType以便用于多服务器开发
 
 当编译环境为release时,任何配置失效
 
 **************配置说明:**************
 调用[CJPServerFactory changeEnvironmentType:CJPNetworkEnvironmentType]方法
 默认为Develop环境
 
 ------------------自定义化------------------
 一)如果需要某模块URL自定义化,并保证其他模块可灵活配置
 例:(默认开发环境为DEVELOP,CJAPPServer自定义URL为:http://app.test.com)配置步骤如下:
 1)
 在项目中设置通用开发环境
 [CJPServerFactory changeEnvironmentType:CJPNetworkEnvironmentTypeDevelop]
 2)
 设置自定义环境时
 调用CJPServerFactory的configServerIdentifier:withCustomApiBaseUrl:方法
 如:
 [CJPServerFactory changeEnvironmentType:CJPNetworkEnvironmentTypeDevelop]
 [[CJPServerFactory sharedInstance] configServerIdentifier:CJHTTPServerApp withCustomApiBaseUrl:@"http://app.test.com"];
 
 ******************************************************/

/**
 开发、测试、预发、正式、HotFix和自定义环境,环境的切换是给开发人员和测试人员用的，对于外部正式打包不应该有环境切换的存在
 */
typedef NS_ENUM(NSUInteger, CJPNetworkEnvironmentType) {
    CJPNetworkEnvironmentTypeDevelop,
    CJPNetworkEnvironmentTypeTest,
    CJPNetworkEnvironmentTypePreRelease,
    CJPNetworkEnvironmentTypeHotFix,
    CJPNetworkEnvironmentTypeRelease,
    CJPNetworkEnvironmentTypeCustom
};

@protocol CJPBaseServerProtocol <NSObject>

/**
 开发、测试、预发、正式、HotFix五种环境的baseUrl在子类中实现，获取对应的URL赋值给apiBaseUrl，自定义在基类中进行保存获取
 */

@property (nonatomic, strong, readonly) NSString *developApiBaseUrl;
@property (nonatomic, strong, readonly) NSString *testApiBaseUrl;
@property (nonatomic, strong, readonly) NSString *prereleaseApiBaseUrl;
@property (nonatomic, strong, readonly) NSString *hotfixApiBaseUrl;
@property (nonatomic, strong, readonly) NSString *releaseApiBaseUrl;

@optional

//为某些Service需要拼凑额外字段到URL处
- (NSDictionary *)extraParmas;

//为某些Service需要拼凑额外的HTTPToken，如accessToken
- (NSDictionary *)extraHttpHeadParmasWithMethodName:(NSString *)methodName;

/**
 URL拼接逻辑

 @param methodName 方法名
 @return URLString
 */
- (NSString *)urlGeneratingRuleByMethodName:(NSString *)methodName;

/**
 发送请求类型

 @param methodName 方法名
 @return CJPRequestSerializerType
 */
- (CJPRequestSerializerType)serializerTypeByMethodName:(NSString *)methodName;

- (NSTimeInterval)timeoutByMethodName:(NSString *)methodName;

@end

@interface CJPBaseServer : NSObject

@property (nonatomic, assign) CJPNetworkEnvironmentType environmentType;

@property (nonatomic, strong, readonly) NSString *apiBaseUrl;
@property (nonatomic, strong, readonly) NSString *publicKey;
@property (nonatomic, strong, readonly) NSString *privateKey;
@property (nonatomic, strong, readonly) NSString *apiVersion;

@property (nonatomic, weak, readonly) id<CJPBaseServerProtocol> child;

- (NSString *)urlGeneratingRuleByMethodName:(NSString *)methodName;

@end

NS_ASSUME_NONNULL_END

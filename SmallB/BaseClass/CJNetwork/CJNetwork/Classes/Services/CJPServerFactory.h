//
//  CJPServerFactory.h
//  AFNetworking
//
//  Created by Architray on 2019/10/16.
//

#import <Foundation/Foundation.h>

#import "CJPBaseServer.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CJPServerFactoryDataSource <NSObject>

/*
 * key为service的Identifier
 * value为service的Class的字符串
 */
- (NSDictionary<NSString *,NSString *> *)serversKindsOfServerFactory;

@end

@interface CJPServerFactory : NSObject

@property (nonatomic, weak) id<CJPServerFactoryDataSource> dataSource;

+ (instancetype)sharedInstance;
+ (CJPNetworkEnvironmentType)getEnvironmentType;
+ (void)changeEnvironmentType:(CJPNetworkEnvironmentType)environmentType;
- (CJPBaseServer<CJPBaseServerProtocol> *)serverWithIdentifier:(NSString *)identifier;

/**
 配置自定义BaeURL
 !!!!!!!!!!!!!必须先配置dataSource!!!!!!!!!!!

 @param identifier 服务ID
 @param customApiBaseUrl 自定义URL, 传空代表删除自定义URL
 @return 操作是否成功
 */
- (BOOL)configServerIdentifier:(NSString *)identifier withCustomApiBaseUrl:(NSString *)customApiBaseUrl;

@end

NS_ASSUME_NONNULL_END

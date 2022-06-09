//
//  CJPServerFactory.m
//  AFNetworking
//
//  Created by Architray on 2019/10/16.
//

#import "CJPServerFactory.h"

static NSString *const CJPServerFactoryEnvironmentType = @"CJPServerFactoryEnvironmentType";

@interface CJPServerFactory ()

@property (nonatomic, strong) NSMutableDictionary *serverStorage;

@end

@implementation CJPServerFactory

#pragma mark - getters and setters
- (NSMutableDictionary *)serverStorage
{
    if (_serverStorage == nil) {
        _serverStorage = [[NSMutableDictionary alloc] init];
    }
    return _serverStorage;
}

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static CJPServerFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CJPServerFactory alloc] init];
    });
    return sharedInstance;
}

+ (CJPNetworkEnvironmentType)getEnvironmentType
{
#ifdef DEBUG
    NSNumber *environmentType = [[NSUserDefaults standardUserDefaults] objectForKey:CJPServerFactoryEnvironmentType];
    if (environmentType) {
        return environmentType.integerValue;
    }
    return CJPNetworkEnvironmentTypeDevelop;
#else
    return CJPNetworkEnvironmentTypeRelease;
#endif
}

+ (void)changeEnvironmentType:(CJPNetworkEnvironmentType)environmentType
{
    CJPServerFactory *factory = [self sharedInstance];
#ifdef DEBUG
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:environmentType]
                                              forKey:CJPServerFactoryEnvironmentType];
#else
    NSLog(@"在正式环境,environmentType无法改变,使用默认值:Release");
#endif
    [factory.serverStorage.allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CJPBaseServer *service = obj;
        service.environmentType = [self getEnvironmentType];
    }];
}

#pragma mark - public methods
- (CJPBaseServer<CJPBaseServerProtocol> *)serverWithIdentifier:(NSString *)identifier
{
    //多线程环境可能会引起崩溃，对dataSource加个同步锁
    @synchronized (self.dataSource) {
        
        NSAssert(self.dataSource, @"必须提供dataSource绑定并实现serversKindsOfserverFactory方法，否则无法正常使用server模块");
        
        if (self.serverStorage[identifier] == nil) {
            self.serverStorage[identifier] = [self newServerWithIdentifier:identifier];
        }
        return self.serverStorage[identifier];
        
    }
}

#pragma mark - private methods
- (CJPBaseServer<CJPBaseServerProtocol> *)newServerWithIdentifier:(NSString *)identifier
{
    NSAssert([self.dataSource respondsToSelector:@selector(serversKindsOfServerFactory)], @"请实现CJPserverFactoryDataSource的serversKindsOfserverFactory方法");
    
    if ([[self.dataSource serversKindsOfServerFactory] valueForKey:identifier]) {
        NSString *classStr = [[self.dataSource serversKindsOfServerFactory] valueForKey:identifier];
        id server = [[NSClassFromString(classStr) alloc]init];
        NSAssert(server, [NSString stringWithFormat:@"无法创建server，请检查serversKindsOfserverFactory提供的数据是否正确"],server);
        NSAssert([server conformsToProtocol:@protocol(CJPBaseServerProtocol)], @"你提供的server没有遵循CJPBaseserverProtocol");
        if ([server isKindOfClass:[CJPBaseServer class]]) {
            ((CJPBaseServer *)server).environmentType = [CJPServerFactory getEnvironmentType];
        }else{
            NSLog(@"\n\
                  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\
                  !!!!!!!!!!(%@)不是CJPBaseServer的子类,无法切换开发环境!!!!!!!!!\n\
                  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\
                  ", server);
        }
        return server;
    }else {
        NSAssert(NO, @"serversKindsOfserverFactory中无法找不到相匹配identifier");
    }
    
    return nil;
}

- (BOOL)configServerIdentifier:(NSString *)identifier withCustomApiBaseUrl:(NSString *)customApiBaseUrl
{
#ifdef DEBUG
    CJPBaseServer *server = [self serverWithIdentifier:identifier];
    
    NSString *serverClassName = NSStringFromClass([server class]);
    if ([[self class] isEmptyString:serverClassName]) {
        NSLog(@"自定义服务器为空");
        return NO;
    }
    if ([[self class] isEmptyString:customApiBaseUrl]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:serverClassName];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:customApiBaseUrl forKey:serverClassName];
        server.environmentType = CJPNetworkEnvironmentTypeCustom;
    }
    return YES;
#else
    NSLog(@"在正式环境,无法配置customApiBaseUrl");
    return NO;
#endif
}

+ (BOOL)isEmptyString:(NSString *)string
{
    if (string && [string isKindOfClass:[NSString class]] && string.length > 0) {
        return NO;
    }
    return YES;
}

@end

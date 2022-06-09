//
//  CJPBaseServer.m
//  AFNetworking
//
//  Created by Architray on 2019/10/16.
//

#import "CJPBaseServer.h"

@interface CJPBaseServer ()

@property (nonatomic, weak, readwrite) id<CJPBaseServerProtocol> child;
@property (nonatomic, strong) NSString *customApiBaseUrl;

@end

@implementation CJPBaseServer

@synthesize privateKey = _privateKey,apiBaseUrl = _apiBaseUrl;

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(CJPBaseServerProtocol)]) {
            self.child = (id<CJPBaseServerProtocol>)self;
            self.environmentType = CJPNetworkEnvironmentTypeRelease;
        }
    }
    return self;
}

- (NSString *)urlGeneratingRuleByMethodName:(NSString *)methodName {
    NSString *urlString = nil;
    if (self.apiVersion.length != 0) {
        urlString = [NSString stringWithFormat:@"%@/%@/%@", self.apiBaseUrl, self.apiVersion, methodName];
    } else {
        urlString = [NSString stringWithFormat:@"%@/%@", self.apiBaseUrl, methodName];
    }
    return urlString;
}

#pragma mark - getters and setters
- (void)setEnvironmentType:(CJPNetworkEnvironmentType)environmentType{
    if (environmentType == CJPNetworkEnvironmentTypeCustom) {
        if (![[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromClass([self class])]) {
            [[NSUserDefaults standardUserDefaults] setObject:self.apiBaseUrl forKey:NSStringFromClass([self class])];
        }
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSStringFromClass([self class])];
    }
    _environmentType = environmentType;
    _apiBaseUrl = nil;
}
- (NSString *)privateKey
{
    return _privateKey;
}

- (NSString *)apiBaseUrl
{
    if (_apiBaseUrl == nil) {
        switch (self.environmentType) {
            case CJPNetworkEnvironmentTypeDevelop:
                _apiBaseUrl = self.child.developApiBaseUrl;
                break;
            case CJPNetworkEnvironmentTypeTest:
                _apiBaseUrl = self.child.testApiBaseUrl;
                break;
            case CJPNetworkEnvironmentTypePreRelease:
                _apiBaseUrl = self.child.prereleaseApiBaseUrl;
                break;
            case CJPNetworkEnvironmentTypeHotFix:
                _apiBaseUrl = self.child.hotfixApiBaseUrl;
                break;
            case CJPNetworkEnvironmentTypeRelease:
                _apiBaseUrl = self.child.releaseApiBaseUrl;
                break;
            case CJPNetworkEnvironmentTypeCustom:
                _apiBaseUrl = self.customApiBaseUrl;
                break;
            default:
                break;
        }
    }
    return _apiBaseUrl;
}

- (NSString *)customApiBaseUrl{
    if (!_customApiBaseUrl) {
        _customApiBaseUrl = [[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromClass([self class])];
    }
    return _customApiBaseUrl;
}
@end

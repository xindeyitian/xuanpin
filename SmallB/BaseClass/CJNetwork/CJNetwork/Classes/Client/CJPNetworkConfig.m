//
//  CJPNetworkConfig.m
//  AFNetworking
//
//  Created by Architray on 2019/8/29.
//

#import "CJPNetworkConfig.h"

@interface CJPNetworkConfig ()

@end

@implementation CJPNetworkConfig

+ (instancetype)shared{
    static CJPNetworkConfig *_instance;
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[super allocWithZone:nil] init];
        });
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [CJPNetworkConfig shared];
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [CJPNetworkConfig shared];
}

- (instancetype)init {
    if (self = [super init]) {
        _defaultTimeOutSeconds = 15.f;
        _totalLogable = YES;
        _requestLogable = YES;
        _extHeaderLogable = NO;
        _cacheLogable = NO;
        _progressLogable = YES;
        _successLogable = YES;
        _failureLogable = YES;
    }
    return self;
}

#pragma mark ================ Configs ================

#pragma mark ================ LiftCircles ================

#pragma mark ================ Systems ================

#pragma mark ================ Target-Actions ================

#pragma mark ================ Interfaces ================

#pragma mark ================ Privates ================

#pragma mark ================ Delegates ================

#pragma mark ================ Getters-Setters ================
#pragma mark LazyLoad

@end

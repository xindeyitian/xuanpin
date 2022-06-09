//
//  CJPNetworkResponse.m
//  AFNetworking
//
//  Created by Architray on 2019/8/29.
//

#import "CJPNetworkResponse.h"

#import "CJPNetworkDefines.h"

// 解析g错误时, 返回的id对象
static id kCJPNetworkResolvingErrorReturnObj;
//#define kCJPNetworkResolvingErrorReturnObj (id)[NSNull null]

@interface CJPNetworkResponse ()

@end

@implementation CJPNetworkResponse

+ (instancetype)responseWithData:(nullable id)data error:(nullable NSError *)error {
    return [[CJPNetworkResponse alloc] initWithData:data error:error];
}

- (instancetype)initWithData:(nullable id)data error:(nullable NSError *)error{
    if (self = [super init]) {
        kCJPNetworkResolvingErrorReturnObj = [NSNull null];
        _requestData = data;
        _error = error;
    }
    return self;
}

#pragma mark ================ Configs ================

#pragma mark ================ LiftCircles ================

#pragma mark ================ Systems ================

#pragma mark ================ Target-Actions ================

#pragma mark ================ Interfaces ================
- (void)updateData:(nullable id)data {
    _requestData = data;
}

- (nullable id (^)(Class<CJPNetworkBaseResulting> dataClass))resolvingDataForClass {
    if (!self.error) {
        // 没有系统请求错误的情况下开始解析
        __weak typeof(self) weakSelf = self;
        if (![self.requestData respondsToSelector:@selector(resultWithDict:)]) {
            // 确认当前类没有被解析过
            return ^(Class<CJPNetworkBaseResulting>  _Nonnull __unsafe_unretained dataClass) {
                if ([dataClass conformsToProtocol:@protocol(CJPNetworkBaseResulting)] &&
                    [dataClass respondsToSelector:@selector(resultWithDict:)]) {
                    // 目标类遵从CJPNetworkBaseResulting协议
                    id result = [dataClass resultWithDict:weakSelf.requestData];
                    [weakSelf updateData:result];
                    if (!result) { CJNetDeLog(@"\nCJPNetworkResponse解析成功:但是目标类初始化后的实例为空"); }
                    return (result ?: kCJPNetworkResolvingErrorReturnObj);
                }else {
                    // 目标类不遵从CJPNetworkBaseResulting协议, 返回nil
                    CJNetDeLog(@"\nCJPNetworkResponse解析错误:目标类不支持CJPNetworkBaseResulting协议,返回nil");
                    @try {
                        CJNetDeLog(@"\n目标类:%@ \n值:%@", dataClass, weakSelf.requestData);
                    } @catch (NSException *exception) {} @finally {}
                    [weakSelf updateData:nil];
                    return kCJPNetworkResolvingErrorReturnObj;
                }
            };
        }else {
            // 已经被解析过
            return ^(Class<CJPNetworkBaseResulting>  _Nonnull __unsafe_unretained dataClass) {
                if ([weakSelf.requestData isKindOfClass:dataClass]) {
                    // 如果是目标类,返回原值
                    return weakSelf.requestData;
                }else {
                    // 如果当前类型与目标类型不一致, 返回nil
                    CJNetDeLog(@"\nCJPNetworkResponse解析错误:目标类类型不一致,返回nil");
                    @try {
                        CJNetDeLog(@"\n目标类:%@ \n值:%@", dataClass, weakSelf.requestData);
                    } @catch (NSException *exception) {} @finally {}
                    [weakSelf updateData:nil];
                    return kCJPNetworkResolvingErrorReturnObj;
                }
            };
        }
    }
    return ^(Class dataClass) { return kCJPNetworkResolvingErrorReturnObj; };
}

#pragma mark ================ Privates ================

#pragma mark ================ Delegates ================

#pragma mark ================ Getters-Setters ================
#pragma mark LazyLoad

@end

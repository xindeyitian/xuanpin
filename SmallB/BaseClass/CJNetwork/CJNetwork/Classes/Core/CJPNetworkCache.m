//
//  CJPNetworkCache.m
//  AFNetworking
//
//  Created by Architray on 2019/8/29.
//

#import "CJPNetworkCache.h"

#import "YYCache.h"

static NSString *const kCJPNetworkResponseCache = @"kCJPNetworkResponseCache";

static YYCache *_dataCache;

@interface CJPNetworkCache ()

@end

@implementation CJPNetworkCache

+ (void)initialize {
    _dataCache = [YYCache cacheWithName:kCJPNetworkResponseCache];
}

#pragma mark ================ Configs ================

#pragma mark ================ LiftCircles ================

#pragma mark ================ Systems ================

#pragma mark ================ Target-Actions ================

#pragma mark ================ Interfaces ================
+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(id)parameters {
    NSString *cacheKey = [self pcj_cacheKeyWithURL:URL parameters:parameters];
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}

+ (id)httpCacheForURL:(NSString *)URL parameters:(id)parameters {
    NSString *cacheKey = [self pcj_cacheKeyWithURL:URL parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}

+ (NSInteger)getAllHttpCacheSize {
    return [_dataCache.diskCache totalCost];
}

+ (void)removeAllHttpCache {
    [_dataCache.diskCache removeAllObjects];
}

#pragma mark ================ Privates ================
+ (NSString *)pcj_cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    if(!parameters || parameters.count == 0){return URL;};
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@%@",URL,paraString];
}

#pragma mark ================ Delegates ================

#pragma mark ================ Getters-Setters ================
#pragma mark LazyLoad

@end

//
//  CJPNetworkAutoCancelProperty.m
//  AFNetworking
//
//  Created by Architray on 2019/8/29.
//

#import "CJPNetworkAutoCancelProperty.h"

#import "CJPNetworkRequestTask.h"

@interface CJPNetworkAutoCancelProperty ()

@property (nonatomic, strong) NSMutableDictionary<NSNumber *,CJPBaseNetworkEngine *> *requestTasks;

@end

@implementation CJPNetworkAutoCancelProperty

#pragma mark ================ Configs ================

#pragma mark ================ LiftCircles ================
-(void)dealloc{
    [self.requestTasks enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, CJPBaseNetworkEngine * _Nonnull obj, BOOL * _Nonnull stop) {
        [obj.requestTask cancelRequest];
    }];
    [self.requestTasks removeAllObjects];
    self.requestTasks = nil;
}

#pragma mark ================ Systems ================

#pragma mark ================ Target-Actions ================

#pragma mark ================ Interfaces ================
- (void)setEngine:(CJPBaseNetworkEngine *)engine requestID:(NSNumber *)requestID {
    if (engine && requestID) {
        self.requestTasks[requestID] = engine;
    }
}

- (void)removeEngineWithRequestID:(NSNumber *)requestID {
    if (requestID) {
//        NSArray *keys = self.requestEngines.allKeys;
//        if ([keys containsObject:requestID]) {
        [self.requestTasks removeObjectForKey:requestID];
//        } else {
//            __block NSMutableArray *needRemove = [[NSMutableArray alloc] init];
//            [keys enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                if ([requestID isEqualToNumber:obj]) {
//                    [needRemove addObject:obj];
//                }
//            }];
//            if (needRemove.count > 0) {
//                [self.requestEngines removeObjectsForKeys:needRemove];
//            }
//        }
    }
}

#pragma mark ================ Privates ================

#pragma mark ================ Delegates ================

#pragma mark ================ Getters-Setters ================
#pragma mark LazyLoad
- (NSMutableDictionary *)requestTasks {
    if (_requestTasks == nil) {
        _requestTasks = [[NSMutableDictionary alloc] init];
    }
    return _requestTasks;
}

@end

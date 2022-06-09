//
//  CJPNetworkRequestTask.m
//  AFNetworking
//
//  Created by Architray on 2019/8/29.
//

#import "CJPNetworkRequestTask.h"

@interface CJPNetworkRequestTask ()

@end

@implementation CJPNetworkRequestTask

+ (instancetype)taskWithSessionTask:(NSURLSessionTask *) sessionTask {
    CJPNetworkRequestTask *requestTask = CJPNetworkRequestTask.new;
    requestTask.task = sessionTask;
    return requestTask;
}

#pragma mark ================ Configs ================

#pragma mark ================ LiftCircles ================

#pragma mark ================ Systems ================

#pragma mark ================ Target-Actions ================

#pragma mark ================ Interfaces ================
- (void)cancelRequest {
    if (_task) {
        [_task cancel];
    }
}

#pragma mark ================ Privates ================

#pragma mark ================ Delegates ================

#pragma mark ================ Getters-Setters ================
- (NSNumber *)requestID {
    if (_task) {
        return @(_task.taskIdentifier);
    }else {
        return nil;
    }
}

#pragma mark LazyLoad

@end

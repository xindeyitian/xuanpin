//
//  CJPNetworkRequestTask.h
//  AFNetworking
//
//  Created by Architray on 2019/8/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJPNetworkRequestTask : NSObject

@property (nonatomic, readonly) NSNumber *requestID;
@property (nonatomic, strong) NSURLSessionTask *task;

+ (instancetype)taskWithSessionTask:(NSURLSessionTask *) sessionTask;

/**
 *  取消self持有的hash的网络请求
 */
- (void)cancelRequest;

@end

NS_ASSUME_NONNULL_END

//
//  CJPNetworkAutoCancelProperty.h
//  AFNetworking
//
//  Created by Architray on 2019/8/29.
//

#import <Foundation/Foundation.h>

#import "CJPBaseNetworkEngine.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJPNetworkAutoCancelProperty : NSObject

- (void)setEngine:(CJPBaseNetworkEngine *)engine requestID:(NSNumber *)requestID;
- (void)removeEngineWithRequestID:(NSNumber *)requestID;

@end

NS_ASSUME_NONNULL_END

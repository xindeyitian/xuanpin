//
//  NSObject+CJPNetworkAutoCancel.h
//  AFNetworking
//
//  Created by Architray on 2019/8/29.
//

#import <Foundation/Foundation.h>

#import "CJPNetworkAutoCancelProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CJPNetworkAutoCancel)

@property(nonatomic, strong, readonly) CJPNetworkAutoCancelProperty *networkAutoCancelProperty;

@end

NS_ASSUME_NONNULL_END

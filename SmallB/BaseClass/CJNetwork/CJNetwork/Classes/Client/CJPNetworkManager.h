//
//  CJPNetworkManager.h
//  AFNetworking
//
//  Created by Architray on 2019/8/29.
//

#import <Foundation/Foundation.h>

#import "CJPNetworkRequestTask.h"
#import "CJPNetworkBaseReqModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 后期用CJNetworkProxy代替
 */
@interface CJPNetworkManager : NSObject

+ (CJPNetworkRequestTask *)requestWithModel:(CJPNetworkBaseReqModel *)requestModel;

@end

NS_ASSUME_NONNULL_END

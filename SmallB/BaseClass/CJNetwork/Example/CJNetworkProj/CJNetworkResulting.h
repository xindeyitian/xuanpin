//
//  CJNetworkResulting.h
//  CJNetwork
//
//  Created by Architray on 2019/8/30.
//  Copyright © 2019 architray. All rights reserved.
//

#ifndef CJNetworkResulting_h
#define CJNetworkResulting_h

#import "CJPNetworkResponse.h"

typedef NS_ENUM(NSInteger, CJNetworkResultCode) {
    CJNetworkResultCodeFailure = 0,
    /**
     请求正确
     */
    CJNetworkResultCodeSuccess = 200
};

@protocol CJNetworkResulting <CJPNetworkBaseResulting>

@property (nonatomic, assign) CJNetworkResultCode statusCode;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) id result;

@end

#endif /* CJNetworkResulting_h */

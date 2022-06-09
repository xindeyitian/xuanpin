//
//  CJNetworkBaseResult.h
//  CJNetworkProj
//
//  Created by Architray on 2019/8/30.
//  Copyright © 2019 architray. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CJNetworkResulting.h"
#import <YYModel/YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJNetworkBaseResult : NSObject <CJNetworkResulting>

@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) id result;

@end

NS_ASSUME_NONNULL_END

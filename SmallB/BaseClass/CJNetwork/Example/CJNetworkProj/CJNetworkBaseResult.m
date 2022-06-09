//
//  CJNetworkBaseResult.m
//  CJNetworkProj
//
//  Created by Architray on 2019/8/30.
//  Copyright © 2019 architray. All rights reserved.
//

#import "CJNetworkBaseResult.h"

@interface CJNetworkBaseResult ()

@end

@implementation CJNetworkBaseResult

+ (instancetype)resultWithDict:(id)data {
    CJNetworkBaseResult *result = [self yy_modelWithJSON:data];
    return result;
}

#pragma mark ================ Configs ================
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"statusCode"  : @"code",
             @"result"  : @"data"
             };
}

#pragma mark ================ LiftCircles ================

#pragma mark ================ Systems ================

#pragma mark ================ Target-Actions ================

#pragma mark ================ Interfaces ================

#pragma mark ================ Privates ================

#pragma mark ================ Delegates ================

#pragma mark ================ Getters-Setters ================
#pragma mark LazyLoad

@end

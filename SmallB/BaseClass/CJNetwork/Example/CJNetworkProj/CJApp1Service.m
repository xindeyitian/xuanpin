//
//  CJApp1Service.m
//  CJNetworkProj
//
//  Created by Architray on 2019/10/16.
//  Copyright © 2019 architray. All rights reserved.
//

#import "CJApp1Service.h"

@interface CJApp1Service ()

@end

@implementation CJApp1Service

#pragma mark ================ Configs ================

#pragma mark ================ LiftCircles ================

#pragma mark ================ Systems ================

#pragma mark ================ Target-Actions ================

#pragma mark ================ Interfaces ================
- (NSString *)releaseApiBaseUrl
{
    return @"https://app1.cjdropshipping.com";
}

- (NSString *)testApiBaseUrl
{
    return @"http://192.168.3.3:8088/test/";
}

-(NSTimeInterval)timeoutByMethodName:(NSString *)methodName
{
    return 5.0f;
}

//- (CJPRequestSerializerType)serializerTypeByMethodName:(NSString *)methodName
//{
//    return CJPRequestSerializerTypeHTTP;
//}

#pragma mark ================ Privates ================

#pragma mark ================ Delegates ================

#pragma mark ================ Getters-Setters ================
#pragma mark LazyLoad

@end

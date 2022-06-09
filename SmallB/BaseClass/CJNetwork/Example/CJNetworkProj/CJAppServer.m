//
//  CJAppServer.m
//  CJNetworkProj
//
//  Created by Architray on 2019/10/17.
//  Copyright © 2019 architray. All rights reserved.
//

#import "CJAppServer.h"

@interface CJAppServer ()

@end

@implementation CJAppServer

#pragma mark ================ Configs ================

#pragma mark ================ LiftCircles ================

#pragma mark ================ Systems ================

#pragma mark ================ Target-Actions ================

#pragma mark ================ Interfaces ================
- (NSString *)releaseApiBaseUrl
{
    return @"https://app.cjdropshipping.com/";
}

- (NSString *)testApiBaseUrl
{
    return @"http://192.168.5.3:8088/test";
}

- (NSDictionary *)extraHttpHeadParmasWithMethodName:(NSString *)methodName
{
    return @{@[@"oo", @"ii"][arc4random() % 2] : @[@"999", @"888"][arc4random() % 2]};
}

#pragma mark ================ Privates ================

#pragma mark ================ Delegates ================

#pragma mark ================ Getters-Setters ================
#pragma mark LazyLoad

@end

//
//  CJPNetworkManager.m
//  AFNetworking
//
//  Created by Architray on 2019/8/29.
//

#import "CJPNetworkManager.h"

#import "CJPNetworkProxy.h"

@interface CJPNetworkManager ()

@end

@implementation CJPNetworkManager

#pragma mark ================ Configs ================

#pragma mark ================ LiftCircles ================

#pragma mark ================ Systems ================

#pragma mark ================ Target-Actions ================

#pragma mark ================ Interfaces ================
+ (CJPNetworkRequestTask *)requestWithModel:(CJPNetworkBaseReqModel *)requestModel
{
    return [[CJPNetworkProxy sharedInstance] requestWithModel:requestModel];
}

#pragma mark ================ Privates ================

#pragma mark ================ Delegates ================

#pragma mark ================ Getters-Setters ================
#pragma mark LazyLoad

@end

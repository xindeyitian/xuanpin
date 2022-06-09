//
//  CJPNetwork.h
//  Pods
//
//  Created by Architray on 2019/8/29.
//

#ifndef CJPNetwork_h
#define CJPNetwork_h

/**
 ****************************************************
 一. 目前支持以下几种网络请求方式
 1. (推荐)基于Server网络请求,需要配置Server. 详情见CJPServerFactory和CJPBaseServer
 2. 传统URL方式(为了兼容老版本网络请求)
 
 ****************************************************
 二. 具体发起网络请求的类有以下几种
 1. CJPNetworkProxy
 兼容Server网络请求和URL网络请求.(URL请求推荐使用CJPBaseNetworkEngine)
 2. CJPNetworkRequestProxy
 (CJPNetworkProxy 的链式语法版本)
 兼容Server网络请求和URL网络请求.配置参数与Server中重复时,会替换重复部分的参数.
 3. CJPBaseNetworkEngine
 为了兼容老版本的网络请求. 不推荐使用
 
 ****************************************************
 */

#import "CJPBaseNetworkEngine.h"
#import "CJPNetworkResponse.h"
#import "CJPNetworkConfig.h"
#import "CJPNetworkRequestProxy.h"

// server
#import "CJPNetworkProxy.h"
#import "CJPBaseServer.h"
#import "CJPServerFactory.h"

#endif /* CJPNetwork_h */

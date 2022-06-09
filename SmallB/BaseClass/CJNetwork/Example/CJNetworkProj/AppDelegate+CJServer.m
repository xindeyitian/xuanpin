//
//  AppDelegate+CJServer.m
//  CJNetworkProj
//
//  Created by Architray on 2019/10/18.
//  Copyright © 2019 architray. All rights reserved.
//

#import "AppDelegate+CJServer.h"

@implementation AppDelegate (CJServer)

- (void)cj_serverConfig
{
    [CJPServerFactory sharedInstance].dataSource = self;
    [CJPNetworkConfig shared].defaultTimeOutSeconds = 60.f;
    [CJPServerFactory changeEnvironmentType:CJPNetworkEnvironmentTypeTest];
    [[CJPServerFactory sharedInstance] configServerIdentifier:CJHTTPServerApp
                                         withCustomApiBaseUrl:@"http://192.168.3.3:custom"];
}

- (NSDictionary<NSString *,NSString *> *)serversKindsOfServerFactory
{
    return @{
             CJHTTPServerCJ : @"CJApp1Service",
             CJHTTPServerApp : @"CJAppServer"
             };
}

@end

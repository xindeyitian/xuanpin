//
//  AppDelegate+CJServer.h
//  CJNetworkProj
//
//  Created by Architray on 2019/10/18.
//  Copyright © 2019 architray. All rights reserved.
//

#import "AppDelegate.h"

#import <CJPNetwork.h>
#import "CJPServerFactory.h"
#import "CJHTTPServerConst.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (CJServer) <CJPServerFactoryDataSource>

- (void)cj_serverConfig;

@end

NS_ASSUME_NONNULL_END

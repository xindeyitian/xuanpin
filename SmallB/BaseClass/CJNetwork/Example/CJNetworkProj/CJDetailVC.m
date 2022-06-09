//
//  CJDetailVC.m
//  CJNetworkProj
//
//  Created by Architray on 2019/8/29.
//  Copyright © 2019 architray. All rights reserved.
//

#import "CJDetailVC.h"

#import "CJPNetwork.h"

#import "CJHTTPServerConst.h"
#import "CJNetworkBaseResult.h"
#import <CJPNetwork/CJPNetwork.h>

@interface CJDetailVC ()

@property (nonatomic, weak) IBOutlet UILabel *timeLbl;
@property (nonatomic, assign) NSTimeInterval timeout;

@end

@implementation CJDetailVC

#pragma mark ================ Configs ================

#pragma mark ================ LiftCircles ================
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.timeout = (arc4random() % 4) * 5 + 10;
    
    self.timeLbl.text = [NSString stringWithFormat:@"timeout:%.1f", self.timeout];
}

- (void)dealloc {
    NSLog(@"dealloc");
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark ================ Systems ================

#pragma mark ================ Target-Actions ================
- (IBAction)btn1Clicked:(id)sender {
    NSDictionary *param = @{
                            @"platform" : @"ios",
                            @"name" : @"anan"
                            };
    [[CJPNetworkProxy sharedInstance] callPOSTWithServiceIdentifier:CJHTTPServerCJ methodName:@"app/platform/coollllll" params:param completion:^(id  _Nullable data, CJPNetError * _Nullable error)
     {
         
     }];
    return;
    [CJPBaseNetworkEngine target:self host:@"https://app.cjdropshipping.com/"
                         uriPath:@"app/platform/login" params:@{
                                                                @"platform" : @"ios",
                                                                @"isEncryption" : @"2",
                                                                @"name" : @"anan",
                                                                @"passwd" : @"dc483e80a7a0bd9ef71d8cf973673924"
                                                                }
                   extHeaderDict:@{@[@"oo", @"ii"][arc4random() % 2] : @"999"}
                     requestType:CJPNetworkRequestType_POST
                      cacheBlock:^(CJPNetworkResponse<CJNetworkBaseResult *> *response)
    {
//        NSLog(@"responseCacheBlock:%@", response.requestData);
//        response.resolvingDataForClass([NSString class]);
//        NSLog(@"%@", [response.requestData class]);
//        if (response.error) {
//
//        }else {
//
//        }
    } progressBlock:nil complete:^(CJPNetworkResponse *response)
    {
//        response.resolvingDataForClass([CJNetworkBaseResult class]);
        if (response.error) {
            
        }else {
            
        }
    }];
}

- (IBAction)btn2Clicked:(id)sender {
    NSDictionary *param = @{
                            @"platform" : @"ios",
                            @"isEncryption" : @"2",
                            @"name" : @"anan",
                            @"passwd" : @"dc483e80a7a0bd9ef71d8cf973673924"
                            };
    [[CJPNetworkProxy sharedInstance] callPOSTWithServiceIdentifier:CJHTTPServerApp methodName:@"app/platform/login" params:param completion:^(id  _Nullable data, CJPNetError * _Nullable error)
     {
         
     }];
}

#pragma mark ================ Interfaces ================

#pragma mark ================ Privates ================

#pragma mark ================ Delegates ================

#pragma mark ================ Getters-Setters ================
#pragma mark LazyLoad

@end

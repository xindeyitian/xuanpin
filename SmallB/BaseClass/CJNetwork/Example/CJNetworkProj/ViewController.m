//
//  ViewController.m
//  CJNetworkProj
//
//  Created by Architray on 2019/8/27.
//  Copyright © 2019 architray. All rights reserved.
//

#import "ViewController.h"

//#import <AFNetworking.h>
#import "CJPNetwork.h"
//#import <ATNetworkManager.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)btn1Clicked:(id)sender {
    [CJPBaseNetworkEngine POST:@"http://192.168.5.3:8088/" uriPath:@"cj/account/verifyAccountInfo" extHeaderDict:nil target:self parameters:@{@"userName" : @"124"} completion:^(CJPNetworkResponse *response) {
        if (response.error) {
            
        }else {
            
        }
    }];
}

- (IBAction)btn2Clicked:(id)sender {
    [CJPBaseNetworkEngine POST:@"https://app1.cjdropshipping.com/" uriPath:@"cj/account/verifyAccountInfo" extHeaderDict:nil target:self parameters:@{@"userName" : @"124"} completion:^(CJPNetworkResponse *response) {
        if (response.error) {
            
        }else {
            
        }
    }];
}


@end

//
//  CJPNetworkRequestModel.m
//  AFNetworking
//
//  Created by Architray on 2019/8/29.
//

#import "CJPNetworkRequestModel.h"

@interface CJPNetworkRequestModel () {
    NSString *_url;
}

@end

@implementation CJPNetworkRequestModel

#pragma mark ================ Configs ================

#pragma mark ================ LiftCircles ================

#pragma mark ================ Systems ================

#pragma mark ================ Target-Actions ================

#pragma mark ================ Interfaces ================

#pragma mark ================ Privates ================

#pragma mark ================ Delegates ================

#pragma mark ================ Getters-Setters ================
- (void)setHost:(NSString *)host {
    _host = host;
    
    _url = [NSString stringWithFormat:@"%@%@", _host, _uriPath];
}

- (void)setUriPath:(NSString *)uriPath {
    _uriPath = uriPath;
    
    _url = [NSString stringWithFormat:@"%@%@", _host, _uriPath];
}

- (NSString *)url {
    if (!_url) {
        _url = [NSString stringWithFormat:@"%@%@", _host, _uriPath];
    }
    return _url;
}

#pragma mark LazyLoad

@end

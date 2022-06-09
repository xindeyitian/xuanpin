//
//  CJPNetworkBaseReqModel.m
//  AFNetworking
//
//  Created by Architray on 2019/10/15.
//

#import "CJPNetworkBaseReqModel.h"

@implementation CJPNetworkRequestSerializerModel

- (instancetype)init
{
    if (self = [super init]) {
        _requestSerializerType = CJPRequestSerializerTypeJSON;
    }
    return self;
}

+ (instancetype)modelWithSerializerType:(NSNumber *)serializerType timeout:(NSNumber *)timeout
{
    CJPNetworkRequestSerializerModel *model = CJPNetworkRequestSerializerModel.new;
    if (serializerType) {
        CJPRequestSerializerType type = serializerType.unsignedIntegerValue;
        switch (type) {
            case CJPRequestSerializerTypeJSON:
            case CJPRequestSerializerTypeHTTP:
            case CJPRequestSerializerTypePList:
                break;
                
            default:
                type = CJPRequestSerializerTypeHTTP;
                break;
        }
        model.requestSerializerType = type;
    }
    model.timeoutSeconds = timeout;
    return model;
}

@end



@interface CJPNetworkBaseReqModel ()

@end

@implementation CJPNetworkBaseReqModel

- (instancetype)init {
    if (self = [super init]) {
        _requestSerializerConfig = [CJPNetworkRequestSerializerModel new];
        _requestSerializerConfig.requestSerializerType = CJPRequestSerializerTypeJSON;
        _requestType = CJPNetworkRequestTypePOST;
    }
    return self;
}

#pragma mark ================ Configs ================

#pragma mark ================ LiftCircles ================

#pragma mark ================ Systems ================

#pragma mark ================ Target-Actions ================

#pragma mark ================ Interfaces ================

#pragma mark ================ Privates ================

#pragma mark ================ Delegates ================

#pragma mark ================ Getters-Setters ================
#pragma mark LazyLoad

@end

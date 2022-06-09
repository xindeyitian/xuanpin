//
//  CJPNetError.m
//  AFNetworking
//
//  Created by Architray on 2019/10/12.
//

#import "CJPNetError.h"

NSInteger const CJPNetErrorLocalErrorCode = 0;
NSErrorDomain const CJPNetErrorCustomErrorDomain = @"CJPNetErrorCustomErrorDomain";

@interface CJPNetError ()

@end

@implementation CJPNetError

+ (instancetype)errorWithNSError:(NSError *)error
{
    CJPNetError *cjError;
    if (error) {
        if ([error isKindOfClass:[CJPNetError class]]) {
            cjError = (CJPNetError *)error;
        }else{
            cjError = [CJPNetError errorWithDomain:error.domain code:error.code userInfo:error.userInfo];
            cjError.errorType = CJPNetErrorTypeSystem;
        }
    }
    return cjError;
}

+ (instancetype)errorWithErrorCode:(NSInteger)errorCode
{
    CJPNetError *cjError;
    
    cjError = [CJPNetError errorWithDomain:CJPNetErrorCustomErrorDomain code:errorCode userInfo:nil];
    cjError.errorType = CJPNetErrorTypeCustom;
    
    return cjError;
}

+ (instancetype)errorWithMessage:(NSString *)message
{
    CJPNetError *cjError;
    
    NSString *errorMsg;
    if ([message isKindOfClass:[NSString class]]) {
        errorMsg = message;
    }else{
        @try {
            errorMsg = [NSString stringWithFormat:@"%@", message];
        } @catch (NSException *exception) {
            errorMsg = nil;
        } @finally {}
    }
    cjError = [CJPNetError errorWithDomain:(errorMsg ?: @"") code:CJPNetErrorLocalErrorCode userInfo:nil];
    cjError.errorType = CJPNetErrorTypeLocal;
    
    return cjError;
}

+ (instancetype)errorWithDomain:(NSErrorDomain)domain code:(NSInteger)code userInfo:(NSDictionary<NSErrorUserInfoKey,id> *)dict
{
    // NSURLErrorDomain
    CJPNetError *cjError = [super errorWithDomain:NSURLErrorDomain code:code userInfo:dict];
    cjError.errorType = CJPNetErrorTypeCustom;
    return cjError;
}

@end

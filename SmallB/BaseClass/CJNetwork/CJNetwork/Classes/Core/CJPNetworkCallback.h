//
//  CJPNetworkCallback.h
//  Pods
//
//  Created by Architray on 2019/10/17.
//

#ifndef CJPNetworkCallback_h
#define CJPNetworkCallback_h

typedef void (^CJPNetCompletion)(id _Nullable data, CJPNetError *_Nullable error);
typedef CJPNetCompletion CJPNetCacheCompletion;

typedef void (^CJPNetProgress)(NSProgress * _Nonnull progress);
typedef CJPNetProgress CJPNetUploadProgress;
typedef CJPNetProgress CJPNetDownloadProgress;

typedef NSUInteger CJPRequestID;

#endif /* CJPNetworkCallback_h */

//
//  CJPNetworkResponseCallback.h
//  Pods
//
//  Created by Architray on 2019/10/17.
//

#ifndef CJPNetworkResponseCallback_h
#define CJPNetworkResponseCallback_h

@class CJPNetworkResponse;

/**
 旧功能, 后期弃用
 */
/// 请求回调的Block
typedef void(^CJPNetworkResponseCompletion)(CJPNetworkResponse *response);

/// 缓存的Block
typedef CJPNetworkResponseCompletion CJPNetworkCacheResponseCompletion;

/// 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小
typedef void (^CJPNetworkProgress)(NSProgress *progress);

/// 网络状态的Block
//typedef void(^CJPNetworkStatus)(CJPNetworkStatusType status);

#endif /* CJPNetworkResponseCallback_h */

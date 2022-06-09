//
//  CJPNetworkDefines.h
//  Pods
//
//  Created by Architray on 2019/8/28.
//

#ifndef CJPNetworkDefines_h
#define CJPNetworkDefines_h

#ifdef DEBUG
#define CJNetDeLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define CJNetDeLog( s, ... )
#endif

typedef NS_ENUM(NSInteger, CJPNetworkRequestType) {
    CJPNetworkRequestTypeGET = 0,
    CJPNetworkRequestTypePOST,
    /**
     自定义
     */
    CJPNetworkRequestTypeCustom
};

typedef NS_ENUM(NSUInteger, CJPRequestSerializerType) {
    CJPRequestSerializerTypeHTTP = 0,
    CJPRequestSerializerTypeJSON,
    CJPRequestSerializerTypePList
};

#endif /* CJPNetworkConfig_h */

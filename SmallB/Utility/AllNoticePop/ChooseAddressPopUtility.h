//
//  ChooseAddressPopUtility.h
//  LLWFan
//
//  Created by 张昊男 on 2022/3/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^popSuccessBlock)(void);

@interface ChooseAddressPopUtility : NSObject

+ (instancetype)shareInstance;

- (void)popViewWithSuccessBlock:(popSuccessBlock )block;

@end

NS_ASSUME_NONNULL_END

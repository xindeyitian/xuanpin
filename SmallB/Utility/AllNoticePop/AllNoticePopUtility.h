//
//  AllNoticePopUtility.h
//  SmallB
//
//  Created by 张昊男 on 2022/3/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^popSuccessBlock)(void);

@interface AllNoticePopUtility : NSObject

+ (instancetype)shareInstance;

- (void)popViewWithTitle:(NSString *)title AndType:(noticeType )type AnddataBlock:(popSuccessBlock )block;

@end

NS_ASSUME_NONNULL_END

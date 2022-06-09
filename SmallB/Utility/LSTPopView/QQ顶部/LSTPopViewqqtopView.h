//
//  LSTPopViewqqView.h
//  LSTPopView_Example
//
//  Created by LoSenTrad on 2020/4/24.
//  Copyright © 2020 490790096@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    warning,
    success,
    hint,
} noticeType;

@interface LSTPopViewqqtopView : UIView

/// 提示信息
@property (copy, nonatomic) NSString *noticeTitle;

@property (assign, nonatomic) noticeType type;

@end

NS_ASSUME_NONNULL_END

//
//  WWMPlaceholderTextView.h
//  WildFireChat
//
//  Created by 杨晓铭 on 2020/11/24.
//  Copyright © 2020 WildFireChat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WWMPlaceholderTextView : UITextView


/**
 占位文字
 */
@property (nonatomic, copy) NSString *placeholder;

/**
 占位文字颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;



@end

NS_ASSUME_NONNULL_END

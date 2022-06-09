//
//  UpLoadUserpicTool.h
//  JiaXiHeZi
//
//  Created by 郑信鸿 on 16/6/17.
//  Copyright © 2016年 郑信鸿. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OpenSourceType){
    SourceTypeAll, //全部
    SourceTypeCamera, // 照相机
    SourceTypePhotoLibrary, // 相册
};

typedef void(^FinishSelectImageBlcok)(UIImage *image);

@interface UpLoadUserpicTool : NSObject

+ (UpLoadUserpicTool *)shareManager;


- (void)selectUserpicSourceWithViewController:(UIViewController *)viewController SourceType:(OpenSourceType)sourceType FinishSelectImageBlcok:(FinishSelectImageBlcok)finishSelectImageBlock;

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
@end

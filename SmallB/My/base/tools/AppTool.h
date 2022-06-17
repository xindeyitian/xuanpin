//
//  AppTool.h
//  SmallB
//
//  Created by zhang on 2022/4/19.
//

#import <Foundation/Foundation.h>
#import "HomeDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppTool : NSObject
/**
 存储用户角色
 */
+ (void)setCurrentLevalWithData:(NSString *)data;
/**
 获取用户角色
 */
+ (NSString *)getCurrentLeval;
/**
 加入橱窗以及分享赚钱按钮标题
 */
+ (NSString *)getCurrentLevalBtnInfo;

/**
 加入橱窗以及分享赚钱按钮图片
 */
+ (NSString *)getCurrentLevalBtnImageName;

/**
 判断是否是加入橱窗
 */
+ (BOOL)getCurrentLevalIsAdd;//是否是加入橱窗

/**
 加入橱窗以及分享赚钱按钮点击时间
 */
+ (void)roleBtnClickWithID:(NSString *)productID withModel:(GoodsListVosModel *)model;

/**
跳转详情
 */
+ (void)GoToProductDetailWithID:(NSString *)productID;

+ (void)copyWithString:(NSString *)string;

+ (UIViewController*)currentVC;

/**
 获取token
 */
+(NSString *)getLocalToken;

/**
 存储token
 */
+(void)saveToLocalToken:(NSString *)token;
/**
 存储到本地
 */
+(void)saveToLocalDataWithValue:(NSString *)value  key:(NSString *)key;

/**
 清除token
 */
+(void)cleanLocalToken;

+(NSString *)getLocalDataWithKey:(NSString *)key;
/**
 清除缓存的角色 头像 名称
 */
+ (void)cleanLocalDataInfo;


/// 上传回调
typedef void(^uploadCallblock)(BOOL success, NSString* msg, NSArray<NSString *>* keys);

+ (void)uploadImages:(NSArray *)images isAsync:(BOOL)isAsync callback:(uploadCallblock)callback;
/**
 存入历史搜索
 */
+(void)saveToLocalSearchHistory:(NSString *)searchStr;
/**
获取本地历史搜索
 */
+(NSMutableArray *)getLocalSearchHistory;
/**
 清除历史搜索
 */
+(void)cleanLocalSearchHistory;

/**
 获取当前时间戳
 */
+ (NSString *)currentdateInterval;

+ (NSString *)changeTimpStampFormate:(NSString *)timpStamp;

+(void)shareWebPageToPlatformTypeWithData:(UIImage *)image WXScene:(NSInteger)WXScene;

+ (UIImage *)createQRImageWithString:(NSString *)string;

+ (UIImage *)getCodeMaWithContent:(NSString *)content;

@end

NS_ASSUME_NONNULL_END

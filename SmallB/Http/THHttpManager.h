#import <Foundation/Foundation.h>
#import "model.h"
#import "THHttpConfig.h"
/*!
 @class
 @abstract 封装网络请求
 */

typedef enum : NSUInteger {
    headerImage = 1,
    friendCycle
} ImageFrom;

@interface THHttpManager : NSObject

/** 当前最新版本号*/
@property (nonatomic, copy) NSString *versionCode;
/** 是否强制更新*/
@property (nonatomic, copy) NSString *versionType;
/** 更新跳转地址*/
@property (nonatomic, copy) NSString *downloadUrl;
/** 通知*/
@property (nonatomic, copy) NSString *noticeData;

@property (nonatomic, assign) ImageFrom imgFromType;

/**
 登录之外的所有接口  包含userId token 参数的请求 内部已经添加

 @param URLString  路径地址
 @param parameters  公用参数之外的参数
 @param block 数据回传
 */
//+ (void)POST:(NSString *)URLString commonParameters:(id)parameters isSecret:(BOOL)isSecret dataBlock:(void (^)(NSInteger returnCode  , THRequestStatus status , id))block;
/**
 默认json
 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters dataBlock:(void (^)(NSInteger returnCode, THRequestStatus status , id))block;
/**
 默认表单
 */
+ (void)FormatPOST:(NSString *)URLString parameters:(id)parameters dataBlock:(void (^)(NSInteger returnCode, THRequestStatus status , id))block;

//复杂类型
+ (void)POSTComplexStructure:(NSString *)URLString commonParameters:(id)parameters  block:(void (^)(NSInteger, THRequestStatus, id))block;

/*!
 @method
 @abstract post请求
 @diXTussion post请求
 @param URLString  url
 @param parameters 参数
 @param timeInterval 超时时间
 没有公共参数
 */
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
withTimeoutInterval:(NSTimeInterval)timeInterval
 isSecret:(BOOL)isSecret
       block:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/**
 post请求

 @param URLString 地址
 @param parameters 参数
 @param block 请求回调
 */
//+ (void)POST:(NSString *)URLString parameters:(id)parameters isSecret:(BOOL)isSecret dataBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/*!
 @method
 @abstract get请求
 @diXTussion get请求
 @param URLString  url
 @param parameters 参数
 
 */
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    block:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

+ (void)AliGET:(NSString *)URLString
 parameters:(id)parameters
    block:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

+ (void)uploadImagePOST:(NSString *)URLString parameters:(id)parameters withFileName:(NSString *)fileName block:(void (^)(NSInteger returnCode, THRequestStatus status, id data))block;

+ (NSString *)getWANIPAddress;

- (void)uploadImgFile:(UIImage *)imageFile result:(void(^)(BOOL succeed, NSDictionary *dic))complete;

@end

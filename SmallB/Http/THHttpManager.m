#import "THHttpManager.h"
//#import <AFNetworking/AFHTTPSessionManager.h>
#import <AdSupport/AdSupport.h>
#import "NSString+SCCommon.h"
#import "SCMessageHelper.h"
#import "NSDictionary+SCCommon.h"
#import "AESCipher.h"
#import <MJExtension.h>
#import "MainTabarViewController.h"
#import "CouponChooseViewController.h"

typedef void(^XTHttpCallBackBlock)(NSInteger code, THRequestStatus status, id data);
@implementation THHttpManager
static NSString *AESKey = @"FA4ECD10BA9DB7CF";

+ (AFHTTPSessionManager *)configManger{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 1.初始化单例类
//    manager.securityPolicy.SSLPinningMode = AFSSLPinningModeCertificate;
    // 2.设置证书模式
//    NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"xxx" ofType:@"cer"];
//    NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
//    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[[NSSet alloc] initWithObjects:cerData, nil]];
//    // 客户端是否信任非法证书
    manager.securityPolicy.allowInvalidCertificates = YES;
    // 是否在证书域字段中验证域名
    [manager.securityPolicy setValidatesDomainName:NO];
    
    manager.requestSerializer.timeoutInterval = THTimeOutInterval;
    
    return  manager;
}

+ (void)GET:(NSString *)URLString parameters:(id)parameters block:(void(^)(NSInteger,THRequestStatus,id))block
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"multipart/form-data",@"text/html", @"image/jpeg",@"image/png",@"application/octet-stream", @"text/json",@"application/json",nil];
    NSString *UrlString = @"";
    if ([URLString containsString:@"http"]) {
        UrlString = URLString;
    }else{
        UrlString = [NSString stringWithFormat:@"%@%@",XTAppBaseURL,URLString];
    }
    //UrlString=[UrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSDictionary *dataDic = (NSDictionary *)parameters;
    NSDictionary *tokenDic = @{};
    NSString *token = [AppTool getLocalToken];
    if (token.length) {
        tokenDic = @{@"token":token};
    }
    NSLog(@"域名==%@\n参数：%@\n头信息：%@",UrlString,dataDic,tokenDic);
    [manager GET:UrlString parameters:dataDic headers:tokenDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self noSecretresponseSuccess:responseObject block:block];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self responseError:error block:block];
    }];
}


+ (void)AliGET:(NSString *)URLString
 parameters:(id)parameters
         block:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"multipart/form-data",@"text/html", @"image/jpeg",@"image/png",@"application/octet-stream", @"text/json",@"application/json",nil];
    NSString *UrlString = URLString;
    
    NSLog(@"域名==%@\n参数：%@",UrlString,parameters);
    [manager GET:UrlString parameters:parameters headers:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *data = responseObject;
        NSDictionary *dictionary = [data mj_JSONObject];
        NSLog(@"成功请求结果---%@",dictionary);
        block(200,THRequestStatusError,dictionary);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//POST请求
+ (void)POST:(NSString *)URLString parameters:(id)parameters dataBlock:(void (^)(NSInteger returnCode, THRequestStatus status , id))block{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"multipart/form-data",@"text/html", @"image/jpeg",@"image/png",@"application/octet-stream", @"text/json",@"application/json",nil];
    manager.requestSerializer.timeoutInterval = THTimeOutInterval;
    
    //生成新的默认
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //默认的类型
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = THTimeOutInterval;

    //[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSDictionary *tokenDic = @{};
    NSString *token = [AppTool getLocalToken];
    if (token.length) {
        tokenDic = @{@"token":token};
    }
    NSString *UrlString = @"";
    if ([URLString containsString:@"http"]) {
        UrlString = URLString;
    }else{
        UrlString = [NSString stringWithFormat:@"%@%@",XTAppBaseURL,URLString];
    }
    NSLog(@"域名==%@\n参数：%@\n头信息：%@",UrlString,parameters,tokenDic);
    [manager POST:UrlString parameters:parameters headers:tokenDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self noSecretresponseSuccess:responseObject block:block];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self responseError:error block:block];
    }];
}

//POST请求
+ (void)FormatPOST:(NSString *)URLString parameters:(id)parameters dataBlock:(void (^)(NSInteger returnCode, THRequestStatus status , id))block{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"multipart/form-data",@"text/html", @"image/jpeg",@"image/png",@"application/octet-stream", @"text/json",@"application/json",nil];
    manager.requestSerializer.timeoutInterval = THTimeOutInterval;
    
    //生成新的默认
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //默认的类型
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = THTimeOutInterval;

    //[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSDictionary *tokenDic = @{};
    NSString *token = [AppTool getLocalToken];
    if (token.length) {
        tokenDic = @{@"token":token};
    }
    NSString *UrlString = @"";
    if ([URLString containsString:@"http"]) {
        UrlString = URLString;
    }else{
        UrlString = [NSString stringWithFormat:@"%@%@",XTAppBaseURL,URLString];
    }
    NSLog(@"域名==%@\n参数：%@\n头信息：%@",UrlString,parameters,tokenDic);
    [manager POST:UrlString parameters:parameters headers:tokenDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self noSecretresponseSuccess:responseObject block:block];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self responseError:error block:block];
    }];
}

+ (void)noSecretresponseSuccess:(id)responseObject block:(void (^)(NSInteger, THRequestStatus, id))block
{
    THRequestStatus status = THRequestStatusError;
    NSString *data = responseObject;
    NSDictionary*  dictionary = [data mj_JSONObject];
    NSLog(@"成功请求结果---%@",dictionary);
    NSInteger  code =  [[dictionary valueForKey:@"code"] integerValue];
    NSString *msg = [dictionary valueForKey:@"message"];
    NSDictionary * data1 = [NSDictionary new];
    if (code == 200) {
        status = THRequestStatusOK;
        if ([[dictionary allKeys] containsObject:@"result"]) {
            data1 = [dictionary valueForKey:@"result"];
        }else{
            data1 = nil;
        }
    }else if(code == 401){
        //情况token
        [AppTool cleanLocalToken];
        [AppTool cleanLocalDataInfo];
        [THHttpManager showHttpMsg:@"请重新登录！"];
        LoginViewController * tab = [[LoginViewController alloc]init];
        [UIApplication sharedApplication].delegate.window.rootViewController = tab;
        if (block) {
            block(code,status,data1);
        }
        return;
    }else if (code == 10010){
        
        NSString *token = @"";
        if ([[dictionary allKeys] containsObject:@"result"]) {
            id resultData = [dictionary valueForKey:@"result"];
            if ([resultData isKindOfClass:[NSDictionary class]] && [[resultData allKeys] containsObject:@"token"])
                token = [resultData objectForKey:@"token"];
            if(token.length){
                [AppTool saveToLocalToken:token];
                [[NSUserDefaults standardUserDefaults]  setValue:@"1" forKey:@"login"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
        CouponChooseViewController *alertVC = [CouponChooseViewController new];
        alertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        alertVC.token = [AppTool getLocalToken];
        [[AppTool currentVC]  presentViewController:alertVC animated:NO completion:nil];
    }
    
    if (block) {
        if (status == THRequestStatusOK) {
            block(code,status,data1);
        }else{
            if(msg.length){
                [THHttpManager showHttpMsg:msg];
            }
            block(code,status,data1);
        }
    }
}

+ (void)showHttpMsg:(NSString *)msg{
    //[SCMessageHelper showAutoMessage:msg];
    [[AllNoticePopUtility shareInstance] popViewWithTitle:msg AndType:hint AnddataBlock:^{

    }];
}

+ (void)responseError:(NSError *)error block:(void (^)(NSInteger, THRequestStatus, id))block
{
    NSInteger errorCode = 000;//请求错误
    NSLog(@"失败请求结果---===%ld",(long)error.code);
    if ([[AFNetworkReachabilityManager sharedManager] isReachable] == NO) {
            errorCode = 998;
        [THHttpManager showHttpMsg:@"网络已断开，请检查网络"];
    }else{
        [THHttpManager showHttpMsg:@"服务器未连接"];
    }
    
    if (block) {
        block(errorCode,THRequestStatusError,error);
    }
}

/**
 上传公司logo图片
 
 @param URLString 地址
 @param image 图片
 @param parameters 参数
 @param block 回传信息
 */
+ (void)POSTCompanyPic:(NSString *)URLString  Image:(UIImage *)image commonParameters:(id)parameters dataBlock:(void (^)(NSInteger returnCode  , THRequestStatus status , id))block   Progrss:(void (^) (NSProgress * )  )Progress
{
    
    NSDictionary *dic = parameters;
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [mutableDic setValue:THUserManagerShareTHUserManager.userModel.userDetailsKey  forKey:@"userId"];
    [mutableDic setValue:THUserManagerShareTHUserManager.userModel.sessionId  forKey:@"token"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //默认的类型
    //    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"multipart/form-data",@"text/html", @"image/jpeg",@"image/png",@"application/octet-stream", @"text/json",@"application/json",nil];
    manager.requestSerializer.timeoutInterval = 60;
    NSString *UrlString = [NSString stringWithFormat:@"%@%@",XTAppBaseURL,URLString];
    
    NSString *fileName = [NSString stringWithFormat:@"%@.png", [NSString getUuid]];
    
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        
        data = UIImageJPEGRepresentation(image, 1.0);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    
    [manager POST:UrlString parameters:mutableDic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 上传文件
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (Progress) {
            Progress(uploadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self responseSuccess:responseObject block:block];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self responseError:error block:block];
        
    }];
}

+ (NSString *)getWANIPAddress
{
    NSError *error;
    NSURL *ipURL = [NSURL URLWithString:@"http://pv.sohu.com/cityjson?ie=utf-8"];

    NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
    //判断返回字符串是否为所需数据
    if ([ip hasPrefix:@"var returnCitySN = "]) {
        //对字符串进行处理，然后进行json解析
        //删除字符串多余字符串
        NSRange range = NSMakeRange(0, 19);
        [ip deleteCharactersInRange:range];
        NSString * nowIp =[ip substringToIndex:ip.length-1];
        //将字符串转换成二进制进行Json解析
        NSData * data = [nowIp dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict);
        return dict[@"cip"] ? dict[@"cip"] : @"";
    }
    return @"";
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters isSecret:(BOOL)isSecret block:(void (^)(NSInteger , THRequestStatus status, id data))block
{
    [self POST:URLString parameters:parameters withTimeoutInterval:THTimeOutInterval isSecret:isSecret block:block];
}

+ (void)allUploadImageWithImageArr:(NSArray *)imgArr
                      AndImagefrom:(ImageFrom )imgFrom
                             Block:(void (^)(NSInteger returnCode, THRequestStatus status, id data))block
                           Progrss:(void (^)(NSProgress * pro))Progress{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *UrlString = [NSString stringWithFormat:@"%@%@",XTAppBaseURL,@"/system/uploadPicture"];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:@(imgFrom) forKey:@"picType"];
    [parameters setValue:THUserManagerShareTHUserManager.userModel.userDetailsKey  forKey:@"userDetailsKey"];
    [parameters setValue:THUserManagerShareTHUserManager.userModel.sessionId  forKey:@"sessionId"];
    [manager POST:UrlString parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSUInteger i = 0;
        
        /**出于性能考虑,将上传图片进行压缩*/
        for (UIImage * image in imgArr) {
            
            //image的分类方法
//            UIImage *  resizedImage =  [UIImage IMGCompressed:image targetWidth:width];
            
            NSData * imgData = UIImageJPEGRepresentation(image, .3);

            NSString *fileName = [NSString stringWithFormat:@"%@-%ld-%ld.jpg",THUserManagerShareTHUserManager.userModel.userDetailsKey,imgFrom,i];
            
            //将得到的二进制图片拼接到表单中 /** data,指定上传的二进制流;name,服务器端所需参数名*/
            [formData appendPartWithFileData:imgData name:@"files" fileName:fileName mimeType:@"image/jpg"];
            
            i++;
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSInteger errCode = [responseObject[@"errorCode"] integerValue];
        
        [self noSecretresponseSuccess:responseObject block:block];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败%@",error.description);
        [self responseError:error block:block];
    }];
}

//传图
+ (void)uploadImagePOST:(NSString *)URLString parameters:(id)parameters withFileName:(NSString *)fileName block:(void (^)(NSInteger returnCode, THRequestStatus status, id data))block
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"multipart/form-data",@"text/html", @"image/jpeg",@"image/png",@"application/octet-stream", @"text/json",@"application/json",nil];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    manager.requestSerializer.timeoutInterval = THTimeOutInterval;

    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    //生成新的默认
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //默认的类型
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString *UrlString = [NSString stringWithFormat:@"%@%@",XTAppBaseURL,URLString];
    
    NSMutableDictionary *dataDic = (NSMutableDictionary *)parameters;
//    NSString *plainText = dataDic.mj_JSONString;
//    NSString *cipherText = aesEncryptString(plainText, AESKey);
//    NSDictionary *dicAes = @{@"Data": plainText};
    NSData *imgData = [dataDic objectForKey:@"file"];
    
    NSDictionary *tokenDic = @{};
    NSString *token = [AppTool getLocalToken];
    if (token.length) {
        tokenDic = @{@"token":token};
    }
    if (![fileName containsString:@".png"]) {
        fileName = [fileName stringByAppendingString:@".png"];
    }
    [manager POST:UrlString parameters:nil headers:tokenDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imgData name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self noSecretresponseSuccess:responseObject block:block];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败%@",error.description);
        [self responseError:error block:block];
    }];
}

+ (void)responseSuccess:(id)responseObject block:(void (^)(NSInteger, THRequestStatus, id))block
{
    THRequestStatus status = THRequestStatusError;
//    NSDictionary *res = [responseObject JSONObject];
    NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
    NSString *msg = [responseObject valueForKey:@"msg"];
    if (code == 200) {
       status = THRequestStatusOK;
        NSDictionary *dictionary = [NSDictionary new];
        if ([[responseObject allKeys] containsObject:@"data"] && [[responseObject objectForKey:@"data"] isKindOfClass:[NSString class]]) {
            
            dictionary = aesDecryptString([responseObject objectForKey:@"data"], AESKey).JSONObject;
        }
        PLog(@"%@",dictionary);
        if (block) {
            
             block(code,status,dictionary);
        }
    }else if (code == 999){
        [SSProgressHUD showText:@"您的账号已在其他设备登录,如非您本人操作请您立即修改密码！" maskType:SSProgressHUDMaskTypeBlack finished:^{
            
            [THUserManager logOut];
        }];
    }else if(code == 201){
        if(msg != nil){
            [THHttpManager showHttpMsg:msg];
        }else{
            [THHttpManager showHttpMsg:@"服务器提示nil"];
        }
         block(code,status,nil);
    }
}

/**
 *  返回当前时间
 */
- (NSString *)getTimeNow
{
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYYMMddhhmmss"];
    date = [formatter stringFromDate:[NSDate date]];
    //取出个随机数
    int last = arc4random() % 10000;
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@-%i", date,last];
    NSLog(@"%@", timeNow);
    return timeNow;
}

/**
 *  压缩图片
 */
- (NSData *)imageZipToData:(UIImage *)newImage{
    
    NSData *data = UIImageJPEGRepresentation(newImage, 1.0);
    
    if (data.length > 500 * 1024) {
        
        if (data.length>1024 * 1024) {//1M以及以上
            
            data = UIImageJPEGRepresentation(newImage, 0.5);
            
        }else if (data.length>512*1024) {//0.5M-1M
            
            data=UIImageJPEGRepresentation(newImage, 0.6);
            
        }else if (data.length>200*1024) { //0.25M-0.5M
            
            data=UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return data;
}

@end

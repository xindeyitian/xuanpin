//
//  AppTool.m
//  SmallB
//
//  Created by zhang on 2022/4/19.
//

#import "AppTool.h"
#import "ProductDetailViewController.h"
#import "QNUploadManager.h"
#import "QNConfiguration.h"
#import "QNFixedZone.h"
#import "QNResponseInfo.h"
#import "WXApi.h"
#import <CoreImage/CoreImage.h>

@implementation AppTool

+ (void)setCurrentLevalWithData:(NSString *)data{
    //    integer($int32)
    //店铺展示类型（1创业者、2自营工厂、3混合）
    if (data.length && K_NotNull(data)) {
        [[NSUserDefaults standardUserDefaults]  setValue:data forKey:@"leval"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (NSString *)getCurrentLeval{
  
    NSString *leval = [[NSUserDefaults standardUserDefaults] objectForKey:@"leval"];
    return leval;
}

+ (NSString *)getCurrentLevalBtnInfo{
    //return @"转发赚钱";
    NSString *leval = [[NSUserDefaults standardUserDefaults] objectForKey:@"leval"];
    if ([leval isEqualToString:@"1"]) {
        return @"转发赚积分";
    }
    if ([leval isEqualToString:@"2"]) {
        return @"加入橱窗";
    }
    return @"";
}

+ (NSString *)getCurrentLevalBtnImageName{
    //return @"home_share";
    NSString *leval = [[NSUserDefaults standardUserDefaults] objectForKey:@"leval"];
    if ([leval isEqualToString:@"1"]) {
        return @"home_share";
    }
    if ([leval isEqualToString:@"2"]) {
        return @"add";
    }
    return @"";
}

//是否是加入橱窗
+ (BOOL)getCurrentLevalIsAdd{
    //return YES;
    NSString *leval = [[NSUserDefaults standardUserDefaults] objectForKey:@"leval"];
    if ([leval isEqualToString:@"1"]) {
        return NO;
    }
    if ([leval isEqualToString:@"2"]) {
        return YES;
    }
    return NO;
}

+ (void)roleBtnClickWithID:(NSString *)productID withModel:(GoodsListVosModel *)model{
    if ([self getCurrentLevalIsAdd]) {
        [self saveShopGoodsWithProductID:productID];
    }else{
        ProductShareViewController *vc = [[ProductShareViewController alloc]init];
        vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        vc.model = model;
        [[AppTool currentVC] presentViewController:vc animated:NO completion:nil];
    }
}

+ (void)saveShopGoodsWithProductID:(NSString *)productID{
  
    THBaseViewController *vc = (THBaseViewController *)[AppTool currentVC];
    [vc startLoadingHUD];
    [THHttpManager FormatPOST:@"goods/shopGoods/saveShopGoods" parameters:@{@"goodsId":K_NotNullHolder(productID, @"")} dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [vc stopLoadingHUD];
        if(returnCode == 200){
            [XHToast dismiss];
            [XHToast showCenterWithText:@"加入橱窗成功" withName:@""];
        }
    }];
}

+ (void)GoToProductDetailWithID:(NSString *)productID{
    ProductDetailViewController *vc = [[ProductDetailViewController alloc]init];
    vc.productID = K_NotNullHolder(productID, @"");
    [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
}

+ (void)copyWithString:(NSString *)string{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = string;
}

+ (UIViewController *)topController {
    UIViewController *topController = [[self keyWindow] rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController])    topController = [topController presentedViewController];
    
    //  Returning topMost ViewController
    return topController;
}

+ (UIWindow *)keyWindow {
    static __weak UIWindow *_keyWindow = nil;
    
    /*  (Bug ID: #23, #25, #73)   */
    UIWindow *originalKeyWindow = [[UIApplication sharedApplication] keyWindow];
    
    //If original key window is not nil and the cached keywindow is also not original keywindow then changing keywindow.
    if (originalKeyWindow != nil &&
        _keyWindow != originalKeyWindow)
    {
        _keyWindow = originalKeyWindow;
    }
    
    return _keyWindow;
}

+ (UIViewController*)currentVC;
{
    UIViewController *currentViewController = [self topController];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    
    if ([currentViewController isKindOfClass:[UITabBarController class]]) {
        currentViewController = ((UITabBarController *)currentViewController).selectedViewController;
    }
    
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    
    return currentViewController;
}

+(NSString *)getLocalToken{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    //token = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTE3Mzc0NTcsInVzZXJuYW1lIjoiMTMzNDA4ODYzNzAifQ.WGdC9aMyU5BZ-7EHjnRu0dko2q14t1rBzTJXyYRWBM4";
    //token = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTE4MDcwNzQsInVzZXJuYW1lIjoiMTUxNjg0MDY3OTIifQ.s6YyI2bLoqrqtSrjaG4ByHUiwixVc7PMdl1zkFF_L0Q";
    if(!K_NotNull(token)) {
        return @"";
    }
    return token;
}

+(NSString *)getLocalDataWithKey:(NSString *)key{
    NSString *local = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if(!K_NotNull(local)) {
        return @"";
    }
    return local;
}

+(void)saveToLocalToken:(NSString *)token{
    if (token.length && K_NotNull(token)) {
        [[NSUserDefaults standardUserDefaults]  setValue:token forKey:@"token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+(void)saveToLocalDataWithValue:(NSString *)value  key:(NSString *)key{
    if (key.length && value.length) {
        [[NSUserDefaults standardUserDefaults]  setValue:value forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+(void)cleanLocalToken{
    [[NSUserDefaults standardUserDefaults]  setValue:@"" forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)cleanLocalDataInfo{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userLogo"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userPhone"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"leval"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userID"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shopID"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"inviteCode"];
}

+ (void)uploadImages:(NSArray *)images isAsync:(BOOL)isAsync callback:(uploadCallblock)callback {
    [THHttpManager GET:@"system/file/getUpToken" parameters:@{} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            [AppTool dealDataWithDic:data Images:images isAsync:isAsync callback:callback];
        }
    }];
}

+ (void)dealDataWithDic:(NSDictionary *)data Images:(NSArray *)images isAsync:(BOOL)isAsync callback:(uploadCallblock)callback{
    NSString *token = K_NotNullHolder([data objectForKey:@"token"], @"");
    NSString *secretKey = K_NotNullHolder([data objectForKey:@"secretKey"], @"");
    NSString *accessKey = K_NotNullHolder([data objectForKey:@"accessKey"], @"");
    NSString *baseUrl = K_NotNullHolder([data objectForKey:@"baseUrl"], @"");
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = images.count;

    NSMutableArray *callBackNames = [NSMutableArray array];
    int i = 0;
    for (UIImage *image in images) {
        if (image) {
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{

                NSString *imageName = [NSString stringWithFormat:@"%@",[AppTool currentdateInterval]];
                NSData *data;
                if (UIImagePNGRepresentation(image) == nil)
                {
                    data = UIImageJPEGRepresentation(image, 1.0);
                    imageName = [imageName stringByAppendingString:[NSUUID UUID].UUIDString];
                }else{
                    data = UIImagePNGRepresentation(image);
                    imageName = [imageName stringByAppendingString:[NSUUID UUID].UUIDString];
                }
                [callBackNames addObject:imageName];
                
                QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
//                    builder.zone = [QNFixedZone zone0];
                }];
                QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
                [upManager putData:data key:imageName token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {

                    if(info.ok){
                        NSLog(@"请求成功");
                        if (isAsync) {
                            if (image == images.lastObject) {
                                NSLog(@"upload object finished!");
                                if (callback) {
                                    callback( YES, baseUrl , [callBackNames copy]);
                                }
                            }
                        }
                    }else{
                        NSLog(@"失败");
                        //如果失败，这里可以把info信息上报自己的服务器，便于后面分析上传错误原因
                    }
                } option:nil];
                
            }];
            if (queue.operations.count != 0) {
                [operation addDependency:queue.operations.lastObject];
            }
            [queue addOperation:operation];
         }
        i++;
    }
    if (!isAsync) {
    
        if (callback) {
            callback( YES, @"全部上传完成" , [callBackNames copy]);
        }
    }
}

+(void)saveToLocalSearchHistory:(NSString *)searchStr{
    if (searchStr.length == 0) {
        return;
    }
    
    NSMutableArray *localAry = [NSMutableArray arrayWithArray:[self getLocalSearchHistory]];
    if ([localAry containsObject:searchStr]) {
        [localAry removeObject:searchStr];
    }
    [localAry insertObject:searchStr atIndex:0];
    NSMutableArray *resultAry = [NSMutableArray array];
    if (localAry.count > 6) {
        resultAry = [[localAry subarrayWithRange:NSMakeRange(0, 6)] mutableCopy];
    }else{
        [resultAry addObjectsFromArray:localAry];
    }
    NSSet *set = [NSSet setWithArray:localAry];
    NSLog(@"新增后本地存储%@",[set allObjects]);
    [[NSUserDefaults standardUserDefaults]  setValue:resultAry forKey:@"searchList"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSMutableArray *)getLocalSearchHistory{
    id data = [[NSUserDefaults standardUserDefaults] objectForKey:@"searchList"];
    NSLog(@"本地存储%@",data);
    if (data && [data isKindOfClass:[NSArray class]]) {
        return data;
    }
    return [NSMutableArray array];
}

+(void)cleanLocalSearchHistory{
    [[NSUserDefaults standardUserDefaults]  setValue:[NSArray array] forKey:@"searchList"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)currentdateInterval {
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];
    return timeSp;
}

+ (NSString *)changeTimpStampFormate:(NSString *)timpStamp {
    
    NSString *timeStr;
    if ([timpStamp length] >= 10) {
        timeStr = [timpStamp substringToIndex:10];
    } else {
        timeStr = @"0";
    }
    NSTimeInterval timeStamp = [timeStr integerValue];
    NSDate *creatDate = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:creatDate];
    return destDateString;
}

+ (NSString *)changeTimeStampFormate:(NSString *)timpStamp {
    
    NSString *timeStr;
    if ([timpStamp length] >= 10) {
        timeStr = [timpStamp substringToIndex:10];
    } else {
        timeStr = @"0";
    }
    NSTimeInterval timeStamp = [timeStr integerValue];
    NSDate *creatDate = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:creatDate];
    return destDateString;
}

+(void)shareWebPageToPlatformTypeWithData:(UIImage *)image title:(NSString *)title description:(NSString *)description webpageUrl:(NSString *)webpageUrl  WXScene:(NSInteger)WXScene thumbUrl:(NSString *)url{

//    WXImageObject *imageObject = [WXImageObject object];
//    imageObject.imageData = UIImageJPEGRepresentation(image, 0.7);
   
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = webpageUrl;

    WXMediaMessage *message = [WXMediaMessage message];
    message.mediaObject = ext;
    message.description = description;
    message.title = title;
//    [message setThumbImage:IMAGE_NAMED(@"icon_image")];
    //message.thumbData = UIImageJPEGRepresentation(image, 0.2);
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *result = [UIImage imageWithData:imageData];
    [message setThumbImage:[AppTool compressImage:result toByte:32765]];
    //缩略图要小于32KB，否则无法调起微信,32KB = 32*1024B=32678

    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXScene;
    NSLog(@"====%@",url);
    if ([WXApi isWXAppInstalled]) {
        [WXApi sendReq:req completion:^(BOOL success) {

        }];
    }else{
        [(THBaseViewController *)[AppTool currentVC] showMessageWithString:@"请先安装微信"];
    }
}

#pragma mark - 压缩图片
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}



+ (UIImage *)createQRImageWithString:(NSString *)string{
    return [self createQRImageWithString:string size:CGSizeMake(80, 80)];
}

//生成制定大小的黑白二维码
+ (UIImage *)createQRImageWithString:(NSString *)string size:(CGSize)size
{
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    CIImage *qrImage = qrFilter.outputImage;
    //放大并绘制二维码（上面生成的二维码很小，需要放大）
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    //翻转一下图片 不然生成的QRCode就是上下颠倒的
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    
    CGImageRelease(cgImage);
    
    //return codeImage;
    return [self addImageForQRImage:codeImage];
}

//在二维码中心加一个小图
+ (UIImage *)addImageForQRImage:(UIImage *)qrImage
{
    UIGraphicsBeginImageContext(qrImage.size);
    
    [qrImage drawInRect:CGRectMake(0, 0, qrImage.size.width, qrImage.size.height)];
    
    UIImage *image = [UIImage imageNamed:@"icon_image"];
    
    CGFloat imageW = 18;
    CGFloat imaegX = (qrImage.size.width - imageW) * 0.5;
    CGFloat imageY = (qrImage.size.height - imageW) * 0.5;
    
    [image drawInRect:CGRectMake(imaegX, imageY, imageW, imageW)];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

+ (UIImage *)getCodeMaWithContent:(NSString *)content{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    //存放的信息
    NSString *info = content;
    //把信息转化为NSData
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    //滤镜对象kvc存值
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    //我们可以打印,看过滤器的 输入属性.这样我们才知道给谁赋值
     NSLog(@"%@",filter.inputKeys);
     /*
        inputMessage,        //二维码输入信息
        inputCorrectionLevel //二维码错误的等级,就是容错率
      */
    CIImage *outImage = [filter outputImage];
    
    return [self createNonInterpolatedUIImageFormCIImage:outImage withSize:300];;
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度以及高度
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
  CGRect extent = CGRectIntegral(image.extent);
  CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
  //1.创建bitmap;
  size_t width = CGRectGetWidth(extent) * scale;
  size_t height = CGRectGetHeight(extent) * scale;
  CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
  CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
  CIContext *context = [CIContext contextWithOptions:nil];
  CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
  CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
  CGContextScaleCTM(bitmapRef, scale, scale);
  CGContextDrawImage(bitmapRef, extent, bitmapImage);
  //2.保存bitmap到图片
  CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
  CGContextRelease(bitmapRef);
  CGImageRelease(bitmapImage);
  return [UIImage imageWithCGImage:scaledImage];
}

+ (NSString *)dealURLWithBase:(NSString *)baseUrl withUrlPath:(NSString *)urlPath{
    if ([baseUrl containsString:@"http"]) {
        return baseUrl;
    }else{
        NSString *urlPathS = K_NotNullHolder(urlPath, @"");
        if (urlPathS.length) {
            return [NSString stringWithFormat:@"%@%@",urlPathS,baseUrl];
        }
    }
    return baseUrl;
}

+ (NSString *)dealChineseUrl:(NSString *)baseUrl{
    //return [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [baseUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

+ (void)dealCollectionDataAry:(NSMutableArray *)listAry{
    if (listAry.count) {
        GoodsListVosModel *model = [listAry firstObject];
        model.isFirst = YES;
    }
}

+ (NSMutableArray *)dealCollectionResultAry:(NSMutableArray *)listAry{
    if (listAry.count) {
        GoodsListVosModel *model = [listAry firstObject];
        model.isFirst = YES;
    }
    return listAry;
}

+ (void)openOthersAppUrl:(NSString *)url{
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else{
        [AppTool openAppStore];
    }
}

+ (void)openAppStore{
    //跳转appstore下载
    //https://apps.apple.com/us/app/小莲云仓/id1632169993
    NSString *url = @"https://apps.apple.com/cn/app/id1632169993";
    [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]];
}

+ (NSString *)getProductShareUrl:(NSString *)productID shopID:(NSString *)shopId{
    
    THBaseViewController *vc = (THBaseViewController *)[AppTool currentVC];
    [vc startLoadingHUD];
    __block NSString  *resultUrl = @"";
    NSMutableDictionary *signDic = [AppTool getRequestSign];
    [signDic setObject:productID forKey:@"goodsID"];
    [signDic setObject:@"-1" forKey:@"otherID"];
    [signDic setObject:@"g" forKey:@"shareGroup"];
    [signDic setObject:[AppTool getLocalDataWithKey:@"shopID"] forKey:@"shopID"];
    [signDic setObject:[AppTool getLocalDataWithKey:@"userID"] forKey:@"userID"];
    [THHttpManager FormatPOST:@"https://tpi.tuanhuoit.com/user/share/cpi/shortUrl" parameters:signDic dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [vc stopLoadingHUD];
        if (returnCode == 200 && [data isKindOfClass:[NSString class]]) {
            resultUrl = (NSString *)data;
        }
    }];
    return resultUrl;
}

+(NSMutableDictionary *)getRequestSign{
    
    NSMutableString *sign = [[NSMutableString alloc] initWithString:NSStringFormat(@"ThTec_%@",[NSString new].currentTimeStr)];
    return [@{@"platCode":@"yb_iOS",
             @"sign":sign.md5Str,
             @"timeStamp":[NSString new].currentTimeStr,
             } mutableCopy];
}

@end

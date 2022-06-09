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
        return @"转发赚钱";
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
    //productID = @"1519281847211655170";//SKU
    //productID = @"1519277462561751040";//评价

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
    [localAry insertObject:searchStr atIndex:0];
    
    NSSet *set = [NSSet setWithArray:localAry];
    NSLog(@"新增后本地存储%@",[set allObjects]);
    [[NSUserDefaults standardUserDefaults]  setValue:[set allObjects] forKey:@"searchList"];
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
    [dateFormatter setDateFormat:@"yyyy-MM-dd "];
    NSString *destDateString = [dateFormatter stringFromDate:creatDate];
    return destDateString;
}

+(void)shareWebPageToPlatformTypeWithData:(UIImage *)image WXScene:(NSInteger)WXScene{
  
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = UIImageJPEGRepresentation(image, 0.7);
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.mediaObject = imageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXScene;
    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
}

@end

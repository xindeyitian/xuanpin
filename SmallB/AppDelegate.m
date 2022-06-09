//
//  AppDelegate.m
//  SmallB
//
//  Created by 张昊男 on 2022/3/22.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MainTabarViewController.h"
#import "THHttpManager.h"
#import <MJExtension.h>
#import "AESCipher.h"
#import "THUserManager.h"
#import "XHLaunchAd.h"
#import "WXApi.h"
#import <AFServiceSDK/AFServiceSDK.h>
#import <IQKeyboardManager.h>

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //开启网络监测
    [self isNetWorking];
    //初始化window
    [self initWindow];
//
//    [self initLaunch];
//
//    [self inituserManger];
    
    [self WorkUI];
                               
//    [THUserManager clearUserModel];
//    [AMapServices sharedServices].apiKey = @"c63b1057148412dfaec447a4f7ccefdb";

    [self confitUShareSettings];
    [self configUSharePlatforms];

    [self keyBoard];
//    [self firstDownload];
    
//    [self getCurrentLocation];

//    [self initQYKF];
    application.statusBarStyle = UIStatusBarStyleDefault;
    application.statusBarHidden = NO;
    
    return YES;
}

-(void)keyBoard{
    // 键盘处理
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    keyboardManager.shouldShowToolbarPlaceholder = NO; // 是否显示占位文字
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 32.0f; // 输入框距离键盘的距离
}


- (void)confitUShareSettings{
   
}

- (void)configUSharePlatforms{

      [WXApi registerApp:weChatAppID universalLink:@"https://xlxp/app/"];
//    [UMSocialGlobal shareInstance].universalLinkDic = @{
//        @(UMSocialPlatformType_WechatSession):@"https://xlxp/app/",
//        @(UMSocialPlatformType_WechatTimeLine):@"https://xlxp/app/",
//        @(UMSocialPlatformType_APSession):@"https://xlxp/app/"
//    };
//
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx2a13459e7ffbd403" appSecret:@"27a6a314dd551a71930c0833b384586f" redirectURL:@"https://xlxp/app/"];
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_APSession appKey:@"2021003130655095" appSecret:nil redirectURL:@"https://xlxp/app/"];
}

-(void)firstDownload{
    
    //第一次安装时会有引导页展示  非第一次直接进入应用页

    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isOne"] isEqual:@"isOne"]) {

        //正常工作的UI
        [self WorkUI];
    }else{

        ViewController *vc = [[ViewController alloc] init];

        self.window.rootViewController = vc;
    }
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    if  ([url.host isEqualToString: @"apmqpdispatch" ]) {
        [AFServiceCenter handleResponseURL:url withCompletion:^(AFAuthServiceResponse *response) {
              NSLog ( @"%@" , response.result);
        }];
   }
   return  [WXApi handleOpenURL:url delegate:self];
   return YES;
}

-(BOOL)application:(UIApplication*)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication*)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id>*)options
{
    if ([url.host isEqualToString: @"apmqpdispatch" ]) {
        [AFServiceCenter handleResponseURL:url withCompletion:^(AFAuthServiceResponse *response) {
              NSLog ( @"%@" , response.result);
        }];
   }
   return  [WXApi handleOpenURL:url delegate:self];
   return YES;
}

-(void) onResp:(BaseResp*)resp{
    NSLog(@"resp %d",resp.errCode);
      
    /*
    enum  WXErrCode {
        WXSuccess           = 0,    成功
        WXErrCodeCommon     = -1,  普通错误类型
        WXErrCodeUserCancel = -2,    用户点击取消并返回
        WXErrCodeSentFail   = -3,   发送失败
        WXErrCodeAuthDeny   = -4,    授权失败
        WXErrCodeUnsupport  = -5,   微信不支持
    };
    */
    if ([resp isKindOfClass:[SendAuthResp class]]) {   //授权登录的类。
        if (resp.errCode == 0) {  //成功。
            //这里处理回调的方法 。 通过代理吧对应的登录消息传送过去。
            SendAuthResp *resp2 = (SendAuthResp *)resp;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wxLoginSuccess" object:@{@"code": resp2.code}];
        }else{ //失败
            [[AllNoticePopUtility shareInstance] popViewWithTitle:@"获取微信失败" AndType:hint AnddataBlock:^{

            }];
            NSLog(@"error %@",resp.errStr);
        }
    }
}
  
-(void)initLaunch{
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将不显示
    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器x
    
    [XHLaunchAd setWaitDataDuration:4];
    
//    [THHttpManager getLogPictureBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
//
//        if (returnCode == 0) {
//            NSString *logStr = [data objectForKey:@"url"];
//            XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
//            //广告停留时间
//            imageAdconfiguration.duration = 5;
//            //广告frame
//            imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//            //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
//            imageAdconfiguration.imageNameOrURLString = logStr;
//
//            //        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536402839147&di=e945205663f557965b1bddfc0abcbe3f&imgtype=0&src=http%3A%2F%2Fg.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F574e9258d109b3de1a60c400c7bf6c81810a4cfe.jpg";
//            //设置GIF动图是否只循环播放一次(仅对动图设置有效)
//            imageAdconfiguration.GIFImageCycleOnce = NO;
//            //缓存机制(仅对网络图片有效)
//            //为告展示效果更好,可设置为XHLaunchAdImageCacheInBackground,先缓存,下次显示
//            imageAdconfiguration.imageOption = XHLaunchAdImageRefreshCached;
//            //图片填充模式
//
//            imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFill;
//            //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
////            imageAdconfiguration.openModel = singleModel.click_link_address;
//            //广告显示完成动画
//            imageAdconfiguration.showFinishAnimate =ShowFinishAnimateNone;
//            //广告显示完成动画时间
//            imageAdconfiguration.showFinishAnimateTime = 0.8;
//            //跳过按钮类型
//            imageAdconfiguration.skipButtonType = SkipTypeTimeText;
//            //后台返回时,是否显示广告
//            imageAdconfiguration.showEnterForeground = NO;
//            //显示开屏广告
//            [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
//        }
//    } Progrss:^(NSProgress *pro) {
//
//    }];
}
//初始化Window
- (void)initWindow{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    #if defined(__IPHONE_13_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0
    if(@available(iOS 13.0,*)){
        self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
    #endif
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxec3bc97a206b8a4f" appSecret:@"b2f4620ed95bcc431127b70cf4e2e68e" redirectURL:@"http://www.kaopudian.cn/"];
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:@"wxec3bc97a206b8a4f" appSecret:@"b2f4620ed95bcc431127b70cf4e2e68e" redirectURL:@"http://www.kaopudian.cn/"];
}
-(void)inituserManger{
    
    NSDictionary *localDic = [[NSBundle mainBundle] infoDictionary];
    NSString *localVersion = [localDic objectForKey:@"CFBundleShortVersionString"];
    [SSProgressHUD showLoadingText:@"获取版本信息中" maskType:SSProgressHUDMaskTypeBlack];
//    [THHttpManager updataAppVersionWithVersionNum:localVersion AndTerminalType:@"1" block:^(NSInteger returnCode, THRequestStatus status, id data) {
//        [SSProgressHUD hideHUD];
//        if (returnCode == 200) {
//            THHttpManager *manager = [THHttpManager mj_objectWithKeyValues:data];
//            if (![localVersion isEqualToString:manager.versionCode]) {
//                UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"检测到版本更新" message:@"您确定要跳转浏览器下载新版本吗?" preferredStyle:(UIAlertControllerStyleAlert)];
//                [alerVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:manager.downloadUrl] options:@{} completionHandler:nil];
//
//                    [kRootViewController presentViewController:alerVC animated:YES completion:^{
//
//                    }];
//                }]];
//                if ([manager.versionType isEqualToString:@"1"]) {
//                    [alerVC addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
//
//                    }]];
//                }
//
//                [kRootViewController presentViewController:alerVC animated:YES completion:^{
//
//                }];
//            }
//        }
//    } Progrss:^(NSProgress *pro) {
//
//    }];
}
//正常工作的跟控制器
- (void)WorkUI{
    
    //去掉UINavigationBar黑线
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
//    self.window.rootViewController = [[LoginViewController alloc]init];
//    return;
    
    NSString *token = [AppTool getLocalToken];
    NSString *login = [[NSUserDefaults standardUserDefaults] objectForKey:@"login"];

    if(token.length && ![login isEqualToString:@"1"]){
        MainTabarViewController * tab = [[MainTabarViewController alloc]init];
        self.window.rootViewController = tab;
    }else{
        //跳转到登录界面
        self.window.rootViewController = [[LoginViewController alloc]init];
    }
}
-(void)isNetWorking{
    
    //开启网络指示器，开始监听
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        
    }];
}
//- (void)getCurrentLocation{
//
//    //
//    self.locationManager = [[AMapLocationManager alloc]init];
//
//    [self.locationManager allowsBackgroundLocationUpdates];
//
//    // 带逆地理信息的一次定位（返回坐标和地址信息）
//    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
//    //   定位超时时间，最低2s，此处设置为2s
//    self.locationManager.locationTimeout =2;
//    //   逆地理请求超时时间，最低2s，此处设置为2s
//    self.locationManager.reGeocodeTimeout = 2;
//
//    self.locationManager.delegate = self;
//
//    self.province = [NSString new];
//    self.city = [[NSString alloc]init];
//    self.region = [NSString new];
//
//    [self.locationManager
//     requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
//
//         if (error)
//         {
//             if (error.code == AMapLocationErrorLocateFailed)
//             {
//                 return;
//             }
//         }
//         if (regeocode)
//         {
//             if (regeocode.city != nil) {
//
//                 [[NSUserDefaults standardUserDefaults] setObject:regeocode.city forKey:@"city"];
//                 [[NSUserDefaults standardUserDefaults] setObject:regeocode.province forKey:@"province"];
//                 [[NSUserDefaults standardUserDefaults] setObject:regeocode.district forKey:@"region"];
//                 [[NSUserDefaults standardUserDefaults] setObject:regeocode.POIName forKey:@"POI"];
//                 [[NSUserDefaults standardUserDefaults] synchronize];
//
//             }
//         }
//     }];
//}
- (NSString *)deviceWANIPAddress
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

//- (void)amapLocationManager:(AMapLocationManager *)manager doRequireLocationAuth:(CLLocationManager *)locationManager{
//
//    [locationManager requestAlwaysAuthorization];
//}
//如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
//- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
//
//    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
//}

//-(void) onResp:(BaseResp*)resp{
//    if ([resp isKindOfClass: [SendAuthResp class]]) {
//        SendAuthResp* authResp = (SendAuthResp*)resp;
//
//        if (authResp.errCode == 0) {
//            // 用户确认授权，发送全局通知，处理逻辑
//            [[NSNotificationCenter defaultCenter] postNotificationName: KNotificationWXLOGIN_AUTHORIZED
//                                                                object: authResp];
//        } else {
//            // 用户取消授权，发送全局通知，处理逻辑
//            [[NSNotificationCenter defaultCenter] postNotificationName: KNotificationWXLOGIN_USERCANCELLED
//                                                                object: nil];
//        }
//    }
//    if ([resp isKindOfClass:[WXLaunchMiniProgramResp class]]) {
//        WXLaunchMiniProgramResp *miniResp = (WXLaunchMiniProgramResp *)resp;
//
//        [[NSNotificationCenter defaultCenter] postNotificationName: KNotificationWXMIN_WXLaunchMiniProgramResp
//                                                            object: miniResp.extMsg];
//    }
//    if([resp isKindOfClass:[PayResp class]]){
//        //支付返回结果，实际支付结果需要去微信服务器端查询
//        NSString *strMsg= [NSString stringWithFormat:@"支付结果"];
//
//        switch (resp.errCode) {
//            case WXSuccess:
//                strMsg = @"支付结果：成功！";
//                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
//                [[NSNotificationCenter defaultCenter] postNotificationName:LNotification_WXChatPaySuccess object:nil];
//                break;
//
//            default:
//                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
//                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
//                [[NSNotificationCenter defaultCenter] postNotificationName:LNotification_WXChatPayFailed object:nil];
//                break;
//        }
//    }
//}

// NOTE: 9.0以后使用新API接口
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
//{
//    if ([url.host isEqualToString:@"safepay"]) {
//        // 支付跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//            if ([resultDic[@"resultStatus"] intValue] == 9000) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:LNotification_AliPaySuccess object:nil];
//            } else{
//                [[NSNotificationCenter defaultCenter] postNotificationName:LNotification_AliPayFailed object:nil];
//            }
//        }];
//    }else{
//        return [WXApi handleOpenURL:url delegate:self];
//    }
//    return YES;
//}
@end

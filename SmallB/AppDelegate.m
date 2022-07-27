//
//  AppDelegate.m
//  SmallB
//
//  Created by 张昊男 on 2022/3/22.
//

#import "AppDelegate.h"
#import "GuideViewController.h"
#import "MainTabarViewController.h"
#import "THHttpManager.h"
#import <MJExtension.h>
#import "AESCipher.h"
#import "THUserManager.h"
#import "XHLaunchAd.h"
#import "WXApi.h"
#import <AFServiceSDK/AFServiceSDK.h>
#import <IQKeyboardManager.h>
#import "VideoViewController.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //开启网络监测
    [self isNetWorking];
    //初始化window
    [self initWindow];
//
    [self initLaunch];
    [WXApi registerApp:weChatAppID universalLink:@"https://xlxp/app/"];
    
    [self keyBoard];
    [self firstDownload];
    
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

-(void)firstDownload{
    //第一次安装时会有引导页展示  非第一次直接进入应用页
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isOne"] isEqualToString:@"isOne"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"isVedio"] isEqualToString:@"isVedio"]) {
        //正常工作的UI
        [self WorkUI];
    }else{
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"isOne"] isEqualToString:@"isOne"]) {
            GuideViewController *vc = [[GuideViewController alloc] init];
            self.window.rootViewController = vc;
        }else{
            if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"isVedio"] isEqualToString:@"isVedio"]) {
                NSString *thePath = @"";
                if (IS_IPHONEX_SERIE) {
                    thePath = [[NSBundle mainBundle] pathForResource:@"小莲云仓" ofType:@"mp4"];
                }else{
                    thePath = [[NSBundle mainBundle] pathForResource:@"app_open_normal" ofType:@"mp4"];
                }
                VideoViewController *vc = [[VideoViewController alloc] init];
                vc.theurl = [NSURL fileURLWithPath:thePath];
                self.window.rootViewController = vc;
            }
        }
    }
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
   return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{

    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}

-(BOOL)application:(UIApplication*)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication*)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id>*)options
{
   return  [WXApi handleOpenURL:url delegate:self];
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
}
-(void)inituserManger{
    
    NSDictionary *localDic = [[NSBundle mainBundle] infoDictionary];
    NSString *localVersion = [localDic objectForKey:@"CFBundleShortVersionString"];
    [SSProgressHUD showLoadingText:@"获取版本信息中" maskType:SSProgressHUDMaskTypeBlack];
}
//正常工作的跟控制器
- (void)WorkUI{
    
    //去掉UINavigationBar黑线
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];

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

@end

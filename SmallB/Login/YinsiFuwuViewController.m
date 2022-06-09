//
//  YinsiFuwuViewController.m
//  SeaEgret
//
//  Created by MAC on 2021/7/16.
//

#import "YinsiFuwuViewController.h"
#import "BaseOwnerNavView.h"

@interface YinsiFuwuViewController ()<UINavigationControllerDelegate>

@property (strong, nonatomic) MyLinearLayout *backLy;
@property (strong, nonatomic) UIScrollView *backScroll;
@property (strong, nonatomic) WKWebView    *webView;

@end

@implementation YinsiFuwuViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    BaseOwnerNavView *nav= [[BaseOwnerNavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight)];
    nav.titleL.text = @"标题";
    [nav.backBtn setImage:IMAGE_NAMED(@"back") forState:UIControlStateNormal];
    [self.view addSubview:nav];
    nav.backOperation = ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    };
    
//    self.backLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
//    self.backLy.myHorzMargin = 0;
//    self.backLy.myHeight = MyLayoutSize.wrap;
//
//    self.backScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - KNavBarHeight)];
//    self.backScroll.contentSize = CGSizeMake(0, [self.backLy sizeThatFits:CGSizeMake(ScreenWidth, MAXFLOAT)].height);
//    self.backLy.backgroundColor = UIColor.groupTableViewBackgroundColor;
//    [self.view addSubview:self.backScroll];
//    [self.backScroll addSubview:self.backLy];
//
//    UILabel *txt = [[UILabel alloc] initWithFrame:CGRectZero];
//    txt.myHorzMargin = 10;
//    txt.myHeight = MyLayoutSize.wrap;
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"海鹭隐私政策8.24" ofType:@"docx"];
//
//    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//    [wkUController addUserScript:wkUScript];
        
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
//    wkWebConfig.userContentController = wkUController;
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, KNavBarHeight, ScreenWidth, ScreenHeight - KNavBarHeight) configuration:wkWebConfig];
    [self.view addSubview:self.webView];
    if (_type == 1) {
        //服务
        self.title = @"服务条款";
//        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.hailukuajing.cn/agreement/serviceAgreement.html"]]];
    }else if(_type == 2){
        self.title = @"隐私条款";
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.hailukuajing.cn/agreement/privacyPolicy.html"]]];
    }else if (_type == 3){
        self.title = @"海鹭跨境用户行为公约";
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.hailukuajing.cn/agreement/conventionConduct.html"]]];
    }else{
        self.title = @"用户使用许可协议";
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.hailukuajing.cn/agreement/behaviorProtocol.html"]]];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

    [navigationController setNavigationBarHidden:NO animated:YES];
}
@end

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
@property (strong, nonatomic) BaseOwnerNavView *navBar;

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
    nav.titleL.text = @"";
    [nav.backBtn setImage:IMAGE_NAMED(@"back") forState:UIControlStateNormal];
    [self.view addSubview:nav];
    nav.backOperation = ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    };
    self.navBar = nav;
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, KNavBarHeight, ScreenWidth, ScreenHeight - KNavBarHeight) configuration:wkWebConfig];
    [self.view addSubview:self.webView];
    [self getContent];
}

- (void)getContent{
    NSString *articleCode = @"";
    switch (self.agreeType) {
        case PrivacyAgreementTypeLogin:
            articleCode = @"";
            break;
        case PrivacyAgreementTypeRegist:
            articleCode = @"";
            break;
        case PrivacyAgreementTypeUser:
            articleCode = @"ShopUserAgree";
            break;
        case PrivacyAgreementTypePrivacyAgreement:
            articleCode = @"ShopPrivacy";
            break;
        case PrivacyAgreementTypeShiMing:
            articleCode = @"AuthIdCardDeal";
            break;
        case PrivacyAgreementTypeSupplier:
            articleCode = @"ShopSupply";
            break;
            
        default:
            break;
    }
    
    [THHttpManager GET:@"commons/articleInfo/getArticleInfo" parameters:@{@"articleCode":articleCode} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            NSString *content = @"";
            if ([data objectForKey:@"content"]) {
                id contentS = [data objectForKey:@"content"];
                if (![contentS isEqual:[NSNull null]]) {
                    content = [data objectForKey:@"content"];
                    [self.webView loadHTMLString:content baseURL:nil];
                }
            }
            if ([data objectForKey:@"title"]) {
                id titleS = [data objectForKey:@"title"];
                if (![titleS isEqual:[NSNull null]]) {
                    self.navBar.titleL.text = titleS;
                }
            }
        }
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

    [navigationController setNavigationBarHidden:NO animated:YES];
}
@end

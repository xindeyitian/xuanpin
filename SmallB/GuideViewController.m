//
//  GuideViewController.m
//  SmallB
//
//  Created by 张昊男 on 2022/3/22.
//

#import "GuideViewController.h"
#import "MainTabarViewController.h"
#import "ShopWindowDeleteAlertVC.h"

@interface GuideViewController ()<UIScrollViewDelegate>

@property (nonatomic , strong)XHPageControl *pageControl;
@property (nonatomic , strong)UIScrollView *scrolView;
@property (nonatomic , strong)BaseButton *useBtn;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KWhiteBGColor;

    UIScrollView *scrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    scrol.contentSize = CGSizeMake(ScreenWidth*3, 0);
    scrol.delegate = self;
    scrol.showsHorizontalScrollIndicator = NO;
    scrol.pagingEnabled = YES;
    scrol.bounces = NO;
    scrol.userInteractionEnabled = YES;
    [self.view addSubview:scrol];
    for (int i =0; i < 3; i ++) {
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth *i, 0, 375*KScreenW_Ratio, 437*KScreenW_Ratio)];
        imgV.userInteractionEnabled = YES;
        imgV.centerY = scrol.centerY;
        NSString *url = [NSString stringWithFormat:@"guide_%d",i+1];
        imgV.image = IMAGE_NAMED(url);
        [scrol addSubview:imgV];
        
        BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"立即体验" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_R(14) BackgroundColor:KWhiteBGColor Color:KMaintextColor Frame:CGRectMake(ScreenWidth/2.0 - 69 + ScreenWidth *i, ScreenHeight - TabbarSafeBottomMargin - 107*KScreenW_Ratio, 138, 43) Alignment:NSTextAlignmentCenter Tag:3];
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = 12;
        btn.layer.borderColor = KMainBGColor.CGColor;
        btn.layer.borderWidth = 1;
        [scrol addSubview:btn];
        self.useBtn = btn;
        btn.hidden = !(i == 2);
    }
    self.scrolView = scrol;
    
    XHPageControl *pageC = [[XHPageControl alloc] initWithFrame:CGRectMake(0, ScreenHeight - TabbarSafeBottomMargin - 52 , ScreenWidth ,15)];
    pageC.numberOfPages = 3;
    pageC.otherMultiple = 1;
    pageC.currentMultiple = 2;
    pageC.type = PageControlMiddle;
    pageC.otherColor = [UIColor colorWithHexString:@"#ECECEC"];
    pageC.currentColor= [UIColor colorWithHexString:@"#FFBBBB"];
    pageC.delegate = self;
    [self.view addSubview:pageC];
    self.pageControl = pageC;
}

- (void)btnClick{
    [self tapClick];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/(ScreenWidth - 24);
    self.pageControl.currentPage = index;
}

-(void)xh_PageControlClick:(XHPageControl*)pageControl index:(NSInteger)clickIndex{
   
}

- (void)tapClick{
    [AppTool saveToLocalDataWithValue:@"isOne" key:@"isOne"];
    
    NSString *token = [AppTool getLocalToken];
    NSString *login = [[NSUserDefaults standardUserDefaults] objectForKey:@"login"];
    if(token.length && ![login isEqualToString:@"1"]){
        MainTabarViewController * tab = [[MainTabarViewController alloc]init];
        [UIApplication sharedApplication].delegate.window.rootViewController = tab;
    }else{
        //跳转到登录界面
        [UIApplication sharedApplication].delegate.window.rootViewController  = [[LoginViewController alloc]init];
    }
}

@end

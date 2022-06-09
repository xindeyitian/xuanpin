//
//  ThirdBingDingViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/25.
//

#import "ThirdBingDingViewController.h"
#import "BingdingTableViewController.h"
#import "BingdingAlertViewController.h"
#import "myShimingViewController.h"
#import "SafeKeyboard.h"
#import "BingDingYanZhengViewController.h"

@interface ThirdBingDingViewController ()

@end

@implementation ThirdBingDingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"第三方账户提现绑定";
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(12);
        } else {
            make.top.equalTo(self.view).offset(KNavBarHeight).offset(12);
        }
    }];
    [self headerview];
    [self footView];
    [self getBindingState];
}

- (void)getBindingState{
    [self startLoadingHUD];
    [THHttpManager GET:@"shop/shopUser/bindingState" parameters:@{} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            [self stopLoadingHUD];
            if ([data isKindOfClass:[NSDictionary class]] && returnCode == 200) {
                NSString *bindAli = [NSString stringWithFormat:@"%@",K_NotNullHolder([data objectForKey:@"bindAli"], @"")];
                NSString *bindWechat = [NSString stringWithFormat:@"%@",K_NotNullHolder([data objectForKey:@"bindWechat"], @"")];
                self.bingdAli = bindAli.integerValue;
                self.bingWeichat = bindWechat.integerValue;
                
                BaseButton *aliBtn = [self.view viewWithTag:3];
                [aliBtn setTitle:self.bingdAli == 1 ? @"已绑定":@"去绑定" forState:UIControlStateNormal];
                
                BaseButton *weChatBtn = [self.view viewWithTag:4];;
                [weChatBtn setTitle:self.bingWeichat == 1 ? @"已绑定":@"去绑定" forState:UIControlStateNormal];
            }
        }
    }];
}

- (void)headerview{

    UIView *contentV = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , ScreenWidth, 160+12)];
    contentV.backgroundColor = KBGColor;
    [self.view addSubview:contentV];
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, ScreenWidth - 24, 160)];
    whiteView.backgroundColor = KWhiteBGColor;
    whiteView.clipsToBounds = YES;
    whiteView.layer.cornerRadius = 8;
    [contentV addSubview:whiteView];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"请选择绑定的第三方" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(15)];
    title.frame = CGRectMake(12, 20, ScreenWidth - 48, 23);
    [whiteView addSubview:title];
    
    for (int i =0; i < 2; i ++) {
        UIImageView *image = [[UIImageView alloc]initWithImage:IMAGE_NAMED(i == 0 ? @"withdraw_record_zhifubao":@"withdraw_record_weixin")];
        image.frame = CGRectMake(12, 68+49*i, 18, 18);
        [whiteView addSubview:image];
        
        UILabel *title = [UILabel creatLabelWithTitle:i == 0 ? @"支付宝":@"微信" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
        title.frame = CGRectMake(40, 68+49*i, 100, 23);
        [whiteView addSubview:title];
        
        BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(btnClick:) Font:DEFAULT_FONT_R(13) BackgroundColor:UIColor.clearColor Color:KMaintextColor Frame:CGRectMake(ScreenWidth - 50*KScreenW_Ratio - 34, 68+49*i, 50*KScreenW_Ratio, 23) Alignment:NSTextAlignmentCenter Tag:3+i];
        [whiteView addSubview:btn];
        if (i == 0) {
            UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(12, 101, ScreenWidth - 48, 1)];
            lineV.backgroundColor = KBGColor;
            [whiteView addSubview:lineV];
        }
    }
    self.tableView.tableHeaderView = contentV;
}

- (void)btnClick:(BaseButton *)btn{
    if (btn.tag == 3) {
        if (self.bingdAli == 1) {
            return;
        }
    }
    if (btn.tag == 4) {
        if (self.bingWeichat == 1) {
            return;
        }
    }
   
    __block BOOL isSiming = NO;
    [THHttpManager POST:@"shop/shopIdcardAuth/queryIdCard" parameters:@{} dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        [self.tableView.mj_header endRefreshing];
        if ([data isKindOfClass:[NSDictionary class]] && returnCode == 200) {
            isSiming = YES;
        }
        if (isSiming) {
            
            BingDingYanZhengViewController *vc = [[BingDingYanZhengViewController alloc]init];
            vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
            CJWeakSelf()
            vc.viewBlock = ^{
                CJStrongSelf()
                BingdingTableViewController *vc = [[BingdingTableViewController alloc]init];
                vc.index = btn.tag - 3;
                vc.viewBlock = ^{
                    [self getBindingState];
                };
                [self.navigationController pushViewController:vc animated:YES];
            };
            [self  presentViewController:vc animated:NO completion:nil];
        }else{
            BingdingAlertViewController *vc = [[BingdingAlertViewController alloc]init];
            vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
            CJWeakSelf()
            vc.btnClickBlock = ^(NSInteger index) {
                CJStrongSelf()
                myShimingViewController *vc = [[myShimingViewController alloc]init];
                vc.shimingSuccessBlock = ^{
                    
                };
                [self.navigationController pushViewController:vc animated:YES];
            };
            [self  presentViewController:vc animated:NO completion:nil];
        }
    }];
}


- (void)footView{
    [THHttpManager GET:@"commons/articleInfo/getArticleInfo" parameters:@{@"articleCode":@"ShopWithdrawBinDing"} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            NSString *content = @"";
            if ([data objectForKey:@"content"]) {
                id contentS = [data objectForKey:@"content"];
                if (![contentS isEqual:[NSNull null]]) {
                    content = [data objectForKey:@"content"];
                }
                
                id titleS = [data objectForKey:@"title"];
                if (![titleS isEqual:[NSNull null]]) {
                    titleS = [data objectForKey:@"title"];
                }
                CGFloat lableHeight = [content sizeWithLabelWidth:(ScreenWidth - 48) font:DEFAULT_FONT_R(13)].height+1;
                UIView *contentV = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , ScreenWidth, lableHeight + 51+12)];
                contentV.backgroundColor = KBGColor;
                [self.view addSubview:contentV];
                
                UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, ScreenWidth - 24, lableHeight + 51+12)];
                whiteView.backgroundColor = KWhiteBGColor;
                whiteView.clipsToBounds = YES;
                whiteView.layer.cornerRadius = 8;
                [contentV addSubview:whiteView];
                
                UILabel *title = [UILabel creatLabelWithTitle:titleS textColor:KBlack666TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(15)];
                title.frame = CGRectMake(12, 20, ScreenWidth - 48, 23);
                [whiteView addSubview:title];
                
                UILabel *contentL = [UILabel creatLabelWithTitle:content textColor:KBlack999TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
                contentL.numberOfLines = 0;
                contentL.frame = CGRectMake(12, 51, ScreenWidth - 48, lableHeight);
                [whiteView addSubview:contentL];
                
                self.tableView.tableFooterView = contentV;
            }
        }
    }];
}

@end

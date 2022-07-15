//
//  CouponChooseViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/21.
//

#import "CouponChooseViewController.h"
#import "CouponChooseCell.h"
#import "applyStoreViewController.h"
#import "ReceiveCouponViewController.h"
#import "ReceiveCouponModel.h"

@interface CouponChooseViewController ()<UINavigationControllerDelegate>
{
    NSArray *imgAry;
    NSArray *titleAry;
    NSArray *subTitleAry;
    NSArray *contentTitleAry;
    NSInteger selectIndex;
}
@property (nonatomic , strong)ReceiveCouponModel *couponModel;
@property (nonatomic , strong)NSMutableArray *couponAry;
@property (nonatomic , strong)UIImageView *couponView;
@property (nonatomic , copy)NSString *contentStr;
@property (nonatomic , copy)NSString *titleStr;
@property (nonatomic , assign)NSInteger ifShow;
@end

@implementation CouponChooseViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backBtn.hidden = NO;
    selectIndex = 0;
    self.contentStr = @"";
    self.titleStr = @"";
    
    self.ifShow = NO;
    
    self.couponAry = [NSMutableArray array];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(self.view.mas_bottom);
        }
        make.left.right.top.equalTo(self.view);
    }];
    self.view.backgroundColor = KWhiteBGColor;
    self.tableView.backgroundColor = KWhiteBGColor;
    [self.tableView registerClass:[CouponChooseCell class] forCellReuseIdentifier:[CouponChooseCell description]];
    
    if (@available(iOS 10.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }
    imgAry = @[@"open_store_chuangye",@"open_store_gongxiang",@"open_store_pinpai"];
    titleAry = @[@"0门槛创业开店者",@"品牌自营开店",@"自营+共享云仓好货"];
    subTitleAry = @[@"0门槛、无货源、助您开店",@"开店推广您的品牌产品",@"云仓与自由品牌互补"];
    contentTitleAry = @[@"共享云仓千万好货省心无后顾之优",@"共享平台流量、提供私域电商解决方案",@"流量价值最大化，变现能力倍数涨"];
    
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 340*KScreenW_Ratio)];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"open_store_head")];
    image.frame = headerV.frame;
    [headerV addSubview:image];
    
    UIImageView *btnImage = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"open_store_btn_bgimage")];
    btnImage.frame = CGRectMake(0, 340*KScreenW_Ratio - 100, 268, 62);
    btnImage.centerX = headerV.centerX;
    [headerV addSubview:btnImage];
    btnImage.hidden = YES;
    self.couponView = btnImage;
    
    btnImage.userInteractionEnabled = YES;
    [btnImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)]];
    
    UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(0, 340*KScreenW_Ratio - 20, ScreenWidth, 20)];
    whiteV.backgroundColor = KWhiteBGColor;
    [headerV addSubview:whiteV];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:whiteV.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = whiteV.bounds;
    maskLayer.path = maskPath.CGPath;
    whiteV.layer.mask = maskLayer;
    self.tableView.tableHeaderView = headerV;
    
    UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 86)];
    footerV.backgroundColor = KWhiteBGColor;
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"下一步" Target:self Action:@selector(nextClick) Font:DEFAULT_FONT_M(17) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
    btn.frame = CGRectMake(12, 30, ScreenWidth - 24, 44);
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 22;
    [footerV addSubview:btn];
    self.tableView.tableFooterView = footerV;

    [self judgeShow];
}

- (void)judgeShow{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSMutableDictionary *signDic = [AppTool getRequestSign];
    [signDic setObject:[NSString stringWithFormat:@"supply_ios_%@",app_Version] forKey:@"versionCode"];
    [THHttpManager GET:[NSString stringWithFormat:@"%@version/getVersion",XTAppBaseUseURL] parameters:signDic block:^(NSInteger returnCode, THRequestStatus status, id data) {
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            if ([data objectForKey:@"ifShow"]) {
                NSString *result = [NSString stringWithFormat:@"%@",[data objectForKey:@"ifShow"]];
                self.ifShow = result.integerValue;
                self.couponView.hidden = (self.ifShow == 0);
                if (result.integerValue == 1) {
                    [self getCouponList];
                    [self getCouponMessage];
                }
            }
        }
    }];
}

- (void)tapClick{
    ReceiveCouponViewController *vc = [[ReceiveCouponViewController alloc]init];
    vc.couponAry = self.couponAry;
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    vc.token = self.token;
    vc.contentString = self.contentStr;
    vc.titleString = self.titleStr;
    CJWeakSelf()
    vc.viewBlock = ^{
        CJStrongSelf()
        self.couponAry = [NSMutableArray array];
        [self getCouponList];
    };
    [self  presentViewController:vc animated:NO completion:nil];
}

- (void)nextClick{
    
    if (self.ifShow) {
        if (self.couponAry.count > 0) {
            [self showMessageWithString:@"请先领取优惠券"];
            return;
        }
    }
    applyStoreViewController *vc = [[applyStoreViewController alloc]init];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    vc.token = self.token;
    vc.typeIndex = selectIndex + 1;
    vc.ifShow = self.ifShow;
    [self  presentViewController:vc animated:NO completion:nil];
}

- (void)backClcik{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  indexPath.section == 0 ? 95 : 107;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CouponChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:[CouponChooseCell description]];
    cell.bgViewContentInset = UIEdgeInsetsMake(indexPath.section == 0 ? 0 : 12, 12, 0, 12);
    cell.titleL.text = titleAry[indexPath.section];
    cell.subTitleL.text = subTitleAry[indexPath.section];
    cell.contentTitleL.text = contentTitleAry[indexPath.section];
    cell.isSelect = indexPath.section == selectIndex;
    cell.iconImgV.image = IMAGE_NAMED(imgAry[indexPath.section]);
    return cell;
}

- (void)getCouponList{
    [self startLoadingHUD];
    [THHttpManager GET:@"goods/couponInfo/couponTypeList" parameters:@{@"typeCode":@"shopCode"} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        [self.couponAry removeAllObjects];
        if ([data isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dica in data) {
                ReceiveCouponDataModel *model = [ReceiveCouponDataModel mj_objectWithKeyValues:dica];
                [self.couponAry addObject:model];
            }
            if (self.couponAry.count == 0) {
                self.couponView.image = IMAGE_NAMED(@"open_coupn_no_select");
                self.couponView.userInteractionEnabled = NO;
            }else{
                self.couponView.image = IMAGE_NAMED(@"open_coupn_can_select");
                self.couponView.userInteractionEnabled = YES;
            }
        }
    }];
}

- (void)getCouponMessage{

    [THHttpManager GET:@"commons/articleInfo/getArticleInfo" parameters:@{@"articleCode":@"HelpPlan"} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            self.contentStr = [data objectForKey:@"content"];
            
            NSString *content = @"";
            NSString *title = @"";
            if ([data objectForKey:@"content"]) {
                id contentS = [data objectForKey:@"content"];
                if (![contentS isEqual:[NSNull null]]) {
                    content = [data objectForKey:@"content"];
                }
                
                id titleS = [data objectForKey:@"title"];
                if (![titleS isEqual:[NSNull null]]) {
                    title = [data objectForKey:@"title"];
                }
                self.contentStr = content;
                self.titleStr = title;
            }
        }
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (selectIndex != indexPath.section) {
        selectIndex = indexPath.section;
        [self.tableView reloadData];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SetIOS13;
    [navigationController setNavigationBarHidden:YES animated:YES];
}

@end

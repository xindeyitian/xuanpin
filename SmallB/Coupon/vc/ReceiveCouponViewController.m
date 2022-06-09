//
//  ReceiveCouponViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/21.
//

#import "ReceiveCouponViewController.h"
#import "ReceiveSuccessViewController.h"

@interface ReceiveCouponViewController ()<UINavigationControllerDelegate>

@property(nonatomic,strong)XHPageControl *pageCon;

@end

@implementation ReceiveCouponViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.title = @"领取优惠券";
    
    self.backBtn.hidden = NO;
    [self.backBtn setImage:[UIImage imageNamed:@"back"]forState:UIControlStateNormal];
    [self.backBtn setImage:[UIImage imageNamed:@"back"]forState:UIControlStateHighlighted];
    
    UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight)];
    whiteV.backgroundColor = KWhiteBGColor;
    [self.view addSubview:whiteV];
    [self.view sendSubviewToBack:whiteV];
    
    UILabel *titleL = [UILabel creatLabelWithTitle:@"领取优惠券" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(18)];
    titleL.frame = CGRectMake(60, KStatusBarHeight, ScreenWidth - 120, 44);
    [whiteV addSubview:titleL];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(whiteV.mas_bottom);
    }];
    self.view.backgroundColor = KMainBGColor;
    self.tableView.backgroundColor = KMainBGColor;
    //self.tableView.bounces = NO;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 715*KScreenW_Ratio)];
    headerView.userInteractionEnabled = YES;
    headerView.backgroundColor = KMainBGColor;
    
    UIImageView *image = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"receive_coupon_bg")];
    image.frame = CGRectMake(0, 0, ScreenWidth, 515*KScreenW_Ratio);
    image.userInteractionEnabled = YES;
    [headerView addSubview:image];
    
    NSMutableArray *array = self.couponAry;
    
    UIScrollView *scrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 163*KScreenW_Ratio, ScreenWidth, 288*KScreenW_Ratio)];
    scrol.contentSize = CGSizeMake(324 * KScreenW_Ratio * array.count, 0);
    scrol.showsHorizontalScrollIndicator = NO;
    scrol.pagingEnabled = YES;
    scrol.delegate = self;
    scrol.userInteractionEnabled = YES;
    [headerView addSubview:scrol];
    
    XHPageControl  *pageControl = [[XHPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(scrol.frame),[UIScreen mainScreen].bounds.size.width, 12)];
    pageControl.numberOfPages = array.count;
    pageControl.otherMultiple = 1;
    pageControl.currentMultiple = 2;
    pageControl.type = PageControlMiddle;
    pageControl.otherColor = KViewBGColor;
    pageControl.currentColor= KWhiteBGColor;
    pageControl.userInteractionEnabled = YES;
    [headerView addSubview:pageControl];
    self.pageCon = pageControl;

    for (int i = 0; i < array.count; i ++) {
        CouponImageView *couponImage = [[CouponImageView alloc]initWithFrame:CGRectMake( i == 0? 51*KScreenW_Ratio : ScreenWidth - 51*KScreenW_Ratio, 0, 273*KScreenW_Ratio, 288*KScreenW_Ratio)];
        ReceiveCouponDataModel *dataModel = array[i];
        couponImage.image = IMAGE_NAMED(@"coupon_bg_image");
        couponImage.titleL.text = dataModel.typeName;
        couponImage.priceStr = dataModel.moneyCouponSub;
        [scrol addSubview:couponImage];
    };
    
    NSString *contentStr = @"";
    if (self.contentString) {
        contentStr = self.contentString;
    }
    if ([self.contentString isEqual:[NSNull null]]) {
        contentStr = @"";
    }
    float height = [contentStr sizeWithLabelWidth:ScreenWidth - 48 font:DEFAULT_FONT_R(13)].height+1;
    
    UIView *contentV = [[UIView alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(scrol.frame) + 20  , ScreenWidth - 24, height +24)];
    contentV.backgroundColor = KWhiteBGColor;
    contentV.clipsToBounds = YES;
    contentV.layer.cornerRadius = 8;
    [headerView addSubview:contentV];
    
    UILabel *contentL = [UILabel creatLabelWithTitle:contentStr textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(13)];
    contentL.frame = CGRectMake(12, 12, ScreenWidth - 48, height);
    contentL.numberOfLines = 0;
    [contentV addSubview:contentL];
    
    UIImageView *btnImage = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"receive_store_btn_bgimage")];
    btnImage.frame = CGRectMake(30*KScreenW_Ratio, CGRectGetMaxY(contentV.frame)+12, 315*KScreenW_Ratio, 62);
    [headerView addSubview:btnImage];
    btnImage.userInteractionEnabled = YES;
    
    UILabel *type = [UILabel creatLabelWithTitle:@"一键领取" textColor:KMaintextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(18)];
    type.frame = CGRectMake(0, 0, 315, 62);
    [btnImage addSubview:type];
    
    type.userInteractionEnabled = YES;
    headerView.userInteractionEnabled = YES;
    self.view.userInteractionEnabled = YES;
    self.tableView.userInteractionEnabled = YES;
    
    headerView.frame = CGRectMake(0, 0, ScreenWidth, CGRectGetMaxY(contentV.frame)+86);

    [type addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)]];

    self.tableView.tableHeaderView = headerView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x == 0 ? 0: 1;
    self.pageCon.currentPage = index;
}

- (void)saveCoupon{
    [self startLoadingHUD];
    NSMutableArray *array = [NSMutableArray array];
    for (ReceiveCouponDataModel *model in self.couponAry) {
        [array addObject:model.typeId];
    }
    [THHttpManager POST:@"goods/couponInfo/saveCouple" parameters:@{@"typeId":array} dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200) {
            [self successView];
        }
    }];
}

-(void)tapClick{
    [self saveCoupon];
    return;
    ReceiveSuccessViewController *vc = [[ReceiveSuccessViewController alloc]init];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    vc.currentVCBlock = ^(NSString *string) {
        [self dismissViewControllerAnimated:NO completion:nil];
    };
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)successView{
    
    UIView *successView = [[UIView alloc]initWithFrame:self.view.frame];
    successView.backgroundColor = kRGBA(0,0,0,0.45);
    [self.view addSubview:successView];
    
    UIView *allView = [[UIView alloc]initWithFrame:CGRectMake(24*KScreenW_Ratio, 0, ScreenWidth - 48*KScreenW_Ratio, 320*KScreenW_Ratio)];
    allView.center = successView.center;
    allView.backgroundColor = UIColor.clearColor;
    [successView addSubview:allView];
    
    UIImageView *headerV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 48*KScreenW_Ratio, 132*KScreenW_Ratio)];
    headerV.image = IMAGE_NAMED(@"coupon_head_bgimage");
    [allView addSubview:headerV];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"恭喜您领取成功" textColor:KMainBGColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(20)];
    title.frame = CGRectMake(0, 77*KScreenW_Ratio, ScreenWidth - 48*KScreenW_Ratio, 25*KScreenW_Ratio);
    [headerV addSubview:title];
    
    UILabel *subTitle = [UILabel creatLabelWithTitle:@"优惠券用于开店时抵扣使用" textColor:KMainBGColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(13)];
    subTitle.frame = CGRectMake(0, 104*KScreenW_Ratio, ScreenWidth - 48*KScreenW_Ratio, 25*KScreenW_Ratio);
    [headerV addSubview:subTitle];
    
    NSInteger num = 0;
    if (self.couponAry.count) {
        num = self.couponAry.count - 1;
    }
    UIView *otherView = [[UIView alloc]initWithFrame:CGRectMake(0, 131*KScreenW_Ratio, ScreenWidth - 48*KScreenW_Ratio, num*90*KScreenW_Ratio)];
    otherView.backgroundColor = kRGB(255, 237, 221);
    [allView addSubview:otherView];
    
    for (int i =0; i < num; i ++) {
        couponInfoImgV *couponV = [[couponInfoImgV alloc]initWithFrame:CGRectMake(12*KScreenW_Ratio, 20*KScreenW_Ratio + 90*KScreenW_Ratio *i, 303*KScreenW_Ratio, 70*KScreenW_Ratio)];
        couponV.image = IMAGE_NAMED(@"coupon_bgimage");
        [otherView addSubview:couponV];
        if (self.couponAry.count) {
            ReceiveCouponDataModel *model = self.couponAry[i];
            couponV.dataModel = model;
        }
    }

    UIImageView *footV = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(otherView.frame), ScreenWidth - 48*KScreenW_Ratio, 189*KScreenW_Ratio)];
    footV.image = IMAGE_NAMED(@"coupon_foot_bgimage");
    [allView addSubview:footV];
    
    couponInfoImgV *couponV = [[couponInfoImgV alloc]initWithFrame:CGRectMake(12*KScreenW_Ratio, 20*KScreenW_Ratio, 303*KScreenW_Ratio, 70*KScreenW_Ratio)];
    couponV.image = IMAGE_NAMED(@"coupon_bgimage");
    if (self.couponAry.count) {
        ReceiveCouponDataModel *model = [self.couponAry lastObject];
        couponV.dataModel = model;
    }
    [footV addSubview:couponV];
    
    footV.userInteractionEnabled = YES;
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"去开店" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
    btn.frame = CGRectMake(47*KScreenW_Ratio, 110*KScreenW_Ratio, 233*KScreenW_Ratio, 50*KScreenW_Ratio);
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 25;
    [footV addSubview:btn];
    
    allView.frame = CGRectMake(24*KScreenW_Ratio, 0, ScreenWidth - 48*KScreenW_Ratio, CGRectGetMaxY(footV.frame));
    allView.center = successView.center;
}

- (void)btnClick{
    if (_viewBlock) {
        _viewBlock();
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)backClcik{
    if (_viewBlock) {
        _viewBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SetIOS13;
    [navigationController setNavigationBarHidden:NO animated:YES];
}

@end

@implementation CouponImageView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    
        self.userInteractionEnabled = YES;
        [self creatSubviews];
    }
    return self;
}

- (void)creatSubviews{
    UILabel *couponTitle = [UILabel creatLabelWithTitle:@"一年店铺经营优惠券" textColor:KMaintextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(17)];
    [self addSubview:couponTitle];
    [couponTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(38);
        make.right.mas_equalTo(self).offset(-12);
        make.left.mas_equalTo(self).offset(12);
        make.height.mas_equalTo(24);
    }];
    UILabel *couponPrice = [UILabel creatLabelWithTitle:@"¥199" textColor:KMaintextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(45)];
    [self addSubview:couponPrice];
    [couponPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(couponTitle.mas_bottom).offset(10);
        make.right.mas_equalTo(self).offset(-12);
        make.left.mas_equalTo(self).offset(12);
        make.height.mas_equalTo(60);
    }];
    self.titleL = couponTitle;
    self.priceL = couponPrice;
}

- (void)setPriceStr:(NSString *)priceStr{
    _priceStr = priceStr;
    
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",_priceStr]];
    NSRange range = NSMakeRange(0,1);
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_M(20) range:range];
    self.priceL.attributedText = attributeMarket;
}

@end

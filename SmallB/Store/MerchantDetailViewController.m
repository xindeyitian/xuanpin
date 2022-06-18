//
//  MerchantDetailViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/12.
//

#import "MerchantDetailViewController.h"
#import "MerchantDetailView.h"

@interface MerchantDetailViewController ()<UINavigationControllerDelegate>

@property (strong, nonatomic) MyLinearLayout      *topLy;
@property (strong, nonatomic) UITextField         *searchTF;
@property (strong, nonatomic) UIImageView         *merchantImg;
@property (strong, nonatomic) UILabel             *merchantName;
@property (strong, nonatomic) UIButton            *attentionBtn;
@property (strong, nonatomic) UILabel             *pingjia, *wuliu, *shouhou;
@property (strong, nonatomic) UILabel             *pingjiaLevel, *wuliuLevel, *shouhouLevel;
@property (strong, nonatomic) UILabel             *area, *time;

@end

@implementation MerchantDetailViewController
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    [self initTopView];
}

- (void)getStoreDetail{
    [THHttpManager GET:@"supply/supplyInfo/getSupplierDetail" parameters:@{@"supplyId":self.storeModel.supplyId} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            self.storeModel = [StoreModel mj_objectWithKeyValues:data];
        }
    }];
}

- (void)initTopView{
   
    MyLinearLayout *rootly = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    rootly.myWidth = ScreenWidth;
    rootly.myHeight = MyLayoutSize.wrap;
    [self.view addSubview:rootly];
    
    MerchantDetailView *view = [[MerchantDetailView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 142+KStatusBarHeight)];
    view.havSearchNav = NO;
    view.storeModel = self.storeModel;
    [rootly addSubview:view];
    
    MyLinearLayout *numLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    numLy.myHorzMargin = 12;
    numLy.myHeight = 60;
    numLy.layer.cornerRadius = 8;
    numLy.myTop = -15;
    numLy.gravity = MyGravity_Fill;
    numLy.backgroundColor = UIColor.whiteColor;
    numLy.padding = UIEdgeInsetsMake(0, 12, 0, 12);
    [rootly addSubview:numLy];
    
    MyLinearLayout *pingjiaLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    pingjiaLy.myWidth = (ScreenWidth - 48) / 3;
    pingjiaLy.myHeight = MyLayoutSize.wrap;
    pingjiaLy.gravity = MyGravity_Vert_Center;
    pingjiaLy.subviewHSpace = 5;
    [numLy addSubview:pingjiaLy];
    
    UILabel *pjTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    pjTitle.text = @"评价";
    pjTitle.font = DEFAULT_FONT_R(12);
    pjTitle.textColor = [UIColor colorWithHexString:@"#666666"];
    pjTitle.myWidth = pjTitle.myHeight = MyLayoutSize.wrap;
    [pingjiaLy addSubview:pjTitle];
    
    self.pingjia = [[UILabel alloc] initWithFrame:CGRectZero];
    self.pingjia.font = DIN_Medium_FONT_R(18);
    self.pingjia.textColor = UIColor.blackColor;
    NSString *pingjiaS = K_NotNullHolder(self.storeModel.appraisalValue, @"0");
    self.pingjia.text = [NSString stringWithFormat:@"%.2f",pingjiaS.doubleValue];
    self.pingjia.myWidth = self.pingjia.myHeight = MyLayoutSize.wrap;
    [pingjiaLy addSubview:self.pingjia];
    
    self.pingjiaLevel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.pingjiaLevel.myWidth = self.pingjiaLevel.myHeight = 17;
    self.pingjiaLevel.layer.cornerRadius = 8.5;
    self.pingjiaLevel.layer.masksToBounds = YES;
    self.pingjiaLevel.textAlignment = NSTextAlignmentCenter;
    [self setScoreDataWithLable:self.pingjiaLevel score:self.pingjia.text];
    self.pingjiaLevel.font = DEFAULT_FONT_R(10);
    [pingjiaLy addSubview:self.pingjiaLevel];
    
    MyLinearLayout *wuliuLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    wuliuLy.myWidth = (ScreenWidth - 24) / 3;
    wuliuLy.myHeight = MyLayoutSize.wrap;
    wuliuLy.gravity = MyGravity_Center;
    wuliuLy.subviewHSpace = 5;
    [numLy addSubview:wuliuLy];
    
    UILabel *wlTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    wlTitle.text = @"物流";
    wlTitle.font = DEFAULT_FONT_R(12);
    wlTitle.textColor = [UIColor colorWithHexString:@"#666666"];
    wlTitle.myWidth = wlTitle.myHeight = MyLayoutSize.wrap;
    [wuliuLy addSubview:wlTitle];
    
    self.wuliu = [[UILabel alloc] initWithFrame:CGRectZero];
    self.wuliu.font = DIN_Medium_FONT_R(18);
    self.wuliu.textColor = UIColor.blackColor;
    NSString *wuliuS = K_NotNullHolder(self.storeModel.logisticsValue, @"0");
    self.wuliu.text = [NSString stringWithFormat:@"%.2f",wuliuS.doubleValue];
    self.wuliu.myWidth = self.wuliu.myHeight = MyLayoutSize.wrap;
    [wuliuLy addSubview:self.wuliu];
    
    self.wuliuLevel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.wuliuLevel.myWidth = self.wuliuLevel.myHeight = 17;
    self.wuliuLevel.layer.cornerRadius = 8.5;
    self.wuliuLevel.layer.masksToBounds = YES;
    self.wuliuLevel.textAlignment = NSTextAlignmentCenter;
    [self setScoreDataWithLable:self.wuliuLevel score:self.wuliu.text];

    self.wuliuLevel.font = DEFAULT_FONT_R(10);
    [wuliuLy addSubview:self.wuliuLevel];
    
    MyLinearLayout *shouhouLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    shouhouLy.myWidth = (ScreenWidth - 24) / 3;
    shouhouLy.myHeight = MyLayoutSize.wrap;
    shouhouLy.gravity = MyGravity_Vert_Center;
    shouhouLy.subviewHSpace = 5;
    [numLy addSubview:shouhouLy];
    
    UIView *nilV = [[UIView alloc] init];
    nilV.weight = 1;
    nilV.myHeight = MyLayoutSize.wrap;
    [shouhouLy addSubview:nilV];
    
    UILabel *shTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    shTitle.text = @"售后";
    shTitle.font = DEFAULT_FONT_R(12);
    shTitle.textColor = [UIColor colorWithHexString:@"#666666"];
    shTitle.myWidth = shTitle.myHeight = MyLayoutSize.wrap;
    [shouhouLy addSubview:shTitle];
    
    self.shouhou = [[UILabel alloc] initWithFrame:CGRectZero];
    self.shouhou.font = DIN_Medium_FONT_R(18);
    self.shouhou.textColor = UIColor.blackColor;
    NSString *shouhouS = K_NotNullHolder(self.storeModel.afterSaleValue, @"0");
    self.shouhou.text = [NSString stringWithFormat:@"%.2f",shouhouS.doubleValue];
    self.shouhou.myWidth = self.shouhou.myHeight = MyLayoutSize.wrap;
    [shouhouLy addSubview:self.shouhou];
    
    self.shouhouLevel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.shouhouLevel.myWidth = self.shouhouLevel.myHeight = 17;
    self.shouhouLevel.layer.cornerRadius = 8.5;
    self.shouhouLevel.layer.masksToBounds = YES;
    self.shouhouLevel.textAlignment = NSTextAlignmentCenter;
    [self setScoreDataWithLable:self.shouhouLevel score:self.shouhou.text];
    self.shouhouLevel.font = DEFAULT_FONT_R(10);
    [shouhouLy addSubview:self.shouhouLevel];
    
    MyLinearLayout *detailInfoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    detailInfoLy.myHorzMargin = 12;
    detailInfoLy.myHeight = 104;
    detailInfoLy.padding = UIEdgeInsetsMake(0, 12, 0, 12);
    detailInfoLy.layer.cornerRadius = 8;
    detailInfoLy.layer.masksToBounds = YES;
    detailInfoLy.backgroundColor = UIColor.whiteColor;
    detailInfoLy.myTop = 12;
    [rootly addSubview:detailInfoLy];
    
    MyLinearLayout *areaLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    areaLy.myHorzMargin = 0;
    areaLy.myHeight = 52;
    areaLy.gravity = MyGravity_Vert_Center;
    [detailInfoLy addSubview:areaLy];
    
    UILabel *areaTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    areaTitle.text = @"店铺所在地";
    areaTitle.font = DEFAULT_FONT_R(15);
    areaTitle.textColor = [UIColor colorWithHexString:@"#999999"];
    areaTitle.myWidth = areaTitle.myHeight = MyLayoutSize.wrap;
    [areaLy addSubview:areaTitle];
    
    UIView *nil1 = [[UIView alloc] initWithFrame:CGRectZero];
    nil1.weight = 1;
    nil1.myHeight = 52;
    [areaLy addSubview:nil1];
    
    self.area = [[UILabel alloc] initWithFrame:CGRectZero];
    self.area.font = DEFAULT_FONT_R(15);
    self.area.textColor = UIColor.blackColor;
    self.area.text = @"";
    if (self.storeModel) {
        self.area.text = [NSString stringWithFormat:@"%@-%@-%@",self.storeModel.provinceName,self.storeModel.cityName,self.storeModel.areaName];
    }
    self.area.myWidth = self.area.myHeight = MyLayoutSize.wrap;
    [areaLy addSubview:self.area];
    
    MyBorderline *line = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#F5F5F5"] thick:1 headIndent:12 tailIndent:12];
    areaLy.bottomBorderline = line;
    
    MyLinearLayout *timeLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    timeLy.myHorzMargin = 0;
    timeLy.myHeight = 52;
    timeLy.gravity = MyGravity_Vert_Center;
    [detailInfoLy addSubview:timeLy];
    
    UILabel *timeTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    timeTitle.text = @"开店时间";
    timeTitle.font = DEFAULT_FONT_R(15);
    timeTitle.textColor = [UIColor colorWithHexString:@"#999999"];
    timeTitle.myWidth = timeTitle.myHeight = MyLayoutSize.wrap;
    [timeLy addSubview:timeTitle];
    
    UIView *nil2 = [[UIView alloc] initWithFrame:CGRectZero];
    nil2.weight = 1;
    nil2.myHeight = 52;
    [timeLy addSubview:nil2];
    
    self.time = [[UILabel alloc] initWithFrame:CGRectZero];
    self.time.font = DEFAULT_FONT_R(15);
    self.time.textColor = UIColor.blackColor;
    self.time.text = K_NotNullHolder(self.storeModel.createTime, @"");
    self.time.myWidth = self.time.myHeight = MyLayoutSize.wrap;
    [timeLy addSubview:self.time];
}

- (void)setScoreDataWithLable:(UILabel *)lable score:(NSString *)score{
    
    NSInteger scoreInteger = [score integerValue];
    if (scoreInteger < 3) {
        lable.text = @"低";
        lable.backgroundColor = [UIColor colorWithHexString:@"#333333" alpha:0.1];
        lable.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    }else if((scoreInteger > 3 || scoreInteger == 3) && scoreInteger < 6){
        lable.text = @"中";
        lable.backgroundColor = [UIColor colorWithHexString:@"#FF7332" alpha:0.1];
        lable.textColor = [UIColor colorWithHexString:@"#FF7332" alpha:1];
    }else{
        lable.text = @"高";
        lable.backgroundColor = [UIColor colorWithHexString:@"#FA172D" alpha:0.1];
        lable.textColor = [UIColor colorWithHexString:@"#FA172D" alpha:1];
    }
}

- (void)attentionBtnClicked:(BaseButton *)btn{
    
}

-(void)backClcik{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end

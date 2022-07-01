//
//  MerchantDetailView.m
//  SmallB
//
//  Created by zhang on 2022/4/28.
//

#import "MerchantDetailView.h"
#import "MerchantDetailViewController.h"

@interface MerchantDetailView ()<UINavigationControllerDelegate,UITextFieldDelegate>

@property (strong, nonatomic) MyLinearLayout      *topLy;
@property (strong, nonatomic) UITextField         *searchTF;
@property (strong, nonatomic) UIImageView         *merchantImg;
@property (strong, nonatomic) UILabel             *merchantName;
@property (strong, nonatomic) UIButton            *attentionBtn;
@property (strong, nonatomic) UILabel             *pingjia, *wuliu, *shouhou;
@property (strong, nonatomic) UILabel             *pingjiaLevel, *wuliuLevel, *shouhouLevel , *numL;
@property (strong, nonatomic) UILabel             *area, *time;
@property (strong, nonatomic) UIButton            *pushBtn;
@property (strong, nonatomic)UIView *searchView;
@property (strong, nonatomic)UILabel *titleL;
@property (strong, nonatomic)UIImageView *bgImageV;
@property (strong, nonatomic)UIImageView *bgBlackV;

@end

@implementation MerchantDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)setStoreModel:(StoreModel *)storeModel{
    _storeModel = storeModel;
    self.titleL.text = storeModel.supplyName;
    self.merchantName.text = storeModel.supplyName;
    self.numL.text = [NSString stringWithFormat:@"共%@件产品",storeModel.goodsCount];
    NSString *logoUrl = [AppTool dealURLWithBase:storeModel.logImgUrl withUrlPath:storeModel.urlPath];
    [self.merchantImg sd_setImageWithURL:[NSURL URLWithString:logoUrl] placeholderImage:KPlaceholder_DefaultImage];
    
    NSString *bgUrl = [AppTool dealURLWithBase:storeModel.bgImgUrl withUrlPath:storeModel.urlPath];
    [self.bgImageV sd_setImageWithURL:[NSURL URLWithString:bgUrl]];
    self.bgBlackV.backgroundColor = UIColor.blackColor;
    self.bgBlackV.alpha = 0.3;
    
    JZLStarView *starView = [self viewWithTag:11];
    starView.currentScore = [storeModel.stars integerValue];
    
    self.attentionBtn.selected = (_storeModel.isCollect.integerValue == 1);
    if (self.attentionBtn.selected) {
        self.attentionBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.attentionBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.attentionBtn.backgroundColor = UIColor.clearColor;
        self.attentionBtn.layer.borderColor = KWhiteTextColor.CGColor;
        self.attentionBtn.layer.borderWidth = 1;
        [self.attentionBtn setImage:nil forState:UIControlStateNormal];
        
    }else{
        self.attentionBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        self.attentionBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        self.attentionBtn.backgroundColor = KMainBGColor;
        self.attentionBtn.layer.borderWidth = 0;
        [self.attentionBtn setImage:IMAGE_NAMED(@"store_attention") forState:UIControlStateNormal];
    }
}

- (void)creatSubViews{
   
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.frame.size.height)];
    [self addSubview:imageV];
    imageV.userInteractionEnabled = YES;
    self.bgImageV = imageV;
    
    self.bgBlackV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.frame.size.height)];
    [self.bgImageV addSubview:self.bgBlackV];
    self.bgBlackV.userInteractionEnabled = YES;
    
    UIButton *backBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(backClcik) Font:DEFAULT_FONT_R(10) Frame:CGRectMake(12, KStatusBarHeight + 10, 24, 24) Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"bar_back" HeightLightBackgroundImage:@"bar_back"];
    backBtn.backgroundColor = UIColor.clearColor;
    [imageV addSubview:backBtn];
    
    UIView *searvchV = [[UIView alloc]initWithFrame:CGRectMake(38, KStatusBarHeight + 7, ScreenWidth - 50, 30)];
    searvchV.userInteractionEnabled = YES;
    searvchV.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5" alpha:0.45];
    searvchV.clipsToBounds = YES;
    searvchV.layer.cornerRadius = 6;
    [imageV addSubview:searvchV];
    self.searchView = searvchV;
    
    UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"放大镜")];
    img.frame = CGRectMake(12, 6, 18, 18);
    [searvchV addSubview:img];
    
    self.searchTF = [[UITextField alloc] initWithFrame:CGRectMake(35, 0, ScreenWidth - 50 - 47, 30)];
    self.searchTF.placeholder = @"可搜索本店商品";
    self.searchTF.font = DEFAULT_FONT_R(13);
    self.searchTF.textColor = KWhiteTextColor;
    self.searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchTF.delegate = self;
    [searvchV addSubview:self.searchTF];
    NSAttributedString *attrString = [[NSAttributedString alloc]initWithString:@"可搜索本店商品" attributes:@{NSForegroundColorAttributeName:KWhiteTextColor,NSFontAttributeName:self.searchTF.font}];
    self.searchTF.attributedPlaceholder = attrString;
    
    UILabel *title = [UILabel creatLabelWithTitle:@"" textColor:KWhiteTextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(17)];
    title.frame = CGRectMake(60, KStatusBarHeight + 7, ScreenWidth - 120, 30);
    [imageV addSubview:title];
    self.titleL = title;
    
    self.merchantImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, KStatusBarHeight + 53, 44, 44)];
    self.merchantImg.layer.cornerRadius = 6;
    self.merchantImg.layer.masksToBounds = YES;
    [imageV addSubview:self.merchantImg];
    
    self.merchantName = [[UILabel alloc] initWithFrame:CGRectMake(66, KStatusBarHeight + 53, ScreenWidth - 66 -  107, 23)];
    self.merchantName.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    self.merchantName.textColor = KWhiteTextColor;
    self.merchantName.text = @"";
    self.merchantName.numberOfLines = 2;
    [imageV addSubview:self.merchantName];

    UILabel *starLable = [[UILabel alloc] initWithFrame:CGRectMake(66, KStatusBarHeight + 77, 50*KScreenW_Ratio, 20)];
    starLable.text = @"店铺星级";
    starLable.font = DEFAULT_FONT_R(12);
    starLable.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.8];
    [imageV addSubview:starLable];
    
    JZLStarView *starView = [[JZLStarView alloc] initWithFrame:CGRectMake(71+50*KScreenW_Ratio, KStatusBarHeight + 81, 67, 11) starCount:5 starStyle:WholeStar isAllowScroe:YES];
    starView.tag = 11;
    starView.userInteractionEnabled = NO;
    [imageV addSubview:starView];
    
    UILabel *numLable = [[UILabel alloc] initWithFrame:CGRectMake(66, KStatusBarHeight + 97, ScreenWidth - 66 -  107, 20)];
    numLable.text = @"";
    numLable.font = [UIFont systemFontOfSize:12];
    numLable.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.8];
    [imageV addSubview:numLable];
    self.numL = numLable;
    
    self.attentionBtn = [BaseButton CreateBaseButtonTitle:@"关注" Target:self Action:@selector(attentionBtnClicked:) Font:[UIFont systemFontOfSize:12] BackgroundColor:KMainBGColor Color:UIColor.whiteColor Frame:CGRectMake(ScreenWidth - 108, KStatusBarHeight + 61, 70, 28) Alignment:NSTextAlignmentCenter Tag:0];
    self.attentionBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    self.attentionBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.attentionBtn.layer.cornerRadius = 14;
    self.attentionBtn.layer.masksToBounds = YES;
    [self.attentionBtn setImage:IMAGE_NAMED(@"store_attention") forState:UIControlStateNormal];
    [self.attentionBtn setImage:nil forState:UIControlStateSelected];
    [self.attentionBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [imageV addSubview:self.attentionBtn];
    
    UIButton *rightBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(tapClick) Font:[UIFont systemFontOfSize:12] BackgroundColor:UIColor.clearColor Color:UIColor.whiteColor Frame:CGRectMake(ScreenWidth - 32, 0, 20, 28) Alignment:NSTextAlignmentCenter Tag:0];
    rightBtn.centerY = self.attentionBtn.centerY;
    [rightBtn setImage:IMAGE_NAMED(@"my_right_white") forState:UIControlStateNormal];
    [rightBtn setImage:IMAGE_NAMED(@"my_right_white") forState:UIControlStateHighlighted];
    [imageV addSubview:rightBtn ];
    self.pushBtn = rightBtn;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (_searchBlock) {
        _searchBlock(textField.text);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (_searchBlock) {
        _searchBlock(textField.text);
    }
    return YES;
}

- (void)setHavSearchNav:(BOOL)havSearchNav{
    _havSearchNav = havSearchNav;
    self.pushBtn.hidden = !havSearchNav;
    self.searchView.hidden = !havSearchNav;
    self.titleL.hidden = havSearchNav;
    
    self.attentionBtn.frame = CGRectMake(havSearchNav ? ScreenWidth - 108 : ScreenWidth - 82, KStatusBarHeight + 61, 70, 28);
    self.merchantName.frame = CGRectMake(66, KStatusBarHeight + 53, havSearchNav ? ScreenWidth - 66 -  113 : ScreenWidth - 66 -  87, 23);
}

- (void)tapClick{
    if (self.havSearchNav) {
        MerchantDetailViewController *vc = [[MerchantDetailViewController alloc] init];
        vc.storeModel = self.storeModel;
        [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
    }
}

- (void)backClcik{
    [[AppTool currentVC].navigationController popViewControllerAnimated:YES];
}

- (void)attentionBtnClicked:(BaseButton *)btn{
    THBaseViewController *vc = (THBaseViewController *)AppTool.currentVC;
    [vc startLoadingHUD];
    [THHttpManager FormatPOST:@"shop/shopInfo/saveSupplyCollect" parameters:@{@"supplyId":self.storeModel.supplyId} dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [vc stopLoadingHUD];
        if (returnCode == 200) {
            if ([data isKindOfClass:[NSNumber class]]) {
                NSInteger code = [data integerValue];
                if (code == 10021) {
                    //取消收藏
                    [XHToast dismiss];
                    [XHToast showCenterWithText:@"关注成功" withName:@""];
                }else{
                    [XHToast dismiss];
                    [XHToast showCenterWithText:@"取消关注成功"];
                }
            }
            btn.selected = !btn.selected;
            [NSNotificationCenter.defaultCenter postNotificationName:@"collectionChange" object:nil];
            if (btn.selected) {
                self.attentionBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                self.attentionBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                btn.backgroundColor = UIColor.clearColor;
                btn.layer.borderColor = KWhiteTextColor.CGColor;
                btn.layer.borderWidth = 1;
                [btn setImage:nil forState:UIControlStateNormal];
            }else{
                self.attentionBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
                self.attentionBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
                btn.backgroundColor = KMainBGColor;
                btn.layer.borderWidth = 0;
                [btn setImage:IMAGE_NAMED(@"store_attention") forState:UIControlStateNormal];
            }
        }
    }];
}

@end

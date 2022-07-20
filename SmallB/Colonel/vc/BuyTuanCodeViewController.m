//
//  BuyTuanCodeViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/19.
//

#import "BuyTuanCodeViewController.h"
#import "BasePhotoTableViewCell.h"
#import "BuyTuanModel.h"

@interface BuyTuanCodeViewController ()<UINavigationBarDelegate>

@property(nonatomic , strong)UIImage *zhifuImage;
@property(nonatomic , strong)numAddReduceView *numView;
@property(nonatomic , assign)float payRate;
@property(nonatomic , assign)NSInteger buyNum;

@property(nonatomic , copy)NSString *zhifuImageUrl;
@property(nonatomic , strong)priceInfoBtn *selectPriceBtn;

@end

@implementation BuyTuanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    self.navigationItem.title = @"购买团长码";
    self.view.backgroundColor = KWhiteBGColor;
    self.tableView.backgroundColor = KWhiteBGColor;
    
    self.payRate = 0;
    self.buyNum = 1;
    self.zhifuImage = nil;
    
    [self.tableView registerClass:[BaseOnePhotoTableViewCell class] forCellReuseIdentifier:[BaseOnePhotoTableViewCell description]];
    
    [self creatHeaderView];
    [self creatFooterView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseOnePhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseOnePhotoTableViewCell description]];
    cell.backgroundColor = KWhiteBGColor;
    cell.titleL.text = @"上传支付凭证";
    cell.subTitleL.text = @"";
    if (self.zhifuImage) {
        cell.yingyeImage = self.zhifuImage;
    }
    CJWeakSelf()
    cell.viewClickBlock = ^(BOOL isAdd, NSInteger index) {
        CJStrongSelf()
        if (isAdd) {
            [self addPhotoWithSection:indexPath.section];
        }else{
            self.zhifuImage = nil;
            [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        }
    };
    return cell;
}

- (void)addPhotoWithSection:(NSInteger)section{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.naviTitleColor = [UIColor whiteColor];
    imagePickerVc.barItemTextColor = [UIColor whiteColor];
 
    CJWeakSelf()
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        CJStrongSelf()
        if (photos.count) {
            self.zhifuImage = photos[0];
        }
        [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    }];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    float oneWidth = (ScreenWidth - 48)/3.0;
    return oneWidth + 67;
}

- (void)creatHeaderView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 180*KScreenW_Ratio + 260)];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 180*KScreenW_Ratio)];
    image.image = IMAGE_NAMED(@"buy_tuan_code_head");
    [view addSubview:image];
    
    UIImageView *userImage = [[UIImageView alloc]initWithFrame:CGRectMake(34, 180*KScreenW_Ratio - 64, 34, 34)];
    userImage.layer.cornerRadius = 17;
    userImage.clipsToBounds = YES;
    userImage.layer.borderColor = KWhiteBGColor.CGColor;
    userImage.layer.borderWidth = 2;
    [view addSubview:userImage];
    
    UILabel *phone = [UILabel creatLabelWithTitle:@"" textColor:KWhiteTextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    phone.frame = CGRectMake(78, 180*KScreenW_Ratio - 64, ScreenWidth - 98 , 34);
    [view addSubview:phone];
    
    NSString *userPhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"];
    NSString *userLogo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userLogo"];
    if (userPhone.length) {
        NSString *name = [userPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        phone.text = name;
    }
    if (userLogo.length) {
        [userImage sd_setImageWithURL:[NSURL URLWithString:userLogo] placeholderImage:KPlaceholder_DefaultImage];
    }
    
    UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(0, 180*KScreenW_Ratio - 20, ScreenWidth, 310-25)];
    whiteV.backgroundColor = KWhiteBGColor;
    [view addSubview:whiteV];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:whiteV.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = whiteV.bounds;
    maskLayer.path = maskPath.CGPath;
    whiteV.layer.mask = maskLayer;
    
    float width = (ScreenWidth - 34)/2.0;
    for (int i = 0; i < 2; i ++) {
        priceInfoBtn *btn = [[priceInfoBtn alloc]initWithFrame:CGRectMake(13+(width+8)*i, 20, width, 123-25)];
        btn.isSelected = 1-i;
        if ( i == 0) {
            self.selectPriceBtn = btn;
        }
        btn.tag = 111+i;
        [whiteV addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    NSArray *titleAry = @[@"购买数量",@"优惠金额",@"合计"];
    float maxY = 123 + 20 - 25;
    for (int i =0; i < 3; i ++) {
        UILabel *titleL = [UILabel creatLabelWithTitle:titleAry[i] textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
        titleL.frame = CGRectMake(13, i == 0?maxY + 35 :(i == 1 ? maxY +74 : maxY + 128), 100, 22);
        [whiteV addSubview:titleL];
        
        if (i != 0) {
            UILabel *rightL = [UILabel creatLabelWithTitle:@"" textColor:KMaintextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_R(15)];
            rightL.frame = CGRectMake(123, 0, ScreenWidth - 135, 22);
            rightL.centerY = titleL.centerY;
            rightL.tag = 122+i;
            [whiteV addSubview:rightL];
        }else{
            numAddReduceView *view = [[numAddReduceView alloc]initWithFrame:CGRectMake(ScreenWidth - 12 - 88, 0, 88, 22)];
            view.centerY = titleL.centerY;
            [whiteV addSubview:view];
            self.numView = view;
            CJWeakSelf()
            self.numView.numChangeBlock = ^(NSInteger num) {
                CJStrongSelf()
                self.buyNum = num;
                [self setNumAndPrice];
            };
        }
    }
    
    UIView *lineV = [[UIView alloc]init];
    lineV.frame = CGRectMake(14, maxY + 111, ScreenWidth - 28, 1);
    lineV.backgroundColor = KBlackLineColor;
    [whiteV addSubview:lineV];

    self.tableView.tableHeaderView = view;
    [self startLoadingHUD];
    [self getPrice];
    [self getFeerate];
}

- (void)getPrice{
    [THHttpManager GET:@"shop/shopActivateCodeInfo/codeTypeList" parameters:@{} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        if (returnCode == 200 && [data isKindOfClass:[NSArray class]]) {
            for (int i =0; i < [data count]; i ++) {
                NSDictionary *dica = data[i];
                BuyTuanModel *model = [BuyTuanModel mj_objectWithKeyValues:dica];
                priceInfoBtn *btn = [self.view viewWithTag:111+i];
                btn.model = model;
            }
        }
    }];
}

- (void)getFeerate{
    CJWeakSelf()
    [THHttpManager GET:@"shop/shopActivateCodeInfo/getBuyRate" parameters:@{} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        CJStrongSelf()
        [self stopLoadingHUD];
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            if ([data objectForKey:@"buyRate"]) {
                self.payRate = [[data objectForKey:@"buyRate"] floatValue];
                [self setNumAndPrice];
            }
        }
    }];
}

-(void)setNumAndPrice{
    NSString *price = self.selectPriceBtn.model.salePrice;
    UILabel *lable1 = [self.view viewWithTag:123];
    UILabel *lable2 = [self.view viewWithTag:124];
    lable2.text = [NSString stringWithFormat:@"¥%.2f",price.floatValue * self.payRate *self.buyNum];
    lable1.text = [NSString stringWithFormat:@"¥%.2f",price.floatValue *(1 - self.payRate) *self.buyNum];;
}

- (void)creatFooterView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 74)];
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"提交审核" Target:self Action:@selector(submitClick) Font:DEFAULT_FONT_M(17) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
    btn.frame = CGRectMake(12, 12, ScreenWidth - 24, 50);
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 25;
    [view addSubview:btn];
    self.tableView.tableFooterView = view;
}

//- (void)submitClick1{
//    if (!self.zhifuImage) {
//        [self showMessageWithString:@"请选择上传凭证"];
//        return;
//    }
//    [self startLoadingHUD];
//    [AppTool uploadImages:@[self.zhifuImage] isAsync:YES callback:^(BOOL success, NSString * _Nonnull msg, NSArray<NSString *> * _Nonnull keys) {
//
//        NSString *url = [NSString stringWithFormat:@"%@/%@",msg,[keys firstObject]];
//        NSString *price = self.selectPriceBtn.model.salePrice;
//        NSString *totalMoneySale = [NSString stringWithFormat:@"%.2f",price.floatValue * self.payRate *self.buyNum];
//        NSString *discountRateSub = [NSString stringWithFormat:@"%.2f",price.floatValue *(1 - self.payRate) *self.buyNum];
//
//        NSDictionary *dica = @{@"codeTypeName":self.selectPriceBtn.model.codeTypeName,
//                               @"discountRateSub":discountRateSub,
//                               @"number":[NSString stringWithFormat:@"%ld",(long)self.buyNum],
//                               @"payType":@"1",
//                               @"totalMoneyOrder":totalMoneySale,
//                               @"totalMoneySale":totalMoneySale,
//                               @"typeId":self.selectPriceBtn.model.typId,
//                               @"payEvidence":url
//        };
//        [THHttpManager FormatPOST:@"shop/shopActivateCodeInfo/buyActivateCode" parameters:dica dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
//            [self stopLoadingHUD];
//            if (returnCode == 200) {
//                [self.navigationController popViewControllerAnimated:YES];
//            }
//        }];
//    }];
//}

- (void)submitClick{
    if (!self.zhifuImage) {
        [self showMessageWithString:@"请选择上传凭证"];
        return;
    }
    [self startLoadingHUD];
    __block NSString *payPath = @"";
    __block NSString *payName = @"";
    NSString *file = @"pay";
    NSData *data = UIImageJPEGRepresentation(self.zhifuImage, 0.5);;
    [THHttpManager uploadImagePOST:@"system/file/upload/pay" parameters:@{@"file":data} withFileName:file block:^(NSInteger returnCode, THRequestStatus status, id data) {
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
        payPath = [data objectForKey:@"imgUrl"];
        payName = [data objectForKey:@"imgUrlName"];
        NSString *url = [NSString stringWithFormat:@"%@/%@",payPath,payName];
        NSString *price = self.selectPriceBtn.model.salePrice;
        NSString *totalMoneySale = [NSString stringWithFormat:@"%.2f",price.floatValue * self.payRate *self.buyNum];
        NSString *discountRateSub = [NSString stringWithFormat:@"%.2f",price.floatValue *(1 - self.payRate) *self.buyNum];
        
        NSDictionary *dica = @{@"codeTypeName":self.selectPriceBtn.model.codeTypeName,
                               @"discountRateSub":discountRateSub,
                               @"number":[NSString stringWithFormat:@"%ld",(long)self.buyNum],
                               @"payType":@"1",
                               @"totalMoneyOrder":totalMoneySale,
                               @"totalMoneySale":totalMoneySale,
                               @"typeId":self.selectPriceBtn.model.typId,
                               @"payEvidence":url
        };
        [THHttpManager FormatPOST:@"shop/shopActivateCodeInfo/buyActivateCode" parameters:dica dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
            [self stopLoadingHUD];
            if (returnCode == 200) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        }
    }];
}

- (void)btnClick:(priceInfoBtn *)btn{
    if (!btn.isSelected) {
        btn.isSelected = YES;
        
        self.selectPriceBtn.isSelected = NO;
        self.selectPriceBtn = btn;
        [self setNumAndPrice];
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SetIOS13;
    [navigationController setNavigationBarHidden:NO animated:YES];
}

@end

@interface priceInfoBtn ()

@property (nonatomic , strong)UIImageView *selectImage;
@property (nonatomic , strong)UILabel *titleL;
@property (nonatomic , strong)UILabel *priceL;

@end

@implementation priceInfoBtn

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    self.layer.cornerRadius = 8;
    
    self.selectImage = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"choosed")];
    [self addSubview:self.selectImage];
    [self.selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(self);
        make.height.width.mas_equalTo(24);
    }];
    
    //年卡 永久卡
    UILabel *title = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(18)];
    [self addSubview:title];
    self.titleL = title;
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(14);
        make.right.mas_equalTo(self).offset(-12);
        make.left.mas_equalTo(self).offset(12);
        make.height.mas_equalTo(26);
    }];
    
    UILabel *price = [UILabel creatLabelWithTitle:@"" textColor:KBlack666TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(13)];
    [self addSubview:price];
    self.priceL = price;
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(14);
        make.right.mas_equalTo(self).offset(-14);
        make.top.mas_equalTo(title.mas_bottom).offset(5);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *num = [UILabel creatLabelWithTitle:@"剩余100张" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(13)];
    [self addSubview:num];
    [num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-13);
        make.right.mas_equalTo(self).offset(-12);
        make.left.mas_equalTo(self).offset(12);
        make.height.mas_equalTo(21);
    }];
    num.hidden = YES;
}

- (void)setModel:(BuyTuanModel *)model{
    _model = model;
    
    self.titleL.text = model.codeTypeName;
    
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@/张",model.salePrice]];
    [attributeMarket addAttribute:NSForegroundColorAttributeName value:KMaintextColor range:NSMakeRange(0,4)];
    [attributeMarket addAttribute:NSFontAttributeName value:DIN_Medium_FONT_R(13) range:NSMakeRange(0,1)];
    [attributeMarket addAttribute:NSFontAttributeName value:DIN_Medium_FONT_R(20) range:NSMakeRange(1,3)];
    self.priceL.attributedText = attributeMarket;
}

- (void)setIsSelected:(NSInteger)isSelected{
    _isSelected = isSelected;
    if (_isSelected) {
        self.layer.borderColor = KMaintextColor.CGColor;
        self.layer.borderWidth = 1;
        self.backgroundColor = kRGBA(250, 23, 45, 0.08);
        
        self.selectImage.hidden = NO;
    }else{
        self.layer.borderColor = KBlackLineColor.CGColor;
        self.layer.borderWidth = 1;
        self.backgroundColor = KWhiteBGColor;
        self.selectImage.hidden = YES;
    }
}

@end

@interface numAddReduceView ()

@end

@implementation numAddReduceView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{

    self.layer.cornerRadius = 2;
    self.layer.borderColor = kRGB(245, 245, 245).CGColor;
    self.layer.borderWidth = 1;
    
    float height = self.frame.size.height;
    float width = self.frame.size.width;
    
    UIButton *reduceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, height, height)];
    [reduceBtn setTitle:@"-" forState:UIControlStateNormal];
    [reduceBtn setTitleColor:KBlack333TextColor forState:UIControlStateNormal];
    reduceBtn.tag = 11;
    [reduceBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:reduceBtn];
    
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(width-height, 0, height, height)];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn setTitleColor:KBlack333TextColor forState:UIControlStateNormal];
    addBtn.tag = 12;
    [addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];
    
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(height, 0, width -2*height, height)];
    field.text = @"1";
    field.textAlignment = NSTextAlignmentCenter;
    field.font = DEFAULT_FONT_R(15);
    field.tag = 13;
    field.userInteractionEnabled = NO;
    [self addSubview:field];
}

- (void)btnClick:(UIButton *)btn{
    UITextField *field = [self viewWithTag:13];
    if (btn.tag == 11) {
        if (field.text.integerValue > 1) {
            field.text = [NSString stringWithFormat:@"%ld",field.text.integerValue -1];
        }
    }else if (btn.tag == 12) {
        field.text = [NSString stringWithFormat:@"%ld",field.text.integerValue +1];
    }
    if (_numChangeBlock) {
        _numChangeBlock(field.text.integerValue);
    }
}

@end

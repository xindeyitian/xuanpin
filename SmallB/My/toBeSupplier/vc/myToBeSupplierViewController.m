//
//  myToBeSupplierViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import "myToBeSupplierViewController.h"
#import "BaseFieldTableViewCell.h"
#import "BasePhotoTableViewCell.h"
#import "CardTableViewCell.h"
#import "BaseOwnerNavView.h"
#import "BasePhoneTableViewCell.h"
#import "BasePhoneCodeTableViewCell.h"

@interface myToBeSupplierViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    float oneWidth;
}
@property (nonatomic , strong)NSMutableArray *placeholderAry;
@property (nonatomic , strong)NSMutableArray *otherImgAry;
@property (nonatomic , strong)NSMutableArray *otherAssets;
@property (nonatomic , strong)NSMutableArray *imageAry;
@property (nonatomic , strong)UIImage *yingyeImg;
@property (nonatomic , strong)BaseOwnerNavView *nav;

@property (nonatomic , copy)NSString *supplierName;
@property (nonatomic , copy)NSString *userName;
@property (nonatomic , copy)NSString *phone;
@property (nonatomic , copy)NSString *phoneCode;
@property (nonatomic , copy)NSString *adddress;
@property (nonatomic , copy)NSString *cardHand;
@property (nonatomic , copy)NSString *cardFront;
@property (nonatomic , copy)NSString *cardBack;
@property (nonatomic , copy)NSString *cardPath;
@property (nonatomic , copy)NSString *yingye;

@property (nonatomic , strong)BRProvinceModel *provinceModel;
@property (nonatomic , strong)BRCityModel *cityModel;
@property (nonatomic , strong)BRAreaModel *areaModel;
@property (nonatomic , strong)UIButton *xieyiBtn;

@end

@implementation myToBeSupplierViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.delegate = self;
    self.navigationItem.title = @"供应商";
    self.imageAry = [NSMutableArray arrayWithObjects:@"1",@"1",@"1",nil];
    
    self.supplierName = @"";
    self.userName = @"";
    self.phone = @"";
    self.phoneCode = @"";
    self.adddress = @"";
    self.cardHand = @"";
    self.cardFront = @"";
    self.cardPath = @"";
    self.yingye = @"";
    self.yingyeImg = nil;
    
    self.provinceModel = [[BRProvinceModel alloc]init];
    self.cityModel = [[BRCityModel alloc]init];
    self.areaModel = [[BRAreaModel alloc]init];
    
    oneWidth = (ScreenWidth - 48)/3.0;
    self.placeholderAry = [@[@"请输入供货商名称（不超过15个字符）",@"请输入联系人",@"请输入手机号",@"请输入验证码",@"所在地区",@"详细地址"] mutableCopy];
    self.otherImgAry = [NSMutableArray array];
    self.otherAssets = [NSMutableArray array];
    
    self.view.backgroundColor = self.tableView.backgroundColor = KWhiteBGColor;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.right.equalTo(self.view);
    }];
    [self.tableView registerClass:[BaseFieldTableViewCell class]
           forCellReuseIdentifier:[BaseFieldTableViewCell description]];
    [self.tableView registerClass:[BasePhotoTableViewCell class]
           forCellReuseIdentifier:[BasePhotoTableViewCell description]];
    [self.tableView registerClass:[CardTableViewCell class]
           forCellReuseIdentifier:[CardTableViewCell description]];
    [self.tableView registerClass:[BasePhoneTableViewCell class]
           forCellReuseIdentifier:[BasePhoneTableViewCell description]];
    [self.tableView registerClass:[BasePhoneCodeTableViewCell class]
           forCellReuseIdentifier:[BasePhoneCodeTableViewCell description]];
    [self.tableView registerClass:[BaseOnePhotoTableViewCell class]
           forCellReuseIdentifier:[BaseOnePhotoTableViewCell description]];
    
    self.nav = [[BaseOwnerNavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight)];
    self.nav.backgroundColor = KWhiteBGColor;
    self.nav.titleL.text = @"申请成为供应商";
    self.nav.titleL.textColor = KWhiteTextColor;
    self.nav.backBtn.hidden = YES;
    self.nav.backgroundColor = kRGB(226, 79, 48);
    [self.view addSubview:self.nav];
    self.nav.alpha = 0;
    
    [self creatHeaderView];
    [self creatFooterView];
    
    BaseButton *backBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_R(15) BackgroundColor:UIColor.clearColor Color:KBlack333TextColor Frame:CGRectMake(12, KStatusBarHeight + 2, 40, 40) Alignment:NSTextAlignmentCenter Tag:1];
    [backBtn setImage:IMAGE_NAMED(@"bar_back") forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
}

- (void)btnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y;
    [UIView animateWithDuration:0.1 animations:^{
        if (offset > 209-KNavBarHeight){
            self.nav.alpha = 1;
        }else if(offset < 209-KNavBarHeight){
            self.nav.alpha = offset/(209-KNavBarHeight);
        }
    }];
}

- (void)btnClick:(UIButton *)btn{
    btn.selected =  !btn.selected;
}

- (void)submitClick{
    if (self.supplierName.length == 0) {
        [self showMessageWithString:@"请输入供应商名称"];
        return;
    }
    if (self.userName.length == 0) {
        [self showMessageWithString:@"请输入联系人"];
        return;
    }
    if (self.phone.length == 0) {
        [self showMessageWithString:@"请输入手机号"];
        return;
    }
    if (self.phone.length != 11) {
        [self showMessageWithString:@"请输入正确的手机号"];
        return;
    }
    if (self.phoneCode.length != 4) {
        [self showMessageWithString:@"请输入正确的验证码"];
        return;
    }
    if (self.provinceModel.name.length == 0) {
        [self showMessageWithString:@"请选择所在地址"];
        return;
    }
    if (self.adddress.length == 0) {
        [self showMessageWithString:@"请输入详细地址"];
        return;
    }
    if ([self.imageAry[0] isKindOfClass:[NSString class]] || [self.imageAry[1] isKindOfClass:[NSString class]] || [self.imageAry[2] isKindOfClass:[NSString class]]) {
        
        [self showMessageWithString:@"请选择身份证信息"];
        return;
    }
    if (!self.yingyeImg) {
        [self showMessageWithString:@"请选择营业执照"];
        return;
    }
    if (!self.xieyiBtn.selected) {
        [self showMessageWithString:@"请阅读并同意隐私政策"];
        return;
    }
    [self startLoadingHUD];
    NSMutableArray *fileAry = [NSMutableArray array];
    __block NSString *idCardPath = @"";
    __block NSString *idCardBack = @"";
    __block NSString *idCardFront = @"";
    __block NSString *idCardHand = @"";
    
    for (int i =0; i < self.imageAry.count; i ++) {
        UIImage *image = self.imageAry[i];
        NSData *data = UIImageJPEGRepresentation(image, 0.5);;
        
        NSString *file = @"";
        if (i == 0) {
            file = @"Hand";
        }
        if (i == 0) {
            file = @"Front";
        }
        if (i == 0) {
            file = @"Back";
        }
        [THHttpManager uploadImagePOST:@"system/file/uploadIdCard" parameters:@{@"file":data} withFileName:file block:^(NSInteger returnCode, THRequestStatus status, id data) {
            if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
                [fileAry addObject:@"1"];
                idCardPath = [data objectForKey:@"imgUrl"];
                if (i == 0) {
                    idCardHand = [data objectForKey:@"imgUrlName"];
                }
                if (i == 1) {
                    idCardFront = [data objectForKey:@"imgUrlName"];
                }
                if (i == 2) {
                    idCardBack = [data objectForKey:@"imgUrlName"];
                }
            }
            if (fileAry.count == self.imageAry.count) {
                NSMutableArray *allImage = [NSMutableArray arrayWithArray:self.otherImgAry];
                [allImage insertObject:self.yingyeImg atIndex:0];
                __block NSString *string = @"";
                [AppTool uploadImages:allImage isAsync:YES callback:^(BOOL success, NSString * _Nonnull msg, NSArray<NSString *> * _Nonnull keys) {
                    
                    for (int i =0; i < keys.count; i ++) {
                        NSString *url = [NSString stringWithFormat:@"%@/%@",msg,keys[i]];
                        if (i == 0) {
                            self.yingye = url;
                        }else{
                            string =  [string stringByAppendingString:[NSString stringWithFormat:@"%@,",url]];
                        }
                    }
                    
                    NSDictionary *dica = @{@"areaCode":self.areaModel.code,
                                           @"areaName":self.areaModel.name,
                                           @"cityCode":self.cityModel.code,
                                           @"cityName":self.cityModel.name,
                                           @"contactsName":self.userName,
                                           @"detailAddress":self.adddress,
                                           @"idCardBack":idCardBack,
                                           @"idCardFront":idCardFront,
                                           @"idCardHand":idCardHand,
                                           @"idCardPath":idCardPath,
                                           @"otherCertificates":string,
                                           @"phoneNumber":self.phone,
                                           @"provinceCode":self.provinceModel.code,
                                           @"provinceName":self.provinceModel.name,
                                           @"socialNo":self.yingye,
                                           @"supplyName":self.supplierName,
                                           @"verificationCode":self.phoneCode,
                    };
                    
                    [THHttpManager POST:@"supply/supplyInfo/applySupplier" parameters:dica dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
                        [self stopLoadingHUD];
                        if (returnCode == 200) {
                            [self showSuccessMessageWithString:@"申请成功"];
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    }];
                }];
            }
        }];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.placeholderAry.count + 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < self.placeholderAry.count) {
        return 60;
    }
    if (indexPath.section == self.placeholderAry.count) {
        return UITableViewAutomaticDimension;
    }
    if (indexPath.section == self.placeholderAry.count+1) {
        return oneWidth + 72 + 20;
    }
    if (indexPath.section == self.placeholderAry.count+2) {
        if (self.otherImgAry.count > 2) {
            return oneWidth + 72 + 20 +(oneWidth+12);
        }else{
            return oneWidth + 72 + 20 ;
        }
    }
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        BasePhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BasePhoneTableViewCell description]];
        cell.fieldT.placeholder = self.placeholderAry[indexPath.section];
        self.phone = cell.fieldT.text;
        cell.viewBlock = ^(NSString * _Nonnull content) {
//            self.phone = content;
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:(UITableViewRowAnimationNone)];
        };
        return cell;
    }
    if (indexPath.section == 3) {
        BasePhoneCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BasePhoneCodeTableViewCell description]];
        cell.fieldT.placeholder = self.placeholderAry[indexPath.section];
        cell.phoneType = @"11";
        cell.phone = self.phone;
        cell.viewBlock = ^(NSString * _Nonnull content) {
            self.phoneCode = content;
        };
        return cell;
    }
    if (indexPath.section < self.placeholderAry.count) {
        BaseFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseFieldTableViewCell description]];
        cell.autoCorner = YES;
        [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
        cell.havRightImgV = indexPath.section == 4;
        cell.fieldT.placeholder = self.placeholderAry[indexPath.section];
        if (indexPath.section == 0) {
            cell.fieldT.text = self.supplierName;
            cell.maxNum = 15;
        }
        if (indexPath.section == 1) {
            cell.fieldT.text = self.userName;
        }
        if (indexPath.section == 4 &&self.provinceModel.name) {
            cell.fieldT.text = [NSString stringWithFormat:@"%@ %@ %@",self.provinceModel.name,self.cityModel.name,self.areaModel.name];
        }
        if (indexPath.section == 5) {
            cell.fieldT.text = self.adddress;
        }
        cell.viewBlock = ^(NSString * _Nonnull content) {
            if (indexPath.section == 0) {
                self.supplierName = content;
            }
            if (indexPath.section == 1) {
               self.userName = content;
            }
            if (indexPath.section == 5) {
                self.adddress = content;
            }
        };
        return cell;
    }
    if (indexPath.section == self.placeholderAry.count) {
        CardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CardTableViewCell description]];
        cell.viewBlock = ^(NSMutableArray * _Nonnull array) {
            self.imageAry = array;
        };
        return cell;
    }
    BOOL yingye = (indexPath.section == self.placeholderAry.count + 1);
    if (yingye) {
        BaseOnePhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseOnePhotoTableViewCell description]];
        cell.backgroundColor = KWhiteBGColor;
        cell.titleL.text = @"上传营业执照";
        cell.subTitleL.text = @"(请上传最新的营业执照照片)";
        if (self.yingyeImg) {
            cell.yingyeImage = self.yingyeImg;
        }
        cell.viewClickBlock = ^(BOOL isAdd, NSInteger index) {
            if (isAdd) {
                [self addPhotoWithDuoXuan:NO section:indexPath.section];
            }else{
                self.yingyeImg = nil;
                [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            }
        };
        return cell;
    }
    BasePhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BasePhotoTableViewCell description]];
    cell.backgroundColor = KWhiteBGColor;
    cell.maxNum = 6;
    cell.titleL.text = @"其他行业经营资质";
    cell.subTitleL.text = @"(特殊行业请上传经营资质，最多可上传6张)";
    cell.photoAry = self.otherImgAry;
    CJWeakSelf()
    cell.viewClickBlock = ^(BOOL isAdd, NSInteger index) {
        CJStrongSelf()
        if (isAdd) {
            [self addPhotoWithDuoXuan:YES section:indexPath.section];
        }else{
            [self.otherImgAry removeObjectAtIndex:index];
            [self.otherAssets removeObjectAtIndex:index];
            [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        }
    };
    return cell;
}

- (void)addPhotoWithDuoXuan:(BOOL)duoxuan section:(NSInteger)section{
    NSInteger max = duoxuan ? 6: 1;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:max columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.naviTitleColor = [UIColor whiteColor];
    imagePickerVc.barItemTextColor = [UIColor whiteColor];
    if (duoxuan) {
        imagePickerVc.selectedAssets = self.otherAssets;
    }
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (duoxuan) {
            [self.otherImgAry removeAllObjects];
            [self.otherImgAry addObjectsFromArray:photos];
            [self.otherAssets removeAllObjects];
            [self.otherAssets addObjectsFromArray:assets];
           
        }else{
            if (photos.count) {
                self.yingyeImg = photos[0];
            }
        }
        [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    }];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 8)];
    view.backgroundColor = KWhiteBGColor;
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4) {
        [self.view endEditing:YES];
        BRAddressPickerView *pickView = [[BRAddressPickerView alloc] initWithPickerMode:BRAddressPickerModeArea];
        pickView.resultBlock = ^(BRProvinceModel * _Nullable province, BRCityModel * _Nullable city, BRAreaModel * _Nullable area) {
            self.provinceModel = province;
            self.cityModel = city;
            self.areaModel = area;
            
            [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        };
        [pickView show];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}

-(void)creatHeaderView{
    UIImageView *headImgV = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"supplier_head_img")];
    headImgV.frame = CGRectMake(0, 0, ScreenWidth, 209*KScreenW_Ratio);
    headImgV.userInteractionEnabled = YES;
    self.tableView.tableHeaderView = headImgV;
    
    UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(0, 209*KScreenW_Ratio-12, ScreenWidth, 12)];
    whiteV.backgroundColor = KWhiteBGColor;
    [headImgV addSubview:whiteV];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:whiteV.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = whiteV.bounds;
    maskLayer.path = maskPath.CGPath;
    whiteV.layer.mask = maskLayer;
}

-(void)creatFooterView{
    UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 116)];
    footerV.backgroundColor = KWhiteBGColor;
    self.tableView.tableFooterView = footerV;
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"申请成为供应商" Target:self Action:@selector(submitClick) Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    btn.frame = CGRectMake(12, 44, ScreenWidth - 24, 50);
    btn.layer.cornerRadius = 22;
    btn.clipsToBounds = YES;
    [footerV addSubview:btn];

//    btn.alpha = 0.5;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(12, 10, ScreenWidth -24, 30)];
    [button setImage:IMAGE_NAMED(@"choose") forState:UIControlStateNormal];
    [button setImage:IMAGE_NAMED(@"choosed") forState:UIControlStateSelected];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerV addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footerV).offset(10);
        make.left.equalTo(footerV).offset(12);
        make.height.mas_equalTo(30);
    }];
    self.xieyiBtn = button;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"已同意并阅读《小莲云仓商户入驻协议》" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#999999"]}];
    
    [text setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],
                          NSForegroundColorAttributeName : KMaintextColor} range:NSMakeRange(6, 12)];
    [button.titleLabel setAttributedText:text];
    [button setAttributedTitle:text forState:UIControlStateNormal];
    
    [button.titleLabel yb_addAttributeTapActionWithRanges:@[NSStringFromRange(NSMakeRange(6, 12))] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
        YinsiFuwuViewController * pvc = [[YinsiFuwuViewController alloc] init];
        pvc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:pvc animated:YES completion:nil];
    }];
}

@end



//
//  applyStore ViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/16.
//

#import "applyStoreViewController.h"
#import "BaseFieldTableViewCell.h"
#import "BasePhotoTableViewCell.h"
#import "CardTableViewCell.h"
#import "BaseOwnerNavView.h"
#import "BasePhoneCodeTableViewCell.h"
#import "BaseSelectTableViewCell.h"
#import "OpenStoreAlertViewController.h"
#import "selectCouponTableViewController.h"
#import "CouponListModel.h"

@interface applyStoreViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    float oneWidth;
}
@property (nonatomic , strong)NSMutableArray *placeholderAry;
@property (nonatomic , strong)NSMutableArray *contentAry;
@property (nonatomic , strong)NSMutableArray *otherImgAry;
@property (nonatomic , strong)NSMutableArray *otherAssets;
@property (nonatomic , strong)UIImage *yingyeImg;
@property (nonatomic , strong)BaseOwnerNavView *nav;

@property (nonatomic , strong)NSMutableArray *dataAry;
@property (nonatomic , assign)NSInteger selectIndex;
@property (nonatomic , copy)NSString *couponData;;
@property (nonatomic , strong)CouponListVosModel *selectModel;//已选中的优惠券

@property (nonatomic , strong)BRProvinceModel *provinceModel;
@property (nonatomic , strong)BRCityModel *cityModel;
@property (nonatomic , strong)BRAreaModel *areaModel;

@property (nonatomic , strong)NSString *storeName;
@property (nonatomic , strong)NSString *userName;
@property (nonatomic , strong)NSString *address;

@property (nonatomic , strong)NSMutableArray *imageAry;

@end

@implementation applyStoreViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectIndex = 0;
    self.navigationController.delegate = self;
    self.navigationItem.title = @"供应商";
    self.dataArray = [NSMutableArray array];
    self.storeName = self.userName = self.address = @"";
    self.imageAry = [NSMutableArray arrayWithObjects:@"1",@"1",@"1",nil];
    
    oneWidth = (ScreenWidth - 48)/3.0;
    //  self.placeholderAry = [@[@"请输入店铺名称（不超过15个字符）",@"请输入真实姓名",@"请输入手机号",@"请输入验证码",@"所在地区",@"详细地址"] mutableCopy];
    self.placeholderAry = [@[@"请输入店铺名称（不超过15个字符）",@"请输入真实姓名",@"所在地区",@"详细地址"] mutableCopy];
    self.contentAry = [NSMutableArray arrayWithCapacity:self.placeholderAry.count];
    
    self.otherImgAry = [NSMutableArray array];
    self.otherAssets = [NSMutableArray array];
    self.couponData = @"";
    
    self.view.backgroundColor = self.tableView.backgroundColor = kRGB(245, 245, 245);
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.right.equalTo(self.view);
    }];
    [self.tableView registerClass:[BaseFieldTableViewCell class]
           forCellReuseIdentifier:[BaseFieldTableViewCell description]];
    [self.tableView registerClass:[BasePhotoTableViewCell class]
           forCellReuseIdentifier:[BasePhotoTableViewCell description]];
    [self.tableView registerClass:[CardTableViewCell class]
           forCellReuseIdentifier:[CardTableViewCell description]];
    [self.tableView registerClass:[BasePhoneCodeTableViewCell class]
           forCellReuseIdentifier:[BasePhoneCodeTableViewCell description]];
    [self.tableView registerClass:[BaseSelectTableViewCell class]
           forCellReuseIdentifier:[BaseSelectTableViewCell description]];
    
    self.nav = [[BaseOwnerNavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight)];
    self.nav.backgroundColor = KWhiteBGColor;
    self.nav.titleL.text = @"申请开店";
    self.nav.titleL.textColor = KWhiteTextColor;
    self.nav.backBtn.hidden = YES;
    self.nav.backgroundColor = kRGB(226, 79, 48);
    [self.view addSubview:self.nav];
    self.nav.alpha = 0;
    
    [self creatHeaderView];
    [self creatFooterView];
    
    BaseButton *backBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_R(15) BackgroundColor:UIColor.clearColor Color:KBlack333TextColor Frame:CGRectMake(0, KStatusBarHeight + 2, 40, 40) Alignment:NSTextAlignmentCenter Tag:1];
    [backBtn setImage:IMAGE_NAMED(@"bar_back") forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    [self getCouponList];
}

- (void)getCouponList{
    [self startLoadingHUD];
    [THHttpManager GET:@"goods/couponInfo/couponList" parameters:@{@"typeCode":@"shopCode"} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200 && [data isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dica in data) {
                CouponListModel *model = [CouponListModel mj_objectWithKeyValues:dica];
                [self.dataArray addObject:model];
            }
            if (self.dataArray.count) {
                CouponListModel *model = self.dataArray[0];
                if (model.couponListVos.count) {
                    CouponListVosModel *sModel = model.couponListVos[0];
                    self.selectModel = sModel;
                }
            }
            [self.tableView reloadData];
        }
    }];
}

- (void)btnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.placeholderAry.count + 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == self.placeholderAry.count + 1) {
        return self.dataArray.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < self.placeholderAry.count) {
        return 60;
    }
    if (indexPath.section == self.placeholderAry.count) {
        return UITableViewAutomaticDimension;
    }
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < self.placeholderAry.count) {
        BaseFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseFieldTableViewCell description]];
        cell.autoCorner = YES;
        [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
        cell.havRightImgV = indexPath.section == 4;
        if (indexPath.section == 0) {
            cell.maxNum = 15;
        }
        cell.fieldT.placeholder = self.placeholderAry[indexPath.section];
        cell.fieldT.userInteractionEnabled = !(indexPath.section == 2);
        CJWeakSelf()
        cell.viewBlock = ^(NSString * _Nonnull content) {
            CJStrongSelf();
            if (indexPath.section == 0) {
                self.storeName = content;
            }
            if (indexPath.section == 1) {
                self.userName = content;
            }
            if (indexPath.section == 3) {
                self.address = content;
            }
        };
        if (indexPath.section == 2) {
            if (self.provinceModel) {
                cell.fieldT.text = [NSString stringWithFormat:@"%@ %@ %@",self.provinceModel.name,self.cityModel.name,self.areaModel.name];
            }
        }
        return cell;
    }
    if (indexPath.section == self.placeholderAry.count) {
        CardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CardTableViewCell description]];
        cell.viewBlock = ^(NSMutableArray * _Nonnull array) {
            self.imageAry = array;
        };
        return cell;
    }
    BaseSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseSelectTableViewCell description]];
    cell.autoCorner = NO;
    cell.bgViewContentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    BOOL isNotFirst = indexPath.row == 1;
    cell.separatorLineView.hidden = isNotFirst;
    
    CouponListModel *model;
    if (self.dataArray.count) {
        model = self.dataArray[indexPath.row];
    }
    if (indexPath.section == self.placeholderAry.count + 1) {
       
        cell.titleL.text = [NSString stringWithFormat:@"%@ (¥%@)",model.typeName,model.moneyCouponSub];
        cell.rightImgV.image = !isNotFirst? (self.selectIndex == 0 ?  IMAGE_NAMED(@"choosed") :  IMAGE_NAMED(@"choose")) : (self.selectIndex == 1 ?  IMAGE_NAMED(@"choosed") :  IMAGE_NAMED(@"choose"));
        cell.leftImgV.image = !isNotFirst?  IMAGE_NAMED(@"openstore_year") : IMAGE_NAMED(@"openstore_yongjiu");
        cell.subTitleL.text = @"";
    }
    if (indexPath.section == self.placeholderAry.count + 2) {
        
        cell.titleL.text = @"优惠券";
        cell.rightImgV.image = IMAGE_NAMED(@"my_right_gray");
        cell.leftImgV.image = IMAGE_NAMED(@"openstore_youhuiquan");
        if (self.selectModel) {
            cell.subTitleL.text = [NSString stringWithFormat:@"¥%@ %@",self.selectModel.moneyCouponSub,self.selectModel.typeName];
        }
        cell.separatorLineView.hidden = YES;
        if (self.couponData.length) {
            cell.subTitleL.text = self.couponData;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
    view.backgroundColor = section < self.placeholderAry.count ?KWhiteBGColor : kRGB(245, 245, 245);
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.placeholderAry.count + 1) {
        if (self.selectIndex != indexPath.row) {
            self.selectIndex = indexPath.row;
            [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            
            if (self.dataArray.count) {
                CouponListModel *model = self.dataArray[self.selectIndex];
                if (model.couponListVos.count) {
                    CouponListVosModel *sModel = model.couponListVos[0];
                    self.selectModel = sModel;
                }
            }
            [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:indexPath.section+1] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
    if (indexPath.section == self.placeholderAry.count + 2) {
        selectCouponTableViewController *alertVC = [selectCouponTableViewController new];
        if (self.dataArray.count) {
            CouponListModel *model = self.dataArray[self.selectIndex];
            if (model.couponListVos.count) {
                alertVC.couponAry = model.couponListVos;
            }
        }
        if (self.selectModel) {
            alertVC.selectModel = self.selectModel;
        }
        alertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        CJWeakSelf()
        alertVC.viewClickBlock = ^(CouponListVosModel * _Nonnull model) {
            CJStrongSelf()
            self.selectModel = model;
            [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        };
        [self  presentViewController:alertVC animated:NO completion:nil];
    }
    if (indexPath.section == 2) {
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
    UIImageView *headImgV = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"apply_store")];
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
    UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 74)];
    footerV.backgroundColor = kRGB(245, 245, 245);
    self.tableView.tableFooterView = footerV;
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"申请开店" Target:self Action:@selector(submitClick) Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    btn.frame = CGRectMake(12, 12, ScreenWidth - 24, 50);
    btn.layer.cornerRadius = 22;
    btn.clipsToBounds = YES;
    [footerV addSubview:btn];
}

- (void)submitClick{
    
    if (self.storeName.length == 0) {
        [self showMessageWithString:self.placeholderAry[0]];
        return;
    }
    if (self.userName.length == 0) {
        [self showMessageWithString:self.placeholderAry[1]];
        return;
    }
    if (!self.provinceModel) {
        [self showMessageWithString:@"请选择所在地区"];
        return;
    }
    if (self.address.length == 0) {
        [self showMessageWithString:@"请输入详细地址"];
        return;
    }
    if ([self.imageAry[0] isKindOfClass:[NSString class]] || [self.imageAry[1] isKindOfClass:[NSString class]] || [self.imageAry[2] isKindOfClass:[NSString class]]) {
        
        [self showMessageWithString:@"请选择身份证信息"];
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
                NSLog(@"====%@======%@",[data objectForKey:@"imgUrl"],idCardFront = [data objectForKey:@"imgUrlName"]);
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
                CouponListModel *model;
                if (self.dataArray.count) {
                    model = self.dataArray[self.selectIndex];
                }
                NSDictionary *dica = @{@"areaCode":self.areaModel.code,
                                       @"areaName":self.areaModel.name,
                                       @"cityCode":self.cityModel.code,
                                       @"cityName":self.cityModel.name,
                                       @"couponId":self.selectModel.couponId,
                                       @"detailAddress":self.address,
                                       @"discountRateSub":self.selectModel.moneyCouponSub,
                                       @"idCardBack":idCardBack,
                                       @"idCardFront":idCardFront,
                                       @"idCardHand":idCardHand,
                                       @"idCardPath":idCardPath,
                                       @"provinceCode":self.provinceModel.code,
                                       @"provinceName":self.provinceModel.name,
                                       @"realName":self.userName,
                                       @"shopName":self.storeName,
                                       @"storeDisplayType":[NSString stringWithFormat:@"%d",self.typeIndex],
                                       @"totalMoneyOrder":@"0",
                                       @"totalMoneySale":@"0",
                                       @"typeId":model.typeId,//开店类型编号,一年开店,永久开店

                };
                [THHttpManager POST:@"shop/shopInfo/applyShop" parameters:dica dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
                    [self stopLoadingHUD];
                    if (returnCode == 200) {
                        OpenStoreAlertViewController *alertVC = [OpenStoreAlertViewController new];
                        alertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
                        [self  presentViewController:alertVC animated:NO completion:nil];
                    }
                }];
            }
        }];
    }
}

@end



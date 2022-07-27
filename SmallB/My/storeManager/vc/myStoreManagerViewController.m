//
//  myStoreManagerViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import "myStoreManagerViewController.h"
#import "myOrderListContentViewController.h"
#import "BaseFieldTableViewCell.h"
#import "BasePhotoTableViewCell.h"
#import "CardTableViewCell.h"
#import "BaseOwnerNavView.h"
#import "BaseTextViewTableViewCell.h"
#import "ShopInstroTableViewCell.h"
#import "shopInfoTableViewCell.h"
#import "StoreManagerModel.h"

@interface myStoreManagerViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    float oneWidth;
}
@property (nonatomic , strong)NSMutableArray *titleAry;
@property (nonatomic , strong)NSMutableArray *otherImgAry;
@property (nonatomic , strong)BaseOwnerNavView *nav;

@property (nonatomic , strong)BRProvinceModel *provinceModel;
@property (nonatomic , strong)BRCityModel *cityModel;
@property (nonatomic , strong)BRAreaModel *areaModel;

@property (nonatomic , copy)NSString *urlPath;
@property (nonatomic , copy)NSString *bucket;
@property (nonatomic , copy)NSString *bgImgUrl;
@property (nonatomic , copy)NSString *logoImgUrl;
@property (nonatomic , copy)NSString *shopDesc;
@property (nonatomic , copy)NSString *address;
@property (nonatomic , copy)NSString *shopId;
@property (nonatomic , copy)NSString *shopName;

@property (nonatomic , strong)UIImage *bgImg;
@property (nonatomic , strong)UIImage *logoImg;

@property (nonatomic , assign)BOOL isEdit;

@end

@implementation myStoreManagerViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bgImg = nil;
    self.logoImg = nil;
    self.provinceModel = [[BRProvinceModel alloc]init];
    self.cityModel = [[BRCityModel alloc]init];
    self.areaModel = [[BRAreaModel alloc]init];
    self.isEdit = NO;
    
    self.navigationController.delegate = self;
    self.navigationItem.title = @"";
    oneWidth = (ScreenWidth - 48)/3.0;
    self.titleAry = [@[@"",@"店铺名称 (好的名字能让人记忆深刻)",@"店铺招牌图 (建议尺寸比例 16:9)",@"店铺简介",@"您所在的服务区",@"详细地址"] mutableCopy];
    self.otherImgAry = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = self.tableView.backgroundColor = KWhiteBGColor;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.right.equalTo(self.view);
    }];
    [self.tableView registerClass:[BaseFieldTableViewCell class]
           forCellReuseIdentifier:[BaseFieldTableViewCell description]];
    [self.tableView registerClass:[BaseTextViewTableViewCell class]
           forCellReuseIdentifier:[BaseTextViewTableViewCell description]];
    [self.tableView registerClass:[ShopInstroTableViewCell class]
           forCellReuseIdentifier:[ShopInstroTableViewCell description]];
    [self.tableView registerClass:[shopInfoTableViewCell class]
           forCellReuseIdentifier:[shopInfoTableViewCell description]];

    self.nav = [[BaseOwnerNavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight)];
    self.nav.backBtn.hidden =  self.nav.titleL.hidden = YES;
    self.nav.backgroundColor = kRGB(226, 79, 48);
    [self.view addSubview:self.nav];
    self.nav.alpha = 0;
    
    [self creatHeaderView];
    [self creatFooterView];
    
    BaseButton *backBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_R(15) BackgroundColor:UIColor.clearColor Color:KBlack333TextColor Frame:CGRectMake(12, KStatusBarHeight + 2, 40, 40) Alignment:NSTextAlignmentCenter Tag:1];
    [backBtn setImage:IMAGE_NAMED(@"bar_back") forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"我的店铺" textColor:KWhiteTextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(18)];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.right.mas_equalTo(self.view).offset(-50);
        make.left.mas_equalTo(self.view).offset(50);
        make.height.mas_equalTo(40);
    }];
    [self getMyStoreInfo];
}

- (void)getMyStoreInfo{
    
    [self startLoadingHUD];
    [THHttpManager GET:@"shop/shopInfo/getShopInfo" parameters:@{} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            StoreManagerModel *model = [StoreManagerModel mj_objectWithKeyValues:data];
            
            self.provinceModel.code = model.provinceCode;
            self.provinceModel.name = model.provinceName;
            
            self.cityModel.code = model.cityCode;
            self.cityModel.name = model.cityName;
         
            self.areaModel.code = model.areaCode;
            self.areaModel.name = model.areaName;

            self.urlPath = model.urlPath;
            self.bucket = model.bucket;
            self.bgImgUrl = model.bgImgUrl;
            self.logoImgUrl = model.logoImgUrl;
            self.shopDesc = model.shopDesc;
            self.address = model.address;
            self.shopId = model.shopId;
            self.shopName = model.shopName;
            
       
            self.isEdit = YES;
      
        }
        [self.tableView reloadData];
    }];
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

- (void)submitClick{
    if (self.logoImgUrl.length == 0 && !self.logoImg) {
        [self showMessageWithString:@"请选择店铺LOGO"];
        return;
    }
    if (self.shopName.length == 0 ) {
        [self showMessageWithString:@"请输入店铺名称"];
        return;
    }
    if (self.bgImgUrl.length == 0 && !self.bgImg) {
        [self showMessageWithString:@"请选择店铺招牌图"];
        return;
    }
    if (self.shopDesc.length == 0 ) {
        [self showMessageWithString:@"请输入店铺简介"];
        return;
    }
    if (!self.provinceModel || self.provinceModel.name.length == 0) {
        [self showMessageWithString:@"请选择地址"];
        return;
    }
    if (self.address.length == 0) {
        [self showMessageWithString:@"请输入详细地址"];
        return;
    }
    NSMutableArray *imageAry = [NSMutableArray array];
    if (self.logoImg) {
        [imageAry addObject:self.logoImg];
    }
    if (self.bgImg) {
        [imageAry addObject:self.bgImg];
    }
    [self startLoadingHUD];
    if (imageAry.count) {
        [AppTool uploadImages:imageAry isAsync:YES fileName:@"storeManager" callback:^(BOOL success, NSString * _Nonnull msg, NSArray<NSString *> * _Nonnull keys) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.urlPath = msg;
                self.bucket = @"llwf";
                if (imageAry.count == 1) {
                    if (self.logoImg) {
                        self.logoImgUrl =  [NSString stringWithFormat:@"/%@",keys[0]];
                    }
                    if (self.bgImg) {
                        self.bgImgUrl =  [NSString stringWithFormat:@"/%@",keys[0]];
                    }
                }
                if (imageAry.count == 2) {
                    self.logoImgUrl =  [NSString stringWithFormat:@"/%@",keys[0]];
                    self.bgImgUrl =  [NSString stringWithFormat:@"/%@",keys[1]];
                }
                [self updateShopInfoWithChange:YES];
            }];
        }];
    }else{
        self.urlPath = @"";
        self.bucket = @"";
        [self updateShopInfoWithChange:NO];
    }
}

-(void)updateShopInfoWithChange:(BOOL)isChangeImage{
    NSMutableDictionary *dica = [@{@"address":self.address,
                           @"areaCode":self.areaModel.code,
                           @"areaName":self.areaModel.name,
                           @"bgImgUrl":self.bgImgUrl,
                           @"cityCode":self.cityModel.code,
                           @"cityName":self.cityModel.name,
                           @"logoImgUrl":self.logoImgUrl,
                           @"provinceCode":self.provinceModel.code,
                           @"provinceName":self.provinceModel.name,
                           @"shopDesc":self.shopDesc,
                           @"shopId":self.shopId,
                           @"shopName":self.shopName,
                           
    } mutableCopy];
    if (isChangeImage) {
        [dica setValue:self.urlPath forKey:@"urlPath"];
        [dica setValue:self.bucket forKey:@"bucket"];
    }
    [THHttpManager FormatPOST:@"shop/shopInfo/updateShopInfo" parameters:dica dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200) {
            [self showSuccessMessageWithString:@"编辑成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleAry.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return 121+20;
    }
    if (indexPath.section == 2) {
        return 183;
    }
    if (indexPath.section == 0) {
        return 50;
    }
    return 52;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 || indexPath.section == 4 || indexPath.section == 5) {
        BaseFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseFieldTableViewCell description]];
        cell.autoCorner = YES;
        cell.cornerRadii = @(8);
        [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
        
        BOOL shop = indexPath.section == 1;
        cell.fieldT.placeholder = shop ? @"请输入店铺名称（不超过15个字符）":@"地址选择";
        if (shop) {
            cell.maxNum = 15;
        }
        cell.fieldT.userInteractionEnabled = shop;
        cell.havRightImgV = !shop;
        cell.rightImgV.image = IMAGE_NAMED(@"my_right_gray");
        cell.bgViewContentInset = UIEdgeInsetsMake(0, 24, 0, 24);
        cell.viewBlock = ^(NSString * _Nonnull content) {
            if (indexPath.section == 5) {
                self.address = content;
            }
            if (indexPath.section == 1) {
                self.shopName = content;
            }
        };
        if (indexPath.section == 4 && self.provinceModel) {
            cell.fieldT.text = [NSString stringWithFormat:@"%@ %@ %@",self.provinceModel.name,self.cityModel.name,self.areaModel.name];
        }
        if (indexPath.section == 5) {
            cell.fieldT.placeholder = @"详细地址";
            cell.havRightImgV = NO;
            cell.fieldT.userInteractionEnabled = YES;
            cell.fieldT.text = self.address;
        }
        if (indexPath.section == 1) {
            cell.fieldT.text = self.shopName;
        }
        
        if (self.isEdit) {
            cell.fieldT.userInteractionEnabled = NO;
            cell.fieldT.textColor = KBlack666TextColor;
        }else{
            cell.fieldT.textColor = KBlack333TextColor;
        }
        return cell;
    }
    
    if (indexPath.section == 3) {
        BaseTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseTextViewTableViewCell description]];
        cell.bgViewContentInset = UIEdgeInsetsMake(0, 24, 0, 24);
        if (self.shopDesc) {
            cell.textV.text = self.shopDesc;
            cell.numL.text = [NSString stringWithFormat:@"%lu/20",(unsigned long)self.shopDesc.length];
        }
        cell.viewBlock = ^(NSString * _Nonnull content) {
            self.shopDesc = content;
        };
        return cell;
    }
    //店铺简介图片
    if (indexPath.section == 2) {
        ShopInstroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ShopInstroTableViewCell description]];
        if (self.bgImgUrl.length) {
            cell.imageUrl = [AppTool dealURLWithBase:self.bgImgUrl withUrlPath:self.urlPath];;
        }
        if (self.bgImg) {
            cell.selectImage = self.bgImg;
        }
        CJWeakSelf()
        cell.selectImageBlock = ^(UIImage * _Nonnull image) {
            CJStrongSelf();
            self.bgImg = image;
            [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        };
        return cell;
    }
    //店铺logo
    shopInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[shopInfoTableViewCell description]];
    if (self.logoImgUrl.length) {
        cell.imageUrl = [AppTool dealURLWithBase:self.logoImgUrl withUrlPath:self.urlPath];
    }
    if (self.logoImg) {
        cell.selectImage = self.logoImg;
    }
    CJWeakSelf()
    cell.selectImageBlock = ^(UIImage * _Nonnull image) {
        CJStrongSelf();
        self.logoImg = image;
        [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
    view.backgroundColor = KWhiteBGColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 5) {
        return 0.01f;
    }
    return 43;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0 || section == 5) {
        return [UIView new];
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 43)];
    view.backgroundColor = KWhiteBGColor;
    
    UILabel *lable = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(15)];
    lable.frame = CGRectMake(24, 12, ScreenWidth - 48, 23);
    lable.text = self.titleAry[section];
    if (section == 2 || section == 1) {
        lable.textColor = KBlack666TextColor;
        lable.font = DEFAULT_FONT_R(13);
        NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:self.titleAry[section]];
        NSRange range = NSMakeRange(0,5);
        [attributeMarket addAttribute:NSForegroundColorAttributeName value:KBlack333TextColor range:range];
        [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_M(15) range:range];
        lable.attributedText = attributeMarket;
    }
    [view addSubview:lable];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4) {
        if (self.isEdit) {
            return;
        }
        [self.view endEditing:YES];
        BRAddressPickerView *pickView = [[BRAddressPickerView alloc] initWithPickerMode:BRAddressPickerModeArea];
        pickView.resultBlock = ^(BRProvinceModel * _Nullable province, BRCityModel * _Nullable city, BRAreaModel * _Nullable area) {
            
            self.provinceModel = province;
            self.cityModel = city;
            self.areaModel = area;
            
            [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        }
        ;
        [pickView show];
    }
    if (indexPath.section == 0) {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        }];
        [cancle setValue:KBlack666TextColor forKey:@"titleTextColor"];

        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        [camera setValue:KBlack666TextColor forKey:@"titleTextColor"];
        UIAlertAction *picture = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
  
        }];
        [picture setValue:KBlack666TextColor forKey:@"titleTextColor"];
        [alertVc addAction:cancle];
        [alertVc addAction:camera];
        [alertVc addAction:picture];
        [self presentViewController:alertVc animated:YES completion:nil];
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
    UIImageView *headImgV = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"myshop_head")];
    headImgV.frame = CGRectMake(0, 0, ScreenWidth, 233*KScreenW_Ratio);
    headImgV.userInteractionEnabled = YES;
    self.tableView.tableHeaderView = headImgV;
    
    UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(0, 233*KScreenW_Ratio-12, ScreenWidth, 12)];
    whiteV.backgroundColor = KWhiteBGColor;
    [headImgV addSubview:whiteV];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:whiteV.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = whiteV.bounds;
    maskLayer.path = maskPath.CGPath;
    whiteV.layer.mask = maskLayer;
}

-(void)creatFooterView{
    UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 84)];
    footerV.backgroundColor = KWhiteBGColor;
    self.tableView.tableFooterView = footerV;
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"保存" Target:self Action:@selector(submitClick) Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    btn.frame = CGRectMake(12, 12, ScreenWidth - 24, 50);
    btn.layer.cornerRadius = 22;
    btn.clipsToBounds = YES;
    [footerV addSubview:btn];
}

@end




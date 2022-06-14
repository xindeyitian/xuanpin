//
//  mySetViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import "mySetViewController.h"
#import "mySetTableViewCell.h"
#import "mySetDataModel.h"
#import "LogOutAlertViewController.h"
#import "changeGenderViewController.h"
#import "changeNameViewController.h"
#import "BRDatePickerView.h"
#import "LoginViewController.h"
#import "myShimingViewController.h"
#import "WithdrawPasswordViewController.h"
#import "chatAlertViewController.h"
#import "CleanAlertViewController.h"
#import "ThirdBingDingViewController.h"
#import "SignOutAlertViewController.h"
#import "UpdateAlertViewController.h"
#import "MyInfoModel.h"

@interface mySetViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)MyInfoModel *myInfoModel;
@property (nonatomic , strong)mySetTableHeaderView *headView;
@property (nonatomic , copy)NSString *cacheStr;

@end

@implementation mySetViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getSetDataAryWithModel:[MyInfoModel new]];
    self.cacheStr = @"0B";
    [self getMyInfo];
    
    self.navigationController.delegate = self;
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = KViewBGColor;
    self.tableView.backgroundColor = KViewBGColor;
    [self.tableView registerClass:[mySetTableViewCell class] forCellReuseIdentifier:[mySetTableViewCell description]];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    self.headView = [[mySetTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 177)];
    self.tableView.backgroundColor = KViewBGColor;
    self.tableView.tableHeaderView = self.headView;
    CJWeakSelf()
    self.headView.uploadImageBlock = ^(NSString * _Nonnull url) {
        CJStrongSelf()
        self.myInfoModel.avatar = url;
        [self updateMyInfo];
    };
    
    UIView *footerView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 58 + (IS_IPHONEX_SERIE ? TabbarSafeBottomMargin : 20))];
    footerView.backgroundColor = KViewBGColor;
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"退出登录" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_M(17) BackgroundColor:kRGB(238, 238, 238) Color:KBlack666TextColor Frame:CGRectMake(12, 8, ScreenWidth - 24, 50) Alignment:NSTextAlignmentCenter Tag:1];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = KBlack999TextColor.CGColor;
    btn.layer.cornerRadius = 25;
    btn.clipsToBounds = YES;
    [footerView addSubview:btn];
    self.tableView.tableFooterView = footerView;
    
    self.needPullDownRefresh = YES;
    [self getCacheSizeWithFilePath];
}

- (void)loadNewData{
    [self getMyInfo];
}

- (void)getMyInfo{
    if (!self.tableView.mj_header.isRefreshing) {
        [self startLoadingHUD];
    }
    [THHttpManager GET:@"shop/shopUser/shopUserInfo" parameters:@{} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        [self.tableView.mj_header endRefreshing];
        if ([data isKindOfClass:[NSDictionary class]]) {
            MyInfoModel *model = [MyInfoModel mj_objectWithKeyValues:data];
            self.myInfoModel = model;
            [self.headView.userLogo sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:KPlaceholder_DefaultImage];
            [self getSetDataAryWithModel:model];
        }
    }];
}

- (void)updateMyInfo{
    [self startLoadingHUD];
    NSDictionary *dica = [self getParams];
    [THHttpManager FormatPOST:@"shop/shopUser/updateUser" parameters:dica dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200) {
            [XHToast dismiss];
            [self showSuccessMessageWithString:@"修改成功"];
            if (self.myInfoModel.avatar) {
                [AppTool saveToLocalDataWithValue:self.myInfoModel.avatar key:@"userLogo"];
            }
            [self getSetDataAryWithModel:self.myInfoModel];
        }
    }];
}

- (NSDictionary *)getParams{
    
    NSDictionary *dica = @{@"provinceCode":self.myInfoModel.provinceCode ? : @"",
                           @"provinceName":self.myInfoModel.provinceName ? : @"",
                           @"areaCode":self.myInfoModel.areaCode ? : @"",
                           @"areaName":self.myInfoModel.areaName ? : @"",
                           @"cityCode":self.myInfoModel.cityCode ? : @"",
                           @"cityName":self.myInfoModel.cityName ? : @"",
                           @"avatar":self.myInfoModel.avatar ? : @"",
                           @"birthDay":self.myInfoModel.birthDay ? : @"",
                           @"phoneNum":self.myInfoModel.phoneNum ? : @"",
                           @"realName":self.myInfoModel.realName ? : @"",
                           @"sex":self.myInfoModel.sex ? : @"0"
    };
    return dica;
}

- (void)btnClick{
    [AppTool cleanLocalToken];
    [AppTool cleanLocalDataInfo];
    SignOutAlertViewController *alertVC = [SignOutAlertViewController new];
    alertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self  presentViewController:alertVC animated:NO completion:nil];
}

#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataArray[section];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    mySetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[mySetTableViewCell description]];
    cell.autoCorner = 1;
    [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
    
    NSArray *array = self.dataArray[indexPath.section];
    cell.model = array[indexPath.row];
    if (indexPath.section == 2 && indexPath.row == 0) {
        cell.contentL.text = self.cacheStr;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
    view.backgroundColor = KViewBGColor;
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2 && indexPath.row == 4) {
        LogOutAlertViewController *alertVC = [LogOutAlertViewController new];
        alertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:alertVC animated:NO completion:nil];
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        //性别
        changeGenderViewController *alertVC = [changeGenderViewController new];
        alertVC.sex = self.myInfoModel.sex;
        alertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        alertVC.selectOperationBlock = ^(NSInteger index) {
            NSLog(@"===选择了%@",index == 0 ? @"男":@"女");
            self.myInfoModel.sex = [NSString stringWithFormat:@"%ld",index + 1];
            [self updateMyInfo];
        };
        [self  presentViewController:alertVC animated:NO completion:nil];
    }
    if (indexPath.section == 0 && indexPath.row == 4) {
        //生日
        [BRDatePickerView showDatePickerWithMode:BRDatePickerModeDate title:@"" selectValue:@"" resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
            self.myInfoModel.birthDay = selectValue;
            [self updateMyInfo];
        }];
    }
    if (indexPath.section == 0 && indexPath.row == 5) {
        if (self.myInfoModel.provinceName.length) {
            
        }else{
            [self.view endEditing:YES];
            BRAddressPickerView *pickView = [[BRAddressPickerView alloc] initWithPickerMode:BRAddressPickerModeArea];
            pickView.resultBlock = ^(BRProvinceModel * _Nullable province, BRCityModel * _Nullable city, BRAreaModel * _Nullable area) {
                
                self.myInfoModel.provinceName = province.name;
                self.myInfoModel.provinceCode = province.code;
                self.myInfoModel.cityName = city.name;
                self.myInfoModel.cityCode = city.code;
                self.myInfoModel.areaName = area.name;
                self.myInfoModel.areaCode = area.code;
                [self updateMyInfo];
            };
            [pickView show];
        }
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        changeNameViewController *alertVC = [changeNameViewController new];
        alertVC.nameStr = self.myInfoModel.realName;
        alertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        alertVC.viewBlock = ^(NSString * _Nonnull name) {
            self.myInfoModel.realName = name;
            [self updateMyInfo];
        };
        [self  presentViewController:alertVC animated:NO completion:nil];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        myShimingViewController *vc = [myShimingViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        WithdrawPasswordViewController *vc = [WithdrawPasswordViewController new];
        vc.isEdit = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 3) {
        chatAlertViewController *alertVC = [chatAlertViewController new];
        alertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        alertVC.phoneStr = self.myInfoModel.serviceTel;
        [self presentViewController:alertVC animated:NO completion:nil];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        CleanAlertViewController *alertVC = [CleanAlertViewController new];
        alertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        alertVC.viewBlock = ^{
            [self cleanAppCache];
        };
        [self  presentViewController:alertVC animated:NO completion:nil];
    }
    if (indexPath.section == 2 && indexPath.row == 3) {
        [self showSuccessMessageWithString:@"目前为最新版本！"];
        UpdateAlertViewController *alertVC = [UpdateAlertViewController new];
        alertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        ///[self  presentViewController:alertVC animated:NO completion:nil];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        ThirdBingDingViewController *vc = [ThirdBingDingViewController new];
        vc.bingdAli = self.myInfoModel.bindAli.integerValue;
        vc.bingWeichat = self.myInfoModel.bindWechat.integerValue;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        YinsiFuwuViewController * pvc = [[YinsiFuwuViewController alloc] init];
        pvc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:pvc animated:YES completion:nil];
    }
    if (indexPath.section == 2 && indexPath.row == 2) {
        YinsiFuwuViewController * pvc = [[YinsiFuwuViewController alloc] init];
        pvc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:pvc animated:YES completion:nil];
    }
}

- (void)getSetDataAryWithModel:(MyInfoModel *)infoModel{

    NSMutableArray *sectionOneAry = [NSMutableArray array];
    {
        mySetDataModel *model = [[mySetDataModel alloc]init];
        model.titleStr = @"ID";
        if (infoModel.userId) {
            model.detailStr = infoModel.userId;
        }
        model.hiddenRightImgV = YES;
        [sectionOneAry addObject:model];
    }
    {
        mySetDataModel *model = [[mySetDataModel alloc]init];
        model.titleStr = @"昵称";
        model.placerHolderStr = @"请输入";
        if (infoModel.realName) {
            model.detailStr = infoModel.realName;
        }
        [sectionOneAry addObject:model];
    }
    {
        mySetDataModel *model = [[mySetDataModel alloc]init];
        model.titleStr = @"手机号";
        if (infoModel.phoneNum) {
            model.detailStr = infoModel.phoneNum;
        }
        model.hiddenRightImgV = YES;
        [sectionOneAry addObject:model];
    }
    {
        mySetDataModel *model = [[mySetDataModel alloc]init];
        model.titleStr = @"性别";
        model.placerHolderStr = @"请选择";
        if (infoModel.sex && [infoModel.sex integerValue] != 0) {
            
            NSString *sex = @"";
            if ([infoModel.sex isEqualToString:@"0"]) {
                sex = @"";
            }
            if ([infoModel.sex isEqualToString:@"1"]) {
                sex = @"男";
            }
            if ([infoModel.sex isEqualToString:@"2"]) {
                sex = @"女";
            }
            model.detailStr = sex;
        }
        [sectionOneAry addObject:model];
    }
    {
        mySetDataModel *model = [[mySetDataModel alloc]init];
        model.titleStr = @"生日";
        model.placerHolderStr = @"请选择";
        if (infoModel.birthDay) {
            model.detailStr = infoModel.birthDay;
        }
        [sectionOneAry addObject:model];
    }
    {
        mySetDataModel *model = [[mySetDataModel alloc]init];
        model.titleStr = @"所在地";
        model.placerHolderStr = @"请选择";
        if (infoModel.provinceName) {
            model.detailStr = [NSString stringWithFormat:@"%@ %@ %@",infoModel.provinceName,infoModel.cityName,infoModel.areaName];
            model.hiddenRightImgV = YES;
        }
        [sectionOneAry addObject:model];
    }
    
    NSMutableArray *sectionTwoAry = [NSMutableArray array];
    {
        //是否实名 0未实名,1已实名,2待审核,-1审核不通过
        mySetDataModel *model = [[mySetDataModel alloc]init];
        model.titleStr = @"实名认证";
        if (infoModel.ifAuth.integerValue == 1) {
            model.detailStr = @"已认证";
            model.detailColor = KMaintextColor;
        }else{
            model.detailStr = @"未认证";
        }
        [sectionTwoAry addObject:model];
    }
    {
        mySetDataModel *model = [[mySetDataModel alloc]init];
        model.titleStr = @"绑定第三方提现账户";
        model.detailStr = @"";
        [sectionTwoAry addObject:model];
    }
    {
        mySetDataModel *model = [[mySetDataModel alloc]init];
        model.titleStr = @"修改提现密码";
        if (infoModel.isPassword.integerValue == 0) {
            model.titleStr = @"设置提现密码";
        }else{
            model.titleStr = @"修改提现密码";
        }
        model.detailStr = @"";
        [sectionTwoAry addObject:model];
    }
    {
        mySetDataModel *model = [[mySetDataModel alloc]init];
        model.titleStr = @"联系客服";
        if (infoModel.serviceTel) {
            model.detailStr = infoModel.serviceTel;
        }
        [sectionTwoAry addObject:model];
    }
    NSMutableArray *sectionthreeAry = [NSMutableArray array];
    {
        mySetDataModel *model = [[mySetDataModel alloc]init];
        model.titleStr = @"清除缓存";
        model.detailStr = self.cacheStr;
        [sectionthreeAry addObject:model];
    }
    {
        mySetDataModel *model = [[mySetDataModel alloc]init];
        model.titleStr = @"用户协议";
        model.detailStr = @"";
        [sectionthreeAry addObject:model];
    }
    {
        mySetDataModel *model = [[mySetDataModel alloc]init];
        model.titleStr = @"隐私协议";
        model.detailStr = @"";
        [sectionthreeAry addObject:model];
    }
    {
        mySetDataModel *model = [[mySetDataModel alloc]init];
        model.titleStr = @"当前版本";
        model.detailStr = @"1.0.0";
        [sectionthreeAry addObject:model];
    }
    {
        mySetDataModel *model = [[mySetDataModel alloc]init];
        model.titleStr = @"用户注销";
        model.detailStr = @"";
        [sectionthreeAry addObject:model];
    }
    self.dataArray = [NSMutableArray arrayWithObjects:sectionOneAry,sectionTwoAry,sectionthreeAry, nil];
    [self.tableView reloadData];
}

#pragma 计算缓存大小
- (void)getCacheSizeWithFilePath {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

      NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
      NSArray *subPathArr = [[NSFileManager defaultManager] subpathsAtPath:path];
      NSString *filePath  = nil;
      NSInteger totleSize = 0;
      for (NSString *subPath in subPathArr) {
          filePath =[path stringByAppendingPathComponent:subPath];
          BOOL isDirectory = NO;
          BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
          if (!isExist || isDirectory || [filePath containsString:@".DS"]) {
              continue;
          }
          NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
          NSInteger size = [dict[@"NSFileSize"] integerValue];
          totleSize += size;
      }
      NSString *totleStr = @"0B";
      if (totleSize > 1000 * 1000) {
          totleStr = [NSString stringWithFormat:@"%.2fM",totleSize / 1000.00f /1000.00f];
      } else if (totleSize > 1000) {
          totleStr = [NSString stringWithFormat:@"%.2fKB",totleSize / 1000.00f];
      } else {
          totleStr = [NSString stringWithFormat:@"%.0fB",totleSize / 1.00f];
      }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.cacheStr = totleStr;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:(UITableViewRowAnimationNone)];
        });
    });
}

#pragma 清除缓存
- (void)cleanAppCache {
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    //NSLog ( @"cachpath = %@" , cachePath);
    for ( NSString * p in files) {
        NSError * error = nil;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }
    self.cacheStr = @"0B";
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:(UITableViewRowAnimationNone)];
    [self showSuccessMessageWithString:@"缓存清理完成"];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    SetIOS13;
    [navigationController setNavigationBarHidden:NO animated:YES];
}

@end



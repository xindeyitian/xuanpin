//
//  MyOrderLogisticsViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/27.
//

#import "MyOrderLogisticsViewController.h"
#import "BaseCommentTableCell.h"
#import "MyOrderLogisticsTableViewCell.h"
#import "OrderLogistCompanyViewController.h"
#import "OrderListModel.h"
#import "BaseLeftFieldTableViewCell.h"
#import "OrderLogistProductViewController.h"
#import "MyOrderLogisticsDataModel.h"

@interface MyOrderLogisticsViewController ()

@property (nonatomic , strong)NSString *code;
@property (nonatomic , strong)NSString *company;
@property (nonatomic , strong)OrderLogistCompanyModel *selectModel;
@property (nonatomic , strong)NSMutableArray *leftDataAry;
@property (nonatomic , strong)NSMutableArray *rightPlaceholderAry;
@property (nonatomic , strong)NSMutableArray *selectDataAry;
@property (nonatomic , strong)NSMutableArray *allDataAry;
@property (nonatomic , strong)NSMutableArray *listDataAry;

@property (nonatomic , strong)UIButton *submitBtn;

@end

@implementation MyOrderLogisticsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"物流信息";
    
    self.company = @"中通快递";
    self.code = @"2345678923456";
    
    self.view.backgroundColor = self.tableView.backgroundColor = KBGLightColor;
    [self.tableView registerClass:[BaseLeftFieldTableViewCell class] forCellReuseIdentifier:[BaseLeftFieldTableViewCell description]];
    
    self.leftDataAry = [NSMutableArray arrayWithObjects:@"发货方式",@"快递公司",@"快递单号",@"选择发货商品", nil];
    self.rightPlaceholderAry =  [NSMutableArray arrayWithObjects:@"请选择",@"请输入快递单号",@"请选择", nil];
    
    self.allDataAry = [NSMutableArray arrayWithObject:@"1"];
    self.listDataAry = [NSMutableArray array];
    [self addNewData];

    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 66 - TabbarSafeBottomMargin - KNavBarHeight, ScreenWidth, 66+TabbarSafeBottomMargin)];
    bottomV.backgroundColor = KBGLightColor;
    [self.view addSubview:bottomV];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.equalTo(self.view).offset(KNavBarHeight);
        }
        make.bottom.mas_equalTo(bottomV.mas_top).offset(-5);
        make.left.right.equalTo(self.view);
    }];
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"发货" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_M(17) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
    btn.frame = CGRectMake(12, 5, ScreenWidth - 24, 50);
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 25;
    [bottomV addSubview:btn];
    self.submitBtn = btn;
    self.submitBtn.alpha = 0.5;
    self.submitBtn.userInteractionEnabled = NO;
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 33)];
    header.backgroundColor = KBGLightColor;
    self.tableView.tableHeaderView = header;
    
    UILabel *title = [UILabel creatLabelWithTitle:@"填写物流信息" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
    [header addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(header).offset(12);
        make.right.mas_equalTo(header).offset(-12);
        make.left.mas_equalTo(header).offset(12);
        make.height.mas_equalTo(21);
    }];
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 51)];
    footer.backgroundColor = KBGLightColor;
    self.tableView.tableFooterView = footer;
    BaseButton *addBtn = [BaseButton CreateBaseButtonTitle:@"添加物流信息" Target:self Action:@selector(addBtnClick) Font:DEFAULT_FONT_R(13) BackgroundColor:UIColor.clearColor Color:KMaintextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
    addBtn.frame = CGRectMake(ScreenWidth/2.0 - 50, 21, 100, 20);
    [footer addSubview:addBtn];
}

- (void)addNewData{
    MyOrderLogisticsDataModel *model = [[MyOrderLogisticsDataModel alloc]init];
    model.compantName = @"";
    model.productList = [@[] mutableCopy];
    model.companyModel = [[OrderLogistCompanyModel alloc]init];
    model.logistNO = @"";
    [self.listDataAry addObject:model];
}

- (void)addBtnClick{
    [self.allDataAry addObject:@"1"];
    [self addNewData];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.allDataAry.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseLeftFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseLeftFieldTableViewCell description]];
    cell.contentView.backgroundColor = KBGLightColor;
    cell.bgView.backgroundColor = KWhiteBGColor;
    cell.leftL.text = self.leftDataAry[indexPath.row];
    cell.rightImgV.image = IMAGE_NAMED(@"my_right_gray");
    cell.fieldT.textAlignment = NSTextAlignmentRight;
    cell.autoCorner = YES;
    [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.fieldT.text = @"快递配送";
        cell.fieldT.userInteractionEnabled = NO;
        cell.havRightImgV = NO;
    }else{
        cell.havRightImgV = !(indexPath.row == 2);
        cell.fieldT.text = self.selectDataAry[indexPath.row];
        cell.fieldT.placeholder = self.rightPlaceholderAry[indexPath.row-1];
        MyOrderLogisticsDataModel *model = self.listDataAry[indexPath.section];
        if (model.productList.count && indexPath.row == 3) {
            cell.fieldT.text = [NSString stringWithFormat:@"已选择%ld件商品",model.productList.count];
        }
        if (model.compantName.length && indexPath.row == 1) {
            cell.fieldT.text = [NSString stringWithFormat:@"%@",model.compantName];
        }
        if (model.logistNO.length && indexPath.row == 2) {
            cell.fieldT.text = [NSString stringWithFormat:@"%@",model.logistNO];
        }
        if (indexPath.row == 2) {
            cell.viewBlock = ^(NSString * _Nonnull content) {
                model.logistNO = content;
                [self judgeIsComplete];
            };
        }
    }
    return cell;
}

- (void)judgeIsComplete{
    BOOL haveComplete = NO;
    for (MyOrderLogisticsDataModel *model in self.listDataAry) {
        if (model.productList.count && model.compantName.length && model.logistNO.length) {
            haveComplete = YES;
        }
    }
    self.submitBtn.alpha = haveComplete ? 1 : 0.5;
    self.submitBtn.userInteractionEnabled = haveComplete;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        OrderLogistCompanyViewController *vc = [[OrderLogistCompanyViewController alloc]init];
        vc.selectBlock = ^(OrderLogistCompanyModel * _Nonnull model) {
            [self judgeIsComplete];
            MyOrderLogisticsDataModel *listModel = self.listDataAry[indexPath.section];
            listModel.compantName = model.companyName;
            listModel.companyModel = model;
            [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 3) {
        OrderLogistProductViewController *vc = [[OrderLogistProductViewController alloc]init];
        vc.productAry = self.productAry;
        vc.allListAry = self.listDataAry;
        vc.section = indexPath.section;
        vc.selectBlock = ^(NSMutableArray * _Nonnull productAry) {
            [self judgeIsComplete];
            MyOrderLogisticsDataModel *listModel = self.listDataAry[indexPath.section];
            listModel.productList = productAry;
            [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 12;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
    view.backgroundColor = UIColor.clearColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.01)];
    return view;
}

- (void)btnClick{
    [self startLoadingHUD];
    
    NSMutableArray *list = [NSMutableArray array];
    for (MyOrderLogisticsDataModel *dataModel in self.listDataAry) {
        
        if (dataModel.compantName.length && dataModel.logistNO.length && dataModel.productList.count) {
            NSMutableArray *idItems = [NSMutableArray array];
            for (OrderListProductModel *model in dataModel.productList) {
                [idItems addObject:model.djlsh];
            }
            NSDictionary *dica = @{@"expressCode":dataModel.companyModel.companyCode,
                                   @"expressComp":dataModel.compantName,
                                   @"expressNo":dataModel.logistNO,
                                   @"itemIds":idItems,
            };
            [list addObject:dica];
        }
    }
    [THHttpManager POST:@"goods/orderInfo/deliverySelfGoods" parameters:@{@"orderId":self.orderID,@"expressInfoList":list} dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200) {
            [self showSuccessMessageWithString:@"订单发货成功"];
            if (_successBlock) {
                _successBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SetIOS13;
    [navigationController setNavigationBarHidden:NO animated:YES];
}

@end

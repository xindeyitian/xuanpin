//
//  myOrderShouHouProgressViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/26.
//

#import "myOrderShouHouProgressViewController.h"
#import "myOrderDetailProductTableViewCell.h"
#import "orderDataModel.h"
#import "myOrderDetailHeaderView.h"
#import "BaseOwnerNavView.h"

@interface myOrderShouHouProgressViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation myOrderShouHouProgressViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getDataAry];
    self.navigationController.delegate = self;
    self.navigationItem.title = @"售后进度";
    self.view.backgroundColor = KBGColor;
    self.tableView.backgroundColor = KBGColor;
    [self.tableView registerClass:[myOrderDetailProductTableViewCell class] forCellReuseIdentifier:[myOrderDetailProductTableViewCell description]];
    [self.tableView registerClass:[myOrderDetailCommentTableViewCell class] forCellReuseIdentifier:[myOrderDetailCommentTableViewCell description]];
    [self.tableView registerClass:[myOrderDetailChatTableViewCell class] forCellReuseIdentifier:[myOrderDetailChatTableViewCell description]];
    [self.tableView registerClass:[myOrderDetailShouhouTableViewCell class] forCellReuseIdentifier:[myOrderDetailShouhouTableViewCell description]];
    
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 115+12+12)];
    headerV.backgroundColor = KBGColor;
    
    UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(12, 12, ScreenWidth - 24, 115)];
    whiteV.backgroundColor = KWhiteBGColor;
    whiteV.layer.cornerRadius = 8;
    whiteV.clipsToBounds = YES;
    [headerV addSubview:whiteV];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"售后进度" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(15)];
    [whiteV addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(whiteV).offset(12);
        make.right.mas_equalTo(whiteV).offset(-12);
        make.left.mas_equalTo(whiteV).offset(12);
        make.height.mas_equalTo(24);
    }];
    
    //退款进度   买家申请  商家确认   售后完成
    //退货退款进度
    NSArray *array = @[@"买家申请",@"商家确认",@"买家寄回",@"商家收货",@"售后完成"];
    float oneWidth = (ScreenWidth - 24 - 24 - array.count*5 - 5)/array.count;
    NSInteger num = 2;
    
    float start = .0f;
    float end = .0f;
    for (int i =0; i < array.count; i ++) {
        UILabel *title = [UILabel creatLabelWithTitle:array[i] textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(13)];
        title.frame = CGRectMake(12+(oneWidth +5)*i, 82, oneWidth, 21);
        [whiteV addSubview:title];
        
        UIView *cycleV = [[UIView alloc]initWithFrame:CGRectMake(0, 63, 11, 11)];
        cycleV.clipsToBounds = YES;
        cycleV.layer.cornerRadius = 5.5;
        [whiteV addSubview:cycleV];
        cycleV.backgroundColor = KWhiteBGColor;
        cycleV.layer.borderColor = KMainBGColor.CGColor;
        cycleV.layer.borderWidth = 1;
        cycleV.centerX = title.centerX;
        if (i == 0) {
            start = cycleV.frame.origin.x;
        }
        if (i == array.count - 1) {
            end = cycleV.frame.origin.x;
        }
        if (i < num) {
            cycleV.backgroundColor = KMainBGColor;
            title.textColor = KMainBGColor;
        }
    }
    UIView *linV = [[UIView alloc]initWithFrame:CGRectMake(start, 68, end - start, 1)];
    linV.backgroundColor = KMainBGColor;
    [whiteV addSubview:linV];
    [whiteV sendSubviewToBack:linV];
    
    self.tableView.tableHeaderView = headerV;
}

#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }
    NSArray *sectionAry = self.dataArray[section - 1];
    return sectionAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 120;
    }
    NSArray *sectionAry = self.dataArray[indexPath.section - 1];
    orderDataModel *model = sectionAry[indexPath.row];
    if (model.type ==1) {
        return UITableViewAutomaticDimension;
    }
    return model.rowHeight ? : 42;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        myOrderDetailProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[myOrderDetailProductTableViewCell description]];
        cell.autoCorner = 1;
        [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
        return cell;
    }
    NSArray *sectionAry = self.dataArray[indexPath.section - 1];
    orderDataModel *model = sectionAry[indexPath.row];
    if (model.type == 1) {
        myOrderDetailShouhouTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[myOrderDetailShouhouTableViewCell description]];
        cell.autoCorner = 1;
        [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
        cell.dataModel = model;
        return cell;
    }
    if (model.type == 2) {
        myOrderDetailChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[myOrderDetailChatTableViewCell description]];
        cell.autoCorner = 1;
        [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
        return cell;
    }
    myOrderDetailCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[myOrderDetailCommentTableViewCell description]];
    cell.autoCorner = 1;
    [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
    cell.dataModel = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)getDataAry{
    self.dataArray = [NSMutableArray array];
    
    NSMutableArray *sectionAry = [NSMutableArray array];{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"退款信息";
        model.leftFont = DEFAULT_FONT_M(15);
        model.detailStr = @"";
        [sectionAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"退款原因";
        model.detailStr = @"我不想要了";
        model.rightFont = DEFAULT_FONT_R(15);
        model.rightColor = KBlack666TextColor;
        [sectionAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"退款金额";
        model.detailStr = @"¥199";
        model.rightFont = DIN_Medium_FONT_R(15);
        model.rightColor = KMaintextColor;
        [sectionAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"申请时间";
        model.detailStr = @"2020.04.05 14:00";
        model.rightFont = DEFAULT_FONT_R(15);
        model.rightColor = KBlack666TextColor;
        [sectionAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"售后单号";
        model.detailStr = @"45574676354736";
        model.rightFont = DEFAULT_FONT_R(15);
        model.rightColor = KBlack666TextColor;
        [sectionAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"售后单号";
        model.detailStr = @"45574676354736";
        model.rightFont = DEFAULT_FONT_R(15);
        model.rightColor = KBlack666TextColor;
        model.showLineV = YES;
        model.rowHeight = 50;
        [sectionAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"补充描述和凭证";
        model.detailStr = @"";
        model.leftFont = DEFAULT_FONT_M(15);
        model.rowHeight = 47;
        [sectionAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"";
        model.detailStr = @"";
        model.type = 1;
        NSArray *array = @[@"1",@"2",@"3",@"4"];
        model.propertyData = @"物流太慢，质量差物流太慢，质量差物流太慢，质量差物流太慢，质量差物流太慢，质量差";
        model.propertyDatAry = array;
        [sectionAry addObject:model];
    }
    
    NSMutableArray *sectionOneAry = [NSMutableArray array];{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"商品总价";
        model.detailStr = @"¥198";
        model.rightFont = DIN_Medium_FONT_R(15);
        model.rightColor = KBlack333TextColor;
        [sectionOneAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"运费";
        model.detailStr = @"¥1";
        model.rightFont = DIN_Medium_FONT_R(15);
        model.rightColor = KBlack333TextColor;
        [sectionOneAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"订单总价";
        model.detailStr = @"¥199";
        model.rightFont = DIN_Medium_FONT_R(15);
        model.rightColor = KBlack333TextColor;
        model.showLineV = YES;
        [sectionOneAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"积分总额";
        model.detailStr = @"199";
        model.rightFont = DIN_Medium_FONT_R(18);
        model.rightColor = KMaintextColor;
        model.rowHeight = 50;
        [sectionOneAry addObject:model];
    }
    /**
     待付款  订单信息 订单编号 下单时间
     待发货  订单信息 订单编号 下单时间 付款时间
     已发货  订单信息 订单编号 下单时间 付款时间 发货时间
     已完成  订单信息 订单编号 下单时间 付款时间 发货时间 成交时间
     已取消  订单信息 订单编号 下单时间 取消时间
     售后    订单信息 订单编号 下单时间 付款时间 发货时间 成交时间
     */
    NSMutableArray *sectionTwoAry = [NSMutableArray array];{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"订单信息";
        model.leftFont = DEFAULT_FONT_M(15);
        model.detailStr = @"";
        [sectionTwoAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"订单编号";
        model.detailStr = @"472837436573645";
        model.rightFont = DEFAULT_FONT_R(15);
        model.rightColor = KBlack666TextColor;
        model.showCopy = YES;
        [sectionTwoAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"下单时间";
        model.detailStr = @"2020.04.05 14:00";
        model.rightFont = DEFAULT_FONT_R(15);
        model.rightColor = KBlack666TextColor;
        [sectionTwoAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"付款时间";
        model.detailStr = @"2020.04.05 14:00";
        model.rightFont = DEFAULT_FONT_R(15);
        model.rightColor = KBlack666TextColor;
        [sectionTwoAry addObject:model];
    }
//    {
//        orderDataModel *model = [[orderDataModel alloc]init];
//        model.titleStr = @"发货时间";
//        model.detailStr = @"2020.04.05 14:00";
//        model.rightFont = DEFAULT_FONT_R(15);
//        model.rightColor = KBlack666TextColor;
//        [sectionTwoAry addObject:model];
//    }{
//        orderDataModel *model = [[orderDataModel alloc]init];
//        model.titleStr = @"成交时间";
//        model.detailStr = @"2020.04.05 14:00";
//        model.rightFont = DEFAULT_FONT_R(15);
//        model.rightColor = KBlack666TextColor;
//        model.showLineV = YES;
//        [sectionTwoAry addObject:model];
//    }
    {
        orderDataModel *model = [[orderDataModel alloc]init];
        model.type = 2;
        model.rowHeight = 50;
        [sectionTwoAry addObject:model];
    }
    [self.dataArray addObject:sectionAry];
    [self.dataArray addObject:sectionOneAry];
    [self.dataArray addObject:sectionTwoAry];
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
    view.backgroundColor = KBGColor;
    return view;
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




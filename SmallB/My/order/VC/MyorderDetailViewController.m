//
//  MyorderDetailViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/12.
//

#import "MyorderDetailViewController.h"
#import "myOrderDetailProductTableViewCell.h"
#import "orderDataModel.h"
#import "myOrderDetailHeaderView.h"
#import "BaseOwnerNavView.h"
#import "OrderListModel.h"
#import "OrderAlertViewController.h"
#import "MyOrderLogisticsViewController.h"

@interface MyorderDetailViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong)UIView *bottomView;
@property (nonatomic , strong)OrderDetailModel *detailModel;
@property (nonatomic , strong)BaseOwnerNavView *navView ;

@end

@implementation MyorderDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelSuccess) name:@"cancelSuccess" object:nil];
    self.detailModel = [[OrderDetailModel alloc]init];
    [self getDataAry];
    self.navigationController.delegate = self;
    self.navigationItem.title = @"订单详情";
    self.view.backgroundColor = KBGColor;
    self.tableView.backgroundColor = KBGColor;
    [self.tableView registerClass:[myOrderDetailProductTableViewCell class] forCellReuseIdentifier:[myOrderDetailProductTableViewCell description]];
    [self.tableView registerClass:[myOrderDetailCommentTableViewCell class] forCellReuseIdentifier:[myOrderDetailCommentTableViewCell description]];
    [self.tableView registerClass:[myOrderDetailChatTableViewCell class] forCellReuseIdentifier:[myOrderDetailChatTableViewCell description]];
    [self.tableView registerClass:[myOrderDetailShouhouTableViewCell class] forCellReuseIdentifier:[myOrderDetailShouhouTableViewCell description]];
    
    BaseOwnerNavView *view = [[BaseOwnerNavView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight)];
    view.image = IMAGE_NAMED(@"order_navbar");
    view.titleL.text = @"订单详情";
    view.titleL.textColor = KWhiteTextColor;
    if (self.isShouHou) {
        view.titleL.textColor = KBlack333TextColor;
        [view.backBtn setImage:IMAGE_NAMED(@"back") forState:UIControlStateNormal];
        view.image = KPlaceholder_DefaultImage;
        view.backgroundColor = KWhiteBGColor;
        view.titleL.text = @"售后进度";
    }
    [self.view addSubview:view];
    self.navView =view;
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    self.needPullDownRefresh = YES;
    
    if (self.isShouHou) {
        [self creatShouHouHeaderView];
    }else{
        //[self creatNoramlHeaderView];
    }
    [self getOrderDetail];
}

- (void)cancelSuccess{
    [self getOrderDetail];
}

- (void)loadNewData{
    [self getOrderDetail];
}

- (void)getOrderDetail{
    if (!self.tableView.mj_header.isRefreshing) {
        [self startLoadingHUD];
    }
    [THHttpManager GET:@"goods/orderInfo/get" parameters:@{@"orderId":self.orderID,@"orderType":[NSString stringWithFormat:@"%ld",self.type]} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_header endRefreshing];
            self.detailModel = [OrderDetailModel mj_objectWithKeyValues:data];
            [self getDataAry];
            [self.tableView reloadData];
            [self creatNoramlHeaderView];
            
            NSInteger status = self.detailModel.orderState.integerValue;
            if (self.type == 2 && status == 2) {
                [self creatBottomView];
                [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.navView.mas_bottom);
                    make.left.right.equalTo(self.view);
                    make.bottom.equalTo(self.bottomView.mas_top).offset(-5);
                }];
            }else{
                [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.navView.mas_bottom);
                    make.left.right.bottom.equalTo(self.view);
                }];
            }
        }
    }];
}

- (void)creatBottomView{
    self.bottomView = [[UIView alloc]init];
    self.bottomView.backgroundColor = KWhiteBGColor;
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(TabbarSafeBottomMargin + 50);
    }];
    
    //取消订单  发货
    BaseButton *right = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(bottomBtnClick:) Font:DEFAULT_FONT_R(13) BackgroundColor:KWhiteBGColor Color:KMaintextColor Frame:CGRectMake(ScreenWidth - 109 - 12, 12, 109, 27) Alignment:NSTextAlignmentCenter Tag:4];
    right.clipsToBounds = YES;
    right.layer.cornerRadius = 13.5;
    [self.bottomView addSubview:right];
    
    BaseButton *left = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(bottomBtnClick:) Font:DEFAULT_FONT_R(13) BackgroundColor:KWhiteBGColor Color:KMaintextColor Frame:CGRectMake(ScreenWidth - 251, 12, 122, 27) Alignment:NSTextAlignmentCenter Tag:3];
    left.clipsToBounds = YES;
    left.layer.cornerRadius = 13.5;
    [self.bottomView addSubview:left];
    
    right.layer.borderColor = KMainBGColor.CGColor;
    right.layer.borderWidth = 1;
    
    left.layer.borderColor = KMainBGColor.CGColor;
    left.layer.borderWidth = 1;
    
    //不同意退款   同意退款
    //不同意退款/退货   同意退款/退货
    [right setTitle:@"不同意退款/退货" forState:UIControlStateNormal];
    [left setTitle:@"同意退款/退货" forState:UIControlStateNormal];
  
    //确认收货
    left.hidden = YES;
    right.frame = CGRectMake(ScreenWidth - 76 - 12, 12, 76, 27);
    [right setTitle:@"确认收货" forState:UIControlStateNormal];
    
    //取消订单  发货
    left.hidden = NO;
    right.frame = CGRectMake(ScreenWidth - 50 - 12, 12, 50, 27);
    [right setTitle:@"发货" forState:UIControlStateNormal];
    left.frame = CGRectMake(ScreenWidth - 150, 12, 76, 27);
    [left setTitle:@"取消订单" forState:UIControlStateNormal];
    [left setTitleColor:KBlack999TextColor forState:UIControlStateNormal];
    left.layer.borderColor = KBlack999TextColor.CGColor;
}

- (void)bottomBtnClick:(BaseButton *)btn{
    // 订单状态（1待支付默认，2待发货、3待收货，9完成，-1客户取消、-2管理员取消、-6订单超时未支付取消、-7行云订单生成失败取消
    NSInteger orderStatus = self.detailModel.orderState.integerValue;
    if (btn.tag == 3) {
        if (orderStatus == 2) {
            OrderAlertViewController *vc = [[OrderAlertViewController alloc]init];
            vc.alertType = orderAlertType_CancelOrder;
            vc.orderID = self.orderID;
            vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [[AppTool currentVC]  presentViewController:vc animated:NO completion:nil];
        }
    }
    if (btn.tag == 4) {
        if (orderStatus == 2) {
            MyOrderLogisticsViewController *vc = [[MyOrderLogisticsViewController alloc]init];
            vc.haveBottom = YES;
            vc.orderID = self.orderID;
            vc.productAry = self.detailModel.orderGoodsListVo;
            [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)creatShouHouHeaderView{
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

-(void)creatNoramlHeaderView{
    BOOL seeWuliu = NO;
    BOOL haveBtn = NO;
    NSString *address = @"-";
    if (self.detailModel.deliveryAddress) {
        address = self.detailModel.deliveryAddress;
        NSInteger orderState = self.detailModel.orderState.integerValue;
        if (orderState == 3 || orderState == 9) {
            seeWuliu = YES;
        }
    }
    seeWuliu = NO;
    float height = [address sizeWithLabelWidth:ScreenWidth - 55 - 24 font:DEFAULT_FONT_R(13)].height;
    
    myOrderDetailHeaderView *headView = [[myOrderDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 98+(76+height)+(seeWuliu?64:0) + (haveBtn ? 47 : 0))];
    headView.haveBtn = haveBtn;
    headView.showWuliu = seeWuliu;
    headView.addressStr = address;
    if (self.detailModel.deliveryAddress) {
        headView.detailModel = self.detailModel;
    }
    self.tableView.tableHeaderView = headView;
}

#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.detailModel.deliveryAddress) {
            return self.detailModel.orderGoodsListVo.count;
        }
        return 0;
    }
    NSArray *sectionAry = self.dataArray[section - 1];
    return sectionAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        //1 云仓 2自营
        return  self.type == 1 ?  120 : 96;
    }
    NSArray *sectionAry = self.dataArray[indexPath.section - 1];
    orderDataModel *model = sectionAry[indexPath.row];
    if (model.type ==1 || model.type == 3) {
        return UITableViewAutomaticDimension;
    }
    return model.rowHeight ? : 42;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        myOrderDetailProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[myOrderDetailProductTableViewCell description]];
        cell.autoCorner = 1;
        [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
        cell.type = self.type;
        if (self.detailModel.orderGoodsListVo.count) {
            cell.model = self.detailModel.orderGoodsListVo[indexPath.row];
        }
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
    
    NSMutableArray *shopAry = [NSMutableArray array];
    //商家操作
    {
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"商家处理";
        model.leftFont = DEFAULT_FONT_M(15);
        model.detailStr = @"";
        [shopAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"商家操作";
        model.detailStr = @"不同意";
        model.rightFont = DEFAULT_FONT_R(15);
        model.rightColor = KBlack666TextColor;
        model.type = 3;
        [shopAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"操作时间";
        model.detailStr = @"2020.04.05 14:00";
        model.rightFont = DEFAULT_FONT_R(15);
        model.rightColor = KBlack666TextColor;
        model.showLineV = YES;
        model.rowHeight = 47;
        [shopAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"备注";
        model.detailStr = @"";
        model.leftFont = DEFAULT_FONT_M(15);
        [shopAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"";
        model.detailStr = @"";
        model.type = 1;
        NSArray *array = @[@"1",@"2",@"3",@"4"];
        model.propertyData = @"就是不同意就是不同意就是不同意就是不同意就是不同意就是不同意就是不同意就是不同意就是不同";
        model.propertyDatAry = array;
        [shopAry addObject:model];
    }
    
    NSMutableArray *sectionAry = [NSMutableArray array];
    //退款信息
    //退款退货信息
    {
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"退款信息";
        model.leftFont = DEFAULT_FONT_M(15);
        model.detailStr = @"";
        [sectionAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"退款原因";
        model.detailStr = @"我不想要了我不想要了我不想要了我不想要了我不想要了我不想要了我不想要了我不想要了我不想要了我不想";
        model.rightFont = DEFAULT_FONT_R(15);
        model.rightColor = KBlack666TextColor;
        model.type = 3;
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
        model.showLineV = YES;
        model.rowHeight = 47;
        [sectionAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"补充描述和凭证";
        model.detailStr = @"";
        model.leftFont = DEFAULT_FONT_M(15);
        [sectionAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"";
        model.detailStr = @"";
        model.type = 1;
        NSArray *array = @[@"1",@"2",@"3",@"4"];
        model.propertyData = @"物流太慢，质量差物流太慢，质量差物流太慢，质量差物流太慢，质量差物流太慢，质量差物流太慢，质量差物流太慢，质量差物流太慢，质量差物流太慢，质量差物流太慢，质量差物流太慢";
        model.propertyDatAry = array;
        [sectionAry addObject:model];
    }
    
    NSMutableArray *sectionOneAry = [NSMutableArray array];{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"商品总价";
        if (self.detailModel.totalMoneySale) {
            model.detailStr = [NSString stringWithFormat:@"¥%@",self.detailModel.totalMoneySale];
        }
        model.rightFont = DIN_Medium_FONT_R(15);
        model.rightColor = KBlack333TextColor;
        [sectionOneAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"运费";
        if (self.detailModel.expressFee) {
            model.detailStr = [NSString stringWithFormat:@"¥%@",self.detailModel.expressFee];
        }
        model.rightFont = DIN_Medium_FONT_R(15);
        model.rightColor = KBlack333TextColor;
        [sectionOneAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"订单总价";
        if (self.detailModel.totalMoneyPayed) {
            model.detailStr = [NSString stringWithFormat:@"¥%@",self.detailModel.totalMoneyPayed];
        }
        model.rightFont = DIN_Medium_FONT_R(15);
        model.rightColor = KBlack333TextColor;
        model.showLineV = YES;
        [sectionOneAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"积分总额";
        model.detailStr = @"-";
        if (self.detailModel.totalMoneyAgent) {
            model.detailStr = [NSString stringWithFormat:@"%@",self.detailModel.totalMoneyAgent];
        }
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
        if (self.detailModel.orderNo) {
            model.detailStr = self.detailModel.orderNo;
        }
        model.rightFont = DEFAULT_FONT_R(15);
        model.rightColor = KBlack666TextColor;
        model.showCopy = YES;
        [sectionTwoAry addObject:model];
    }{
        orderDataModel *model = [[orderDataModel alloc]init];
        model.titleStr = @"下单时间";
        if (self.detailModel.orderTime) {
            model.detailStr = self.detailModel.orderTime;
        }
        model.rightFont = DEFAULT_FONT_R(15);
        model.rightColor = KBlack666TextColor;
        [sectionTwoAry addObject:model];
    }
    orderDataModel *cancelModel = [[orderDataModel alloc]init];
    cancelModel.titleStr = @"取消时间";
    cancelModel.rightFont = DEFAULT_FONT_R(15);
    cancelModel.rightColor = KBlack666TextColor;
    if (self.detailModel.cancelTime) {
        cancelModel.detailStr = self.detailModel.cancelTime;
    }
    
    orderDataModel *payModel = [[orderDataModel alloc]init];
    payModel.titleStr = @"付款时间";
    if (self.detailModel.payTime) {
        payModel.detailStr = self.detailModel.payTime;
    }
    payModel.rightFont = DEFAULT_FONT_R(15);
    payModel.rightColor = KBlack666TextColor;


    orderDataModel *fahuoModel = [[orderDataModel alloc]init];
    fahuoModel.titleStr = @"发货时间";
    fahuoModel.detailStr = @"-";
    if (self.detailModel.deliveryDate) {
        fahuoModel.detailStr = self.detailModel.deliveryDate;
    }
    fahuoModel.rightFont = DEFAULT_FONT_R(15);
    fahuoModel.rightColor = KBlack666TextColor;
    
    orderDataModel *dealModel = [[orderDataModel alloc]init];
    dealModel.titleStr = @"成交时间";
    dealModel.detailStr = @"-";
    if (self.detailModel.recvRime) {
        dealModel.detailStr = self.detailModel.recvRime;
    }
    dealModel.rightFont = DEFAULT_FONT_R(15);
    dealModel.rightColor = KBlack666TextColor;
    dealModel.showLineV = YES;
    
    /*待付款  订单信息 订单编号 下单时间
    待发货  订单信息 订单编号 下单时间 付款时间
    已发货  订单信息 订单编号 下单时间 付款时间 发货时间
    已完成  订单信息 订单编号 下单时间 付款时间 发货时间 成交时间
    已取消  订单信息 订单编号 下单时间 取消时间
    售后    订单信息 订单编号 下单时间 付款时间 发货时间 成交时间*/
    
    NSString *statusS = @"";
    switch (self.detailModel.orderState.integerValue) {
        case 1:{
            statusS = @"待买家付款";
        }
            break;
        case 2:{
            statusS = @"待发货";
            [sectionTwoAry addObject:payModel];
        }
            break;
        case 3:{
            statusS = @"卖家已发货";
            [sectionTwoAry addObject:payModel];
            [sectionTwoAry addObject:fahuoModel];
        }
            break;
        case 9:{
            statusS = @"已完成";
            [sectionTwoAry addObject:payModel];
            [sectionTwoAry addObject:fahuoModel];
            [sectionTwoAry addObject:dealModel];
        }
            break;
        case -1:
        case -2:
        case -6:
        case -7:{
            statusS = @"已取消";
            [sectionTwoAry addObject:cancelModel];
        }
            break;
        default:
            break;
    }
    {
        orderDataModel *model = [[orderDataModel alloc]init];
        model.type = 2;
        model.rowHeight = 50;
        [sectionTwoAry addObject:model];
    }
    if (self.isShouHou) {
        [self.dataArray addObject:shopAry];
        [self.dataArray addObject:sectionAry];
    }
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
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}

@end




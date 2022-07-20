//
//  OrderLogistedListDetailViewController.m
//  SmallB
//
//  Created by zhang on 2022/7/7.
//

#import "OrderLogistedListDetailViewController.h"
#import "OrderLogistDetailTableViewCell.h"
#import "myOrderDetailHeaderView.h"
#import "BaseOwnerNavView.h"

@interface OrderLogistedListDetailViewController ()

@end

@implementation OrderLogistedListDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate =self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"物流信息";
    self.view.backgroundColor = KBGLightColor;
    [self.tableView registerClass:[OrderLogistDetailTableViewCell class] forCellReuseIdentifier:[OrderLogistDetailTableViewCell description]];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(KNavBarHeight);
    }];
    
    BaseOwnerNavView *nav = [[BaseOwnerNavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight)];
    nav.backgroundColor = KMainBGColor;
    nav.titleL.text = @"物流信息";
    nav.titleL.textColor = KWhiteTextColor;
    [self.view addSubview:nav];
    
    BOOL seeWuliu = NO;
    BOOL haveBtn = NO;

    float height = [self.detailModel.deliveryAddress sizeWithLabelWidth:ScreenWidth - 55 - 24 font:DEFAULT_FONT_R(13)].height;
    myOrderDetailHeaderView *headView = [[myOrderDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 76+height)];
    headView.haveBtn = haveBtn;
    headView.showWuliu = seeWuliu;
    headView.addressStr = @"";
    headView.hiddenTopStatus = YES;
    headView.detailModel = self.detailModel;
    self.tableView.tableHeaderView = headView;
    
    [self getData];
}

- (void)getData{
    [THHttpManager GET:@"goods/orderInfo/getOrderExpressLog" parameters:@{@"orderId":self.orderID} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderLogistDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[OrderLogistDetailTableViewCell description]];
    BOOL isFirst = indexPath.section == 0;
    BOOL isLast = indexPath.section == 4;
    if (isFirst && isLast) {
        cell.topLineView.hidden = cell.bottomLineView.hidden = YES;
    }else{
        if (isFirst) {
            cell.topLineView.hidden = YES;
        }
        if (isLast) {
            cell.bottomLineView.hidden = YES;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
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

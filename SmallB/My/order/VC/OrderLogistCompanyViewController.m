//
//  OrderLogistCompanyViewController.m
//  SmallB
//
//  Created by zhang on 2022/7/6.
//

#import "OrderLogistCompanyViewController.h"
#import "BaseSearchView.h"
#import "THBaseTableViewController.h"

@interface OrderLogistCompanyViewController ()

@end

@implementation OrderLogistCompanyViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCompanyList];
    self.view.backgroundColor = KWhiteBGColor;
    self.tableView.backgroundColor = KWhiteBGColor;
    
    UIView *navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, KNavBarHeight)];
    navBar.backgroundColor = KWhiteBGColor;
    [self.view addSubview:navBar];
    
    BaseSearchView *searchV = [[BaseSearchView alloc] initWithFrame:CGRectMake(0,KStatusBarHeight + 2 , ScreenWidth , 40)];
    searchV.fieldEnabled = YES;
    searchV.showBackBtn = YES;
    [searchV.backBtn setImage:IMAGE_NAMED(@"back") forState:UIControlStateNormal];
    [searchV.backBtn setImage:IMAGE_NAMED(@"back") forState:UIControlStateHighlighted];
    searchV.backgroundColor = KWhiteBGColor;

    NSAttributedString *attrString = [[NSAttributedString alloc]initWithString:@"请输入订单号/手机号/收货人姓名" attributes:@{NSForegroundColorAttributeName:KBlack666TextColor,NSFontAttributeName:searchV.searchField.font}];
    searchV.searchField.attributedPlaceholder = attrString;
    
    searchV.leftSearchImgv.image = IMAGE_NAMED(@"放大镜_black");
    searchV.viewClickBlock = ^(NSInteger index, NSString * _Nonnull searchStr) {
        NSLog(@"%@",searchStr);
//        if (![self.searchStr isEqualToString:searchStr]) {
//
//        }
    };
    searchV.backgroundColor = UIColor.whiteColor;
    [navBar addSubview:searchV];
    [navBar bringSubviewToFront:searchV];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell description]];
    if (self.dataArray.count) {
        OrderLogistCompanyModel *model = self.dataArray[indexPath.section];
        cell.textLabel.text = model.companyName;
        cell.textLabel.font = DEFAULT_FONT_R(15);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = KBlack333TextColor;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count) {
        OrderLogistCompanyModel *model = self.dataArray[indexPath.section];
        if (_selectBlock) {
            _selectBlock(model);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)getCompanyList{
    [self startLoadingHUD];
    [THHttpManager GET:@"order/order-express/listCompany" parameters:@{@"":@""} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200 && [data isKindOfClass:[NSArray class]]) {
            [self.dataArray removeAllObjects];
            for (NSDictionary *dica in data) {
                OrderLogistCompanyModel *model = [OrderLogistCompanyModel mj_objectWithKeyValues:dica];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
        }
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SetIOS13;
    [navigationController setNavigationBarHidden:YES animated:YES];
}


@end

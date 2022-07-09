//
//  WithdrawFirstViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/25.
//

#import "WithdrawFirstViewController.h"
#import "BaseCommentTableCell.h"
#import "withdrawViewController.h"
#import "withdrawRecordViewController.h"
#import "WithdrawMingXiViewController.h"

@interface WithdrawFirstViewController ()<UINavigationControllerDelegate>

@property (nonatomic , strong)UILabel *moneyL;

@end

@implementation WithdrawFirstViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self getMoney];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提现";
    self.view.backgroundColor = KBGColor;
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(12);
        } else {
            make.top.equalTo(self.view).offset(KNavBarHeight).offset(12);
        }
    }];
    
    [self.tableView registerClass:[BaseCommentRightTableCell class] forCellReuseIdentifier:[BaseCommentRightTableCell description]];
    self.dataArray = [@[@"货款收益 ¥38.99",@"余额收益 ¥38.99",@"收益明细",@"提现记录"] mutableCopy];
    self.dataArray = [@[@"收益明细",@"提现记录"] mutableCopy];
    [self.tableView reloadData];
    
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 164+12)];
    headerV.backgroundColor = KBGColor;
    
    UIImageView *image = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"my_withdraw_first_bg")];
    image.frame = CGRectMake(12, 0, ScreenWidth - 24, 164);
    [headerV addSubview:image];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"可提现积分" textColor:KWhiteTextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(12)];
    title.frame = CGRectMake(12, 43, ScreenWidth - 48, 20);
    [image addSubview:title];
    
    UILabel *money = [UILabel creatLabelWithTitle:@"0" textColor:KWhiteTextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(45)];
    money.frame = CGRectMake(12, 68, ScreenWidth - 48, 60);
    [image addSubview:money];
    self.moneyL = money;
    if (self.moneyStr) {
        NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.moneyStr]];
        //[attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_M(30) range:NSMakeRange(0,1)];
        money.attributedText = attributeMarket;
    }

    self.tableView.tableHeaderView = headerV;
    [self creatFooterView];
    [self getMoney];
}

- (void)getMoney{
    [THHttpManager GET:@"user/UserStatistics/queryIncomeSta" parameters:@{} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            if ([data objectForKey:@"operableIncome"]) {
                id operableIncome = [data objectForKey:@"operableIncome"];
                if (![operableIncome isEqual:[NSNull null]]) {
                    self.moneyStr = [NSString stringWithFormat:@"%.2f",[[data objectForKey:@"operableIncome"] floatValue]];
                    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.moneyStr]];
                    //[attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_M(30) range:NSMakeRange(0,1)];
                    self.moneyL.attributedText = attributeMarket;
                }
            }
        }
    }];
}

- (void)creatFooterView{
    UIView *footerView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 70)];
    footerView.backgroundColor = KBGColor;
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"去提现" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_M(17) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectMake(12, 20, ScreenWidth - 24, 50) Alignment:NSTextAlignmentCenter Tag:1];
    btn.layer.cornerRadius = 25;
    btn.clipsToBounds = YES;
    [footerView addSubview:btn];
    self.tableView.tableFooterView = footerView;
}

- (void)btnClick{
    withdrawViewController *vc = [[withdrawViewController alloc]init];
    vc.moneyStr = self.moneyStr;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseCommentRightTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseCommentRightTableCell description]];
    cell.leftL.text = self.dataArray[indexPath.row];
    cell.autoCorner = YES;
    [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
//    if (indexPath.row < 2) {
//        cell.rightL.text = @"去提现";
//        cell.rightL.textColor = KMaintextColor;
//
//        NSString *titleStr = self.dataArray[indexPath.row];
//        NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:titleStr];
//        NSRange range = NSMakeRange(5,titleStr.length - 5);
//        [attributeMarket addAttribute:NSForegroundColorAttributeName value:KMaintextColor range:range];
//        [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_R(17) range:range];
//
//        NSRange range1 = NSMakeRange(5,1);
//        [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_R(13) range:range1];
//
//        NSRange rang2 = [attributeMarket.string rangeOfString:@"."];
//        [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_R(13) range:NSMakeRange(rang2.location+1,attributeMarket.string.length - rang2.location - 1 )];
//        cell.leftL.attributedText = attributeMarket;
//    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0 || indexPath.row == 1) {
//        withdrawViewController *vc = [[withdrawViewController alloc]init];
//        vc.index = indexPath.row ;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    if (indexPath.row == 1) {
        withdrawRecordViewController *vc = [[withdrawRecordViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 0) {
        WithdrawMingXiViewController *vc = [[WithdrawMingXiViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SetIOS13;
    [navigationController setNavigationBarHidden:NO animated:YES];
}

@end

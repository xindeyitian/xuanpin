//
//  MyOrderLogisticsViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/27.
//

#import "MyOrderLogisticsViewController.h"
#import "BaseCommentTableCell.h"
#import "MyOrderLogisticsTableViewCell.h"

@interface MyOrderLogisticsViewController ()

@property (nonatomic , strong)NSString *code;
@property (nonatomic , strong)NSString *company;

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
    [self.tableView registerClass:[BaseCommentRightTableCell class] forCellReuseIdentifier:[BaseCommentRightTableCell description]];
    [self.tableView registerClass:[BaseCommentTableCell class] forCellReuseIdentifier:[BaseCommentTableCell description]];
    [self.tableView registerClass:[MyOrderLogisticsTableViewCell class] forCellReuseIdentifier:[MyOrderLogisticsTableViewCell description]];

    if (self.haveBottom) {
        UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 70)];
        footerV.backgroundColor = KBGLightColor;
        self.tableView.tableFooterView = footerV;
        
        BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"发货" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_M(17) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
        btn.frame = CGRectMake(12, 20, ScreenWidth - 24, 50);
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = 25;
        [footerV addSubview:btn];
        //确认修改
        //没有尾视图
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 2:3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            BaseCommentTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseCommentTableCell description]];
            cell.contentView.backgroundColor = KBGLightColor;
            cell.autoCorner = YES;
            [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
            cell.leftL.text = @"选择发货方式";
            cell.rightL.text = @"快递配送";
            cell.rightL.textColor = KBlack333TextColor;
            return cell;
        }
        BaseCommentRightTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseCommentRightTableCell description]];
        cell.contentView.backgroundColor = KBGLightColor;
        cell.autoCorner = YES;
        [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
        cell.leftL.text = indexPath.row == 1? @"快递公司" : @"快递单号";
        cell.rightL.text = indexPath.row == 1? @"请选择" : @"请输入快递单号";
        cell.rightImgV.image = indexPath.row == 1? IMAGE_NAMED(@"my_right_gray"):IMAGE_NAMED(@"scan_gray");
        if (indexPath.row == 1) {
            cell.rightL.textColor = self.company.length ? KBlack333TextColor :KBlack999TextColor;
            if (self.company.length) {
                cell.rightL.text = self.company;
            }
        }else{
            cell.rightL.textColor = self.code.length ? KBlack333TextColor :KBlack999TextColor;
            if (self.code.length) {
                cell.rightL.text = self.code;
            }
        }
        return cell;
    }
    MyOrderLogisticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyOrderLogisticsTableViewCell description]];
    cell.contentView.backgroundColor = KBGLightColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0 ? 96 : 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 37;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 37)];
    view.backgroundColor = KBGLightColor;
    UILabel *title = [UILabel creatLabelWithTitle:section == 0 ? @" 选择发货商品  默认全选":@"填写物流信息" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
    title.frame = CGRectMake(12, 8, ScreenWidth-24, 21);
    [view addSubview:title];
    if (section == 0) {
        NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:@" 选择发货商品  默认全选"];
        NSRange range = NSMakeRange(attributeMarket.string.length - 4,4);
        [attributeMarket addAttribute:NSForegroundColorAttributeName value:KBlack666TextColor range:range];
        title.attributedText = attributeMarket;
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section == 0 ? 0.01 : 32;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 32)];
        footerV.backgroundColor = KBGLightColor;
        
        UILabel *title = [UILabel creatLabelWithTitle:@"" textColor:KBlack666TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
        title.frame = CGRectMake(12, 12, ScreenWidth - 24, 20);
        [footerV addSubview:title];

        NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:@"小莲提示：物流信息只允许修改一次哦！"];
        NSRange range = NSMakeRange(0,5);
        [attributeMarket addAttribute:NSForegroundColorAttributeName value:KMaintextColor range:range];
        title.attributedText = attributeMarket;
        return footerV;
    }
    return [UIView new];
}

- (void)btnClick{
    
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SetIOS13;
    [navigationController setNavigationBarHidden:NO animated:YES];
}

@end

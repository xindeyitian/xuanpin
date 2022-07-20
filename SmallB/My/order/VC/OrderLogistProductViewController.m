//
//  OrderLogistProductViewController.m
//  SmallB
//
//  Created by zhang on 2022/7/7.
//

#import "OrderLogistProductViewController.h"
#import "myOrderListContentTableViewCell.h"
#import "MyOrderLogisticsDataModel.h"
#import "OrderLogistProductTableViewCell.h"

@interface OrderLogistProductViewController ()

@end

@implementation OrderLogistProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择发货商品";
    
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
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"确认" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_M(17) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
    btn.frame = CGRectMake(12, 5, ScreenWidth - 24, 50);
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 25;
    [bottomV addSubview:btn];
    
    //获取其他的已选中的商品
    NSMutableArray *selectedAry = [NSMutableArray array];
    NSMutableArray *selectAry = [NSMutableArray array];
    for (int i =0; i < self.allListAry.count; i ++) {
        MyOrderLogisticsDataModel *model = self.allListAry[i];
        if (i == self.section) {
            [selectedAry addObjectsFromArray:model.productList];
        }else{
            [selectAry addObjectsFromArray:model.productList];
        }
    }
    [self.tableView registerClass:[OrderLogistProductTableViewCell class] forCellReuseIdentifier:[OrderLogistProductTableViewCell description]];
    for (OrderListProductModel *model in self.productAry) {
        if ([selectAry containsObject:model]) {
            model.isNoChoose = YES;
            model.isSelected = YES;
        }
        if ([selectedAry containsObject:model]) {
            model.isSelected = YES;
            model.isNoChoose = NO;
        }
    }
}

- (void)btnClick{
    NSMutableArray *selectAry = [NSMutableArray array];
    for (OrderListProductModel *model in self.productAry) {
        if (model.isSelected && !model.isNoChoose) {
            [selectAry addObject:model];
        }
    }
    if (_selectBlock) {
        _selectBlock(selectAry);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.productAry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderLogistProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[OrderLogistProductTableViewCell description]];
    cell.autoCorner = YES;
    [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
    if (self.productAry.count) {
        OrderListProductModel *model = self.productAry[indexPath.row];
        cell.model = model;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 96;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderListProductModel *model = self.productAry[indexPath.row];
    if (!model.isNoChoose) {
        model.isSelected = !model.isSelected;
        [self.tableView reloadData];
    }
}

@end

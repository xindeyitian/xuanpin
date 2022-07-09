//
//  OrderLogistedListDetailViewController.m
//  SmallB
//
//  Created by zhang on 2022/7/7.
//

#import "OrderLogistedListDetailViewController.h"
#import "OrderLogistDetailTableViewCell.h"
#import "myOrderDetailHeaderView.h"

@interface OrderLogistedListDetailViewController ()

@end

@implementation OrderLogistedListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"物流信息";
    self.view.backgroundColor = KBGLightColor;
    [self.tableView registerClass:[OrderLogistDetailTableViewCell class] forCellReuseIdentifier:[OrderLogistDetailTableViewCell description]];
    
    BOOL seeWuliu = NO;
    BOOL haveBtn = YES;

    float height = [@"" sizeWithLabelWidth:ScreenWidth - 55 - 24 font:DEFAULT_FONT_R(13)].height;
    myOrderDetailHeaderView *headView = [[myOrderDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 98+(76+height)+(seeWuliu?64:0) + (haveBtn ? 47 : 0))];
    headView.haveBtn = haveBtn;
    headView.showWuliu = seeWuliu;
    headView.addressStr = @"";
    self.tableView.tableHeaderView = headView;
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

@end

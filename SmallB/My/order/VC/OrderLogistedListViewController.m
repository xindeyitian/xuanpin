//
//  OrderLogistedListViewController.m
//  SmallB
//
//  Created by zhang on 2022/7/7.
//

#import "OrderLogistedListViewController.h"
#import "OrderLogistedListTableViewCell.h"
#import "OrderLogistedListDetailViewController.h"

@interface OrderLogistedListViewController ()

@end

@implementation OrderLogistedListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"物流信息";
    self.view.backgroundColor = KBGLightColor;
    [self.tableView registerClass:[OrderLogistedListTableViewCell class] forCellReuseIdentifier:[OrderLogistedListTableViewCell description]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderLogistedListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[OrderLogistedListTableViewCell description]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 104;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderLogistedListDetailViewController *vc = [[OrderLogistedListDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

//
//  MessageContentViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/24.
//

#import "MessageContentViewController.h"
#import "MessageOrderTableViewCell.h"
#import "MessageSystemTableViewCell.h"
#import "MessageDetailViewController.h"

@interface MessageContentViewController ()

@end

@implementation MessageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emptyDataView.noDataImageView.image = IMAGE_NAMED(@"no_data_list");
    self.emptyDataView.noDataTitleLabel.text = @"暂无数据哦～";
    
    self.tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - KNavBarHeight - 44);
    [self.tableView registerClass:[MessageOrderTableViewCell class] forCellReuseIdentifier:[MessageOrderTableViewCell description]];
    [self.tableView registerClass:[MessageSystemTableViewCell class] forCellReuseIdentifier:[MessageSystemTableViewCell description]];
}

#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MessageOrderTableViewCell description]];
    cell.autoCorner = YES;
    [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
    cell.separatorLineView.hidden = YES;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageDetailViewController *vc = [[MessageDetailViewController alloc]init];
    vc.index = self.index;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    SetIOS13;
    [navigationController setNavigationBarHidden:NO animated:YES];
}

- (UIView *)listView {
    return self.view;
}

@end

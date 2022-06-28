//
//  MessageDetailViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/24.
//

#import "MessageDetailViewController.h"
#import "MessageDetailTableViewCell.h"
#import "MagicBoxMessageListModel.h"

@interface MessageDetailViewController ()

@property (nonatomic , strong)MagicBoxMessageListModel *detailModel;
@end

@implementation MessageDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.index == 0 ?  @"订单消息" : @"系统消息";
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(12);
        } else {
            make.top.equalTo(self.view).offset(KNavBarHeight).offset(12);
        }
    }];
 
    [self.tableView registerClass:[MessageDetailTableViewCell class] forCellReuseIdentifier:[MessageDetailTableViewCell description]];
    [self getDetail];
}

- (void)getDetail{
    [self startLoadingHUD];
    [THHttpManager POST:[NSString stringWithFormat:@"msg_log/queryUserMsgDetail/%@",self.msgID] parameters:@{} dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            self.detailModel = [MagicBoxMessageListModel mj_objectWithKeyValues:data];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MessageDetailTableViewCell description]];
    cell.autoCorner = YES;
    [cell defualtCornerInTableView:tableView atIndexPath:indexPath];
    cell.separatorLineView.hidden = YES;
    cell.model = self.detailModel;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    SetIOS13;
    [navigationController setNavigationBarHidden:NO animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
    
@end


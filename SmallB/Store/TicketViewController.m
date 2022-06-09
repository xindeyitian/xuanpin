//
//  TicketViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/12.
//

#import "TicketViewController.h"
#import "TicketTableViewCell.h"

@interface TicketViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (copy,   nonatomic) void(^scrollCallback)(UIScrollView *scrollView);
@property (strong, nonatomic) UITableView *ticketTable;

@end

@implementation TicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ticketTable = [[UITableView alloc] initWithFrame:CGRectMake(12, 0, ScreenWidth - 24, ScreenHeight - 208 - 12) style:UITableViewStyleGrouped];
    self.ticketTable.delegate = self;
    self.ticketTable.dataSource = self;
    self.ticketTable.separatorColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.ticketTable.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
    self.ticketTable.layer.cornerRadius = 8;
    self.ticketTable.layer.masksToBounds = YES;
    self.ticketTable.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
    [self.view addSubview:self.ticketTable];
    
    [self.ticketTable registerClass:[TicketTableViewCell class] forCellReuseIdentifier:@"TicketTableViewCell"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TicketTableViewCell"];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 113;
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
#pragma mark - JXCategoryListContentViewDelegate -
- (UIScrollView *)listScrollView {
    return self.ticketTable;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self.view;
}

@end

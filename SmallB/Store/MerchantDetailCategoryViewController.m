//
//  MerchantDetailCategoryViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/11.
//

#import "MerchantDetailCategoryViewController.h"
#import "CategoryDetailViewController.h"
#import "MerchantDetailBaseViewController.h"

@interface MerchantDetailCategoryViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (copy,   nonatomic) void(^scrollCallback)(UIScrollView *scrollView);
@property (strong, nonatomic) UITableView *categoryTable;

@end

@implementation MerchantDetailCategoryViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.categoryTable = [[UITableView alloc] initWithFrame:CGRectMake(12, 12, ScreenWidth - 24, ScreenHeight - 208 - 24) style:UITableViewStyleGrouped];
    self.categoryTable.delegate = self;
    self.categoryTable.dataSource = self;
    self.categoryTable.separatorColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.categoryTable.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
    self.categoryTable.layer.cornerRadius = 8;
    self.categoryTable.layer.masksToBounds = YES;
    self.categoryTable.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.categoryTable];
    
    [self.categoryTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"产品分类";
    cell.textLabel.font = DEFAULT_FONT_R(15);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryDetailViewController *vc = [[CategoryDetailViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
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
#pragma mark - JXCategoryListContentViewDelegate -
- (UIScrollView *)listScrollView {
    return self.categoryTable;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self.view;
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[self class]] || [viewController isKindOfClass:[MerchantDetailBaseViewController class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}
@end

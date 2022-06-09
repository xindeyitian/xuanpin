//
//  CategoryPopView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/11.
//

#import "CategoryPopView.h"

static CategoryPopView* _instance = nil;

@interface CategoryPopView()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *categoryTable;

@end

@implementation CategoryPopView
+ (instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        
        _instance = [[CategoryPopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, (ScreenHeight - KNavBarHeight) / 2)];
    }) ;
    return _instance ;
}
- (void)popCategroyView{
    
    self.categoryTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, (ScreenHeight - KNavBarHeight) / 2) style:UITableViewStyleGrouped];
    self.categoryTable.delegate = self;
    self.categoryTable.dataSource = self;
    self.categoryTable.separatorColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.categoryTable.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
    self.categoryTable.layer.cornerRadius = 8;
    self.categoryTable.layer.masksToBounds = YES;
    self.categoryTable.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.categoryTable];
    
    [self.categoryTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    LSTPopView *popView = [LSTPopView initWithCustomView:self popStyle:LSTPopStyleSmoothFromTop dismissStyle:LSTDismissStyleSmoothToTop];
    LSTPopViewWK(popView)
    popView.hemStyle = LSTHemStyleTop;
    popView.popStyle = LSTPopStyleNO;
    popView.dismissStyle = LSTDismissStyleNO;
    popView.adjustY = KNavBarHeight + 42;
    popView.isClickFeedback = YES;
    popView.bgColor = UIColor.clearColor;
    popView.bgClickBlock = ^{
        [wk_popView dismiss];
    };
    [popView pop];
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
//    CategoryDetailViewController *vc = [[CategoryDetailViewController alloc] init];
//
//    [self.navigationController pushViewController:vc animated:YES];
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
@end

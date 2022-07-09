//
//  MyOrderListZiYingContentViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/26.
//

#import "MyOrderListZiYingContentViewController.h"
#import "MyOrderListZiYingTableViewCell.h"
#import "MyorderDetailViewController.h"

@interface MyOrderListZiYingContentViewController ()<JXCategoryViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,LMJVerticalFlowLayoutDelegate>
{
    NSInteger _index;
}
@property (copy,   nonatomic) void(^scrollCallback)(UIScrollView *scrollView);
@property (strong, nonatomic) UITableView *homeTable;
@property (strong, nonatomic) UICollectionView *homeCollection;
@property (strong, nonatomic) UIView *topUtilityView;
@property (strong, nonatomic) UIButton *changeLayerBtn;
@property (nonatomic, strong) NSMutableArray<NSString *> *titles;
@property (nonatomic, strong) JXCategoryTitleSortView *categoryView;
@property (strong, nonatomic) NSMutableArray *dataSorce;

@end

@implementation MyOrderListZiYingContentViewController

#pragma mark - 切换tableview和collectionView
- (void)changeLayer:(UIButton *)sender{
    sender.selected = !sender.isSelected;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSorce = @[].mutableCopy;

    self.homeTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.homeTable.delegate = self;
    self.homeTable.dataSource = self;
    self.homeTable.showsVerticalScrollIndicator = NO;
    self.homeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.homeTable.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.homeTable];
    [self.homeTable registerClass:[MyOrderListZiYingTableViewCell class] forCellReuseIdentifier:[MyOrderListZiYingTableViewCell description]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.homeTable.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 60 - KNavBarHeight - 44);
}
#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyOrderListZiYingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyOrderListZiYingTableViewCell description]];
    cell.productTitleL.text = [NSString stringWithFormat:@"%@====%ld",@"三只松鼠坚果",(long)self.index];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pustToDetailWithSection:indexPath.section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 86;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    myOrderListZiYingCellFootView *view = [[myOrderListZiYingCellFootView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    CJWeakSelf()
    view.viewClickBlock = ^{
        CJStrongSelf()
        [self pustToDetailWithSection:section];
    };
    view.successBlock = ^{
        
    };
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 76+12;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    myOrderListZiYingCellHeadView *view = [[myOrderListZiYingCellHeadView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 76+12+7)];
    CJWeakSelf()
    view.viewClickBlock = ^{
        CJStrongSelf()
        [self pustToDetailWithSection:section];
    };
    return view;
}

- (void)pustToDetailWithSection:(NSInteger)section{
    
    MyorderDetailViewController *vc = [[MyorderDetailViewController alloc]init];
    [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
}

#pragma mark - JXCategoryListContentViewDelegate -
- (UIScrollView *)listScrollView {
    return self.homeTable;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self.view;
}

-(void)setIndex:(NSInteger)index{
    _index = index;
    [self.homeTable reloadData];
}

@end


//
//  ProductGuiGeViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/25.
//

#import "ProductGuiGeViewController.h"
#import "ProductDetailGuiGeHeaderView.h"
#import "ProductDetailGuiGeCell.h"

@interface ProductGuiGeViewController ()

@end

@implementation ProductGuiGeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kRGBA(0,0,0,0.55);
    self.view.userInteractionEnabled = YES;
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(500);
        make.bottom.equalTo(self.view.mas_bottom).offset(-TabbarSafeBottomMargin - 44);
        make.left.right.equalTo(self.view);
    }];
    self.tableView.backgroundColor = KBGColor;
 
    [self.tableView registerClass:[ProductDetailGuiGeCell class] forCellReuseIdentifier:[ProductDetailGuiGeCell description]];
    
    ProductDetailGuiGeHeaderView *headerView = [[ProductDetailGuiGeHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    self.tableView.tableHeaderView = headerView;
    
    [self creatBottom];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductDetailGuiGeCell *cell = [tableView dequeueReusableCellWithIdentifier:[ProductDetailGuiGeCell description]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (void)creatBottom{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - TabbarSafeBottomMargin - 50, ScreenWidth, TabbarSafeBottomMargin + 50)];
    bottomView.backgroundColor = KWhiteBGColor;
    [self.view addSubview:bottomView];
    
    UIView *linV = [[UIView alloc]initWithFrame:CGRectMake(12, 2, ScreenWidth - 24, 1)];
    linV.backgroundColor = KBGColor;
    [bottomView addSubview:linV];
    
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(12 , 5, ScreenWidth - 24, 40);
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = DEFAULT_FONT_R(15);
    btn.titleLabel.numberOfLines = 2;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.textColor = KBlack333TextColor;
    btn.layer.cornerRadius = 20;
    btn.clipsToBounds = YES;
    btn.backgroundColor =KMainBGColor ;
    [bottomView addSubview:btn];
}

- (void)btnClick:(UIButton *)btn{
    [[AppTool currentVC] dismissViewControllerAnimated:NO completion:nil];
}

@end


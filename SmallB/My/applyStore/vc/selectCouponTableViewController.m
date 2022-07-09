//
//  selectCouponTableViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/16.
//

#import "selectCouponTableViewController.h"
#import "BaseSelectTableViewCell.h"
#import "CouponListModel.h"

@interface selectCouponTableViewController ()

@property (nonatomic , assign)NSInteger selectIndex;

@end

@implementation selectCouponTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGBA(0,0,0,0.55);
    self.selectIndex = 0;
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(350);
    }];
    [self.tableView registerClass:[BaseSelectTableViewCell class] forCellReuseIdentifier:[BaseSelectTableViewCell description]];
    
    UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, KTabBarHeight - 49)];
    footerV.backgroundColor = KBGColor;
    self.tableView.tableFooterView = footerV;
    
    UIView *tmpBGView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tmpBGView];
    tmpBGView.backgroundColor = KWhiteBGColor;
    tmpBGView.bounds =  CGRectMake(0, 0, ScreenWidth, 50);

    [tmpBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(self.tableView.mas_top);
    }];

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:tmpBGView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = tmpBGView.bounds;
    maskLayer.path = maskPath.CGPath;
    tmpBGView.layer.mask = maskLayer;
    
    UILabel *title = [UILabel creatLabelWithTitle:@"选择优惠券" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(17)];
    [tmpBGView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tmpBGView).offset(10);
        make.height.mas_equalTo(30);
        make.left.right.mas_equalTo(tmpBGView);
    }];
    
    UIButton *close = [[UIButton alloc]init];
    [close setImage:IMAGE_NAMED(@"btn_delete_btn") forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [tmpBGView addSubview:close];
    [close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tmpBGView).offset(10);
        make.height.width.mas_equalTo(30);
        make.right.mas_equalTo(tmpBGView).offset(-12);
    }];
}

- (void)closeClick{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
}

- (void)setCouponAry:(NSMutableArray *)couponAry{
    _couponAry = couponAry;
    
}

- (void)setSelectModel:(CouponListVosModel *)selectModel{
    _selectModel = selectModel;
    [self.tableView reloadData];
}

#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.couponAry.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseSelectTableViewCell description]];
    cell.hiddenLeft = YES;
    cell.bgViewContentInset = UIEdgeInsetsMake(0, 0, 0, 0);

    cell.rightImgV.image = indexPath.row == self.selectIndex ? IMAGE_NAMED(@"choosed"):IMAGE_NAMED(@"choose");
    
    if (self.couponAry.count) {
        cell.separatorLineView.hidden = indexPath.row == self.couponAry.count - 1;
        CouponListVosModel *model = self.couponAry[indexPath.row];
        cell.titleL.text = [NSString stringWithFormat:@"¥%@-%@",model.moneyCouponSub,model.typeName];
        if (self.selectModel && [model.couponId isEqualToString:self.selectModel.couponId]) {
            cell.rightImgV.image = IMAGE_NAMED(@"choosed");
        }else{
            cell.rightImgV.image = IMAGE_NAMED(@"choose");
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CouponListVosModel *model = self.couponAry[indexPath.row];
    if (_viewClickBlock) {
        _viewClickBlock(model);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.2, @1.1, @1.0];
    animation.duration = 0.05;
    animation.calculationMode = kCAAnimationCubic;
    //把动画添加上去就OK了
    //[_bgView.layer addAnimation:animation forKey:nil];
}

@end


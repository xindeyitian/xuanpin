//
//  ProductDetailSKUViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/25.
//

#import "ProductDetailSKUViewController.h"
#import "ProductDetailSKUHeaderView.h"
#import "SKUDetailTableViewCell.h"
#import "UIButton+ImageTitleSpacing.h""

@interface ProductDetailSKUViewController ()

@property (nonatomic , strong)NSString *selectString;
@property (nonatomic , strong)ProductDetailSKUHeaderView *headerV;

@end

@implementation ProductDetailSKUViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kRGBA(0,0,0,0.55);
    self.view.userInteractionEnabled = YES;
    
    self.tableView.backgroundColor = KWhiteBGColor;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(300);
        make.bottom.equalTo(self.view.mas_bottom).offset(-TabbarSafeBottomMargin - 50);
        make.left.right.equalTo(self.view);
    }];
    [self.tableView registerClass:[SKUDetailTableViewCell class] forCellReuseIdentifier:[SKUDetailTableViewCell description]];
    
    self.selectString = @"";

    [self.tableView reloadData];
}

- (void)setModel:(ProductDetailModel *)model{
    _model = model;
    [self creatHeaderView];
    [self creatBottomWithInteger:0];
    [self judgeHidden];
}

- (float)getHeightWithAry:(NSArray *)array{
    float height = 12.0f;
    float firstwidth = 12.0f;
    for (int i =0; i < array.count; i ++) {
        ProductDetailGoodsSkuAttrValueModel *model = array[i];
        float width = [model.attrValueName sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:DEFAULT_FONT_R(13), NSFontAttributeName, nil]].width+20;
        if (firstwidth + width + 12> ScreenWidth - 24) {
            firstwidth = 12.0f;
            height += (24 + 10);
        }
        firstwidth += (width + 12);
    }
    height += (24 + 10);
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.model.goodsAttVos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SKUDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SKUDetailTableViewCell description]];
    cell.contentView.backgroundColor = KWhiteBGColor;
    if (self.model) {
        goodsAttVosModel *detailModel = self.model.goodsAttVos[indexPath.section];
        cell.titleAry = detailModel.attrValue;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.model) {
        goodsAttVosModel *detailModel = self.model.goodsAttVos[indexPath.section];
        return [self getHeightWithAry:detailModel.attrValue];
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    view.backgroundColor = KWhiteBGColor;
    
    UILabel *title = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(17)];
    title.frame = CGRectMake(12, 5, ScreenWidth - 24, 34);
    [view addSubview:title];
    if (self.model) {
        goodsAttVosModel *detailModel = self.model.goodsAttVos[section];
        title.text = detailModel.attrName;
    }
    return view;
}

- (void)creatHeaderView{
    ProductDetailSKUHeaderView *headerView = [[ProductDetailSKUHeaderView alloc]initWithFrame:CGRectMake(0, ScreenHeight - TabbarSafeBottomMargin - 50 - 300 - 120, ScreenWidth, 120)];
    headerView.model = self.model;
    [self.view addSubview: headerView];
}

- (void)judgeHidden{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSMutableDictionary *signDic = [AppTool getRequestSign];
    [signDic setObject:[NSString stringWithFormat:@"supply_ios_%@",app_Version] forKey:@"versionCode"];
    [THHttpManager GET:[NSString stringWithFormat:@"%@version/getVersion",XTAppBaseUseURL] parameters:signDic block:^(NSInteger returnCode, THRequestStatus status, id data) {
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            if ([data objectForKey:@"ifShow"]) {
                NSString *result = [NSString stringWithFormat:@"%@",[data objectForKey:@"ifShow"]];
                [self creatBottomWithInteger:result.integerValue];
            }
        }
    }];
}

- (void)creatBottomWithInteger:(NSInteger)result{
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - TabbarSafeBottomMargin - 50, ScreenWidth, TabbarSafeBottomMargin + 50)];
    bottomView.backgroundColor = KWhiteBGColor;
    [self.view addSubview:bottomView];
    
    UIView *linV = [[UIView alloc]initWithFrame:CGRectMake(12, 2, ScreenWidth - 24, 1)];
    linV.backgroundColor = KBGColor;
    [bottomView addSubview:linV];
    
    int num = result == 0 ? 1 : 2;
    float oneWidth = (ScreenWidth - 36)/num;
    for (int i = 0; i < num; i ++) {
        
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(12 + (oneWidth+12)*i, 5, oneWidth, 40);
        //[btn setTitle:i == 0 ? @"转发赚\n¥0.5":@"立即购买\n¥99.5" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 114+i ;
        btn.titleLabel.font = DEFAULT_FONT_R(11);
        btn.titleLabel.numberOfLines = 2;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.textColor = KBlack333TextColor;
        btn.layer.cornerRadius = 20;
        btn.clipsToBounds = YES;
        btn.backgroundColor = i == 1 ? KMainBGColor : KOrangeBGtColor;
        [bottomView addSubview:btn];
    }
    
    UIButton *shareBtn = [bottomView viewWithTag:114];
    UIButton *buyBtn = [bottomView viewWithTag:115];
    [shareBtn setTitle:[NSString stringWithFormat:@"转发赚\n%@",self.model.commission] forState:UIControlStateNormal];
    [buyBtn setTitle:[NSString stringWithFormat:@"立即购买\n¥%@",self.model.salePrice] forState:UIControlStateNormal];
    if ([AppTool getCurrentLevalIsAdd]) {
        [shareBtn setTitle:@"加入橱窗" forState:UIControlStateNormal];
        [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        shareBtn.titleLabel.font = DEFAULT_FONT_M(15);
        buyBtn.titleLabel.font = DEFAULT_FONT_M(15);
    }
}

- (void)btnClick:(UIButton *)btn{
    if (btn.tag == 114) {
        GoodsListVosModel *model = [[GoodsListVosModel alloc]init];
        model.commission = self.model.commission;
        model.goodsId = self.model.goodsId;
        model.goodsName = self.model.goodsName;
        if (self.model.productImgAry.count) {
            model.goodsThumb = self.model.productImgAry[0];
        }
        model.marketPrice = self.model.marketPrice;
        model.saleCount = self.model.saleCount;
        model.salePrice = self.model.salePrice;
        
        [AppTool roleBtnClickWithID:self.model.goodsId withModel:model];
    }else{
        [AppTool openOthersAppUrl:[NSString stringWithFormat:@"LLWF:productID:%@&supplierID:%@",self.model.goodsId,self.model.shopId]];
    }
}

@end

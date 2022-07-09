//
//  OrderLogistProductTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/7/7.
//

#import "OrderLogistProductTableViewCell.h"

@interface OrderLogistProductTableViewCell ()

@property(nonatomic , strong)UIImageView *productImg;
@property(nonatomic , strong)UIImageView *selectImgV;
@property(nonatomic , strong)UILabel *productpriceL;
@property(nonatomic , strong)UILabel *productTitleL;

@property(nonatomic , strong)UIView *lineV;
@property(nonatomic , strong)UILabel *instrucL;
@property(nonatomic , strong)UILabel *numL;

@property(nonatomic , strong)UILabel *yongjinLab;
@property(nonatomic , strong)UILabel *hasSoldLab;
@property(nonatomic , strong)UILabel *allpriceLab;

@property(nonatomic , strong)UIView *bgWhiteView;

@end

@implementation OrderLogistProductTableViewCell


- (void)k_creatSubViews {
    [super k_creatSubViews];
    
    self.contentView.backgroundColor = KBGColor;
    
    UIImageView *selectImg = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"all_select_select")];
    [self.bgView addSubview:selectImg];
    [selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(11);
        make.top.mas_equalTo(self.bgView).offset(39);
        make.height.width.mas_equalTo(18);
    }];
    self.selectImgV = selectImg;
    
    UIImageView *productImgV = [[UIImageView alloc]init];
    productImgV.clipsToBounds = YES;
    productImgV.layer.cornerRadius = 4;
    [self.bgView addSubview:productImgV];
    [productImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(41);
        make.top.mas_equalTo(self.bgView).offset(12);
        make.height.width.mas_equalTo(72);
    }];
    self.productImg = productImgV;
    
    UILabel *productName = [[UILabel alloc]init];
    productName.font = DEFAULT_FONT_M(13);
    productName.textAlignment = NSTextAlignmentLeft;
    productName.textColor = KBlack333TextColor;
    productName.text = @"";
    [self.bgView addSubview:productName];
    [productName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(productImgV.mas_right).offset(12);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.top.mas_equalTo(productImgV.mas_top);
        make.height.mas_equalTo(18);
    }];
    self.productTitleL = productName;
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    view.clipsToBounds = YES;
    view.layer.cornerRadius = 10;
    [self.bgView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(productName.mas_left);
        make.centerY.mas_equalTo(productImgV.mas_centerY);
    }];
    
    UILabel *instrucLable = [UILabel creatLabelWithTitle:@"" textColor:KBlack666TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(11)];
    [view addSubview:instrucLable];
    [instrucLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(12);
        make.right.mas_equalTo(view).offset(-12);
        make.top.mas_equalTo(view.mas_top);
        make.height.mas_equalTo(20);
    }];
    self.instrucL = instrucLable;
    
    UILabel *productprice = [[UILabel alloc]init];
    productprice.font = DIN_Medium_FONT_R(13);
    productprice.textAlignment = NSTextAlignmentLeft;
    productprice.textColor = KBlack333TextColor;
    [self.bgView addSubview:productprice];
    [productprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(productImgV.mas_right).offset(10);
        make.bottom.mas_equalTo(productImgV.mas_bottom);
        make.height.mas_equalTo(22);
    }];
    self.productpriceL = productprice;
    
    UILabel *numLable = [UILabel creatLabelWithTitle:@"" textColor:KBlack666TextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_R(15)];
    [self.bgView addSubview:numLable];
    [numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.bottom.mas_equalTo(productImgV.mas_bottom);
        make.height.mas_equalTo(20);
        make.width.mas_greaterThanOrEqualTo(10);
    }];
    self.numL = numLable;
    
    self.bgWhiteView = [[UIView alloc]init];
    [self.bgView addSubview:self.bgWhiteView];
    [self.bgWhiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.bgView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.bgWhiteView.backgroundColor = KWhiteBGColor;
    self.bgWhiteView.alpha = 0.65;
    self.bgWhiteView.hidden = YES;
}

- (void)setModel:(OrderListProductModel *)model{
    _model = model;
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:model.skuImgUrl] placeholderImage:[UIImage imageNamed:@"icon_image"]];
    self.productpriceL.text = [NSString stringWithFormat:@"¥%@",model.priceSale];
    self.productTitleL.text = model.goodsName;
    self.instrucL.text = model.skuName;
    self.numL.text = [NSString stringWithFormat:@"x%@",model.quantityTotal];
    self.selectImgV.image = model.isSelected ? IMAGE_NAMED(@"all_select_selected"):IMAGE_NAMED(@"all_select_select");
    self.bgWhiteView.hidden = !model.isNoChoose;;
}

@end

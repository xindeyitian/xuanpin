//
//  shipWindowContentCell.m
//  SmallB
//
//  Created by zhang on 2022/4/9.
//

#import "shipWindowContentCell.h"

@interface shipWindowContentCell ()

@property(nonatomic , strong)UIImageView *productImgV;
@property(nonatomic , strong)UIView *lineV;

@property(nonatomic , strong)UILabel *yongjinLab;
@property(nonatomic , strong)UILabel *allpriceLab;
@property(nonatomic , strong)UILabel *statusL;

@property(nonatomic , strong)UIImageView *shenheImgV;
@property(nonatomic , strong)UIButton *statusOperationBtn;

@end

@implementation shipWindowContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews {
    
    self.contentView.backgroundColor = KBlackLineColor;
    
    UIView *whiteV = [[UIView alloc]init];
    whiteV.backgroundColor = KWhiteBGColor;
    whiteV.layer.cornerRadius = 8;
    whiteV.clipsToBounds = YES;
    [self.contentView addSubview:whiteV];
    [whiteV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 12, 0, 12));
    }];
    
    self.productImgV = [[UIImageView alloc]init];
    self.productImgV.layer.cornerRadius = 4;
    self.productImgV.layer.masksToBounds = YES;
    [whiteV addSubview:self.productImgV];
    [self.productImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(whiteV).offset(12);
        make.top.mas_equalTo(whiteV).offset(12);
        make.height.width.mas_equalTo(80);
    }];
    
    self.productTitleL = [[UILabel alloc]init];
    self.productTitleL.font = DEFAULT_FONT_M(15);
    self.productTitleL.textColor = KBlack333TextColor;
    self.productTitleL.numberOfLines = 2;
    [whiteV addSubview:self.productTitleL];
    [self.productTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productImgV.mas_right).offset(12);
        make.right.mas_equalTo(whiteV).offset(-12);
        make.top.mas_equalTo(self.productImgV.mas_top);
    }];
    
    self.statusL = [[UILabel alloc]init];
    self.statusL.font = DEFAULT_FONT_R(12);
    self.statusL.textColor = KBlack333TextColor;
    self.statusL.textAlignment = NSTextAlignmentRight;
    [whiteV addSubview:self.statusL];
    [self.statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(whiteV).offset(-12);
        make.bottom.mas_equalTo(self.productImgV.mas_bottom);
        make.height.mas_equalTo(20);
    }];

    UILabel *priceLable = [[UILabel alloc] initWithFrame:CGRectZero];
    priceLable.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    priceLable.font = DIN_Bold_FONT_R(18);
    priceLable.text = @"";
    [self.contentView addSubview:priceLable];
    [priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.productImgV.mas_bottom);
        make.left.mas_equalTo(self.productTitleL.mas_left);
        make.right.mas_equalTo(self.statusL.mas_left).offset(-10);
        make.height.mas_equalTo(25);
    }];
    self.allpriceLab = priceLable;
    [self.statusL setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.allpriceLab setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];

    UIButton *statusBtn = [BaseButton CreateBaseButtonTitle:@"下架" Target:self Action:@selector(btnClick) Font:[UIFont systemFontOfSize:12] BackgroundColor:KOrangeBGtColor Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    [statusBtn setImage:IMAGE_NAMED(@"tab_window-xiajia") forState:UIControlStateNormal];
    statusBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    statusBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    statusBtn.layer.cornerRadius = 13;
    statusBtn.layer.masksToBounds = YES;
    [whiteV addSubview:statusBtn];
    [statusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(whiteV.mas_right).offset(-12);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(87);
        make.bottom.mas_equalTo(whiteV.mas_bottom).offset(-12);
    }];
    self.statusOperationBtn = statusBtn;
    
    //上架   KMainBGColor  tab_window-shangjia
    //下架   KOrangeBGtColor   tab_window-xiajia
    //审核   tab_window-shenhe
    
    self.shenheImgV = [[UIImageView alloc]init];
    self.shenheImgV.image = IMAGE_NAMED(@"tab_window-shenhe");
    self.shenheImgV.hidden = YES;
    [whiteV addSubview:self.shenheImgV];
    [self.shenheImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(66);
        make.right.bottom.mas_equalTo(whiteV);
    }];
}

-(void)setIndex:(NSInteger)index{
    _index = index;
}

- (void)setModel:(GoodsListVosModel *)model{
    _model = model;
    [self.productImgV sd_setImageWithURL:[NSURL URLWithString:model.goodsThumb] placeholderImage:KPlaceholder_DefaultImage];
    self.productTitleL.text = model.goodsName;
    if (model.stockQuantity) {
        self.statusL.text = [NSString stringWithFormat:@"库存%@",K_NotNullHolder(model.stockQuantity, 0)];
    }else{
        self.statusL.text = [NSString stringWithFormat:@"库存%@",@"0"];
    }

    NSString *price = [NSString stringWithFormat:@"¥%@ ¥%@",model.salePrice,model.marketPrice];
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:price];
    NSRange range = NSMakeRange(0,1);
    [attributeMarket addAttribute:NSFontAttributeName value:DIN_Medium_FONT_R(13) range:range];
    
    NSString *old = [price componentsSeparatedByString:@" "].lastObject;
    NSRange PriceRange = NSMakeRange(price.length-old.length,old.length);
    [attributeMarket setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:PriceRange];
    [attributeMarket addAttribute:NSForegroundColorAttributeName value:KBlack999TextColor range:PriceRange];
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_R(11) range:PriceRange];
    self.allpriceLab.attributedText = attributeMarket;
}

- (void)setShopType:(NSInteger)shopType{
    _shopType = shopType;
    if (self.index == 0) {
        self.shenheImgV.hidden = YES;
        self.statusOperationBtn.hidden = NO;
        [self.statusOperationBtn setImage:IMAGE_NAMED(@"tab_window-xiajia") forState:UIControlStateNormal];
        [self.statusOperationBtn setTitle:@"下架" forState:UIControlStateNormal];
        self.statusString = @"下架";
    }
    if (self.index == 2 || (self.index == 1 && self.shopType == 0)) {
        self.shenheImgV.hidden = YES;
        self.statusOperationBtn.hidden = NO;
        [self.statusOperationBtn setImage:IMAGE_NAMED(@"tab_window-shangjia") forState:UIControlStateNormal];
        [self.statusOperationBtn setTitle:@"发布" forState:UIControlStateNormal];
        self.statusOperationBtn.backgroundColor = KMainBGColor;
        self.statusString = @"发布";
    }
    if (self.index == 1 && self.shopType == 1) {
        [self.statusOperationBtn setTitle:@"审核中" forState:UIControlStateNormal];
    }
    if (self.index == 1 && self.shopType == 1) {
        [self.statusOperationBtn setTitle:@"发布" forState:UIControlStateNormal];
        self.statusOperationBtn.backgroundColor = KMainBGColor;
    }
}

//- (void)setStatusType:(windowProductType)statusType{
//
//    if (_statusType == windowProductTypeCloudSold || _statusType == windowProductTypeMineSold) {
//        self.shenheImgV.hidden = YES;
//        self.statusOperationBtn.hidden = NO;
//        [self.statusOperationBtn setImage:IMAGE_NAMED(@"tab_window-xiajia") forState:UIControlStateNormal];
//        [self.statusOperationBtn setTitle:@"下架" forState:UIControlStateNormal];
//    }
//    if (_statusType == windowProductTypeMineShenhe) {
//        self.shenheImgV.hidden = NO;
//        self.statusOperationBtn.hidden = YES;
//    }
//    if (_statusType == windowProductTypeCloudYiXiajia || _statusType == windowProductTypeMineYiXiajia) {
//        self.shenheImgV.hidden = YES;
//        self.statusOperationBtn.hidden = NO;
//        [self.statusOperationBtn setImage:IMAGE_NAMED(@"tab_window-shangjia") forState:UIControlStateNormal];
//        [self.statusOperationBtn setTitle:@"上架" forState:UIControlStateNormal];
//    }
//
//    switch (_statusType) {
//        case windowProductTypeCloudSold :{
//            self.statusString = @"下架";
//            self.productTitleL.text = @"连衣裙===00=00";
//        }
//            break;
//        case windowProductTypeCloudYiXiajia:{
//            self.statusString = @"上架";
//            self.productTitleL.text = @"连衣裙===00=11";
//        }
//            break;
//        case windowProductTypeMineSold:{
//            self.statusString = @"下架";
//            self.productTitleL.text = @"连衣裙===11=00";
//        }
//            break;
//        case windowProductTypeMineShenhe:{
//            self.statusString = @"";
//            self.productTitleL.text = @"连衣裙===11=11";
//        }
//            break;
//        case  windowProductTypeMineYiXiajia:{
//            self.statusString = @"上架";
//            self.productTitleL.text = @"连衣裙===11=22";
//        }
//            break;
//        default:
//            break;
//    }
//}

- (void)btnClick{

    THBaseViewController *vc = (THBaseViewController *)[AppTool currentVC];
    [vc startLoadingHUD];
    [THHttpManager FormatPOST:@"goods/shopGoods/updateStatus" parameters:@{@"shopGoodsId":self.model.shopGoodsId} dataBlock:^(NSInteger returnCode, THRequestStatus status, id) {
        [vc stopLoadingHUD];
        if (returnCode == 200) {
            [vc showSuccessMessageWithString:@"编辑成功"];
            if (_viewBlock) {
                _viewBlock();
            }
        }
    }];
}

@end



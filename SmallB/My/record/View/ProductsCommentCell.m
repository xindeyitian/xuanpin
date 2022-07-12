//
//  ProductsCommentCell.m
//  SmallB
//
//  Created by zhang on 2022/4/9.
//

#import "ProductsCommentCell.h"

@interface  ProductsCommentCell ()

@property(nonatomic , strong)UIImageView *productImgV;
@property(nonatomic , strong)UIImageView *selectImgV;
@property(nonatomic , strong)UILabel *productTitleL;
@property(nonatomic , strong)UILabel *yongjinL;

@property(nonatomic , strong)UILabel *yongjinLab;
@property(nonatomic , strong)UILabel *allpriceLab;

@property(nonatomic , strong)UIView *yongjinV;

@end

@implementation ProductsCommentCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    
    self.contentView.backgroundColor = KBGColor;

    self.selectImgV = [[UIImageView alloc]init];
    self.selectImgV.image = IMAGE_NAMED(@"all_select_select");
    [self.bgView addSubview:self.selectImgV];
    self.selectImgV.hidden = YES;
    [self.selectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(12);
        make.width.height.mas_equalTo(24);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
    }];
    
    self.productImgV = [[UIImageView alloc]init];
    self.productImgV.layer.cornerRadius = 4;
    self.productImgV.layer.masksToBounds = YES;
    [self.productImgV setImage:KPlaceholder_DefaultImage];
    [self.bgView addSubview:self.productImgV];
    [self.productImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(12);
        make.top.mas_equalTo(self.bgView).offset(12);
        make.bottom.mas_equalTo(self.bgView).offset(-12);
        make.width.mas_equalTo(self.bgView.mas_height).offset(-24);
    }];
    
    self.productTitleL = [[UILabel alloc]init];
    self.productTitleL.font = BOLD_FONT_R(15);
    self.productTitleL.textColor = KBlack333TextColor;
    self.productTitleL.text = @"";
    self.productTitleL.numberOfLines = 2;
    [self.bgView addSubview:self.productTitleL];
    [self.productTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productImgV.mas_right).offset(12);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.top.mas_equalTo(self.productImgV.mas_top);
    }];

    UIView *yongjinView = [[UIView alloc]init];
    yongjinView.backgroundColor = [UIColor colorWithHexString:@"#FFECE3"];
    [self.bgView addSubview:yongjinView];
    yongjinView.layer.cornerRadius = 4;
    yongjinView.layer.masksToBounds = YES;
    [yongjinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productTitleL.mas_left);
        make.top.mas_equalTo(self.productTitleL.mas_bottom).offset(10);
        make.height.mas_equalTo(15);
    }];
    self.yongjinV = yongjinView;
    
    self.yongjinLab = [UILabel creatLabelWithTitle:@"" textColor:KOrangeTextColor textAlignment:NSTextAlignmentLeft font:DIN_Medium_FONT_R(12)];
    [self.bgView addSubview:self.yongjinLab];
    [self.yongjinLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productTitleL.mas_left);
        make.top.mas_equalTo(self.productTitleL.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    self.yongjinLab.hidden = YES;

    UIImageView *yongjinImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"product_hot_image"]];
    [yongjinView addSubview:yongjinImgV];
    [yongjinImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(yongjinImgV.superview).offset(5);
        make.top.mas_equalTo(yongjinImgV.superview).offset(3);
        make.height.width.mas_equalTo(10);
    }];
    
    UILabel *yongjinPriceL = [[UILabel alloc] initWithFrame:CGRectZero];
    yongjinPriceL.backgroundColor = UIColor.clearColor;
    yongjinPriceL.textColor = KJianBianTextColor;
    yongjinPriceL.font = [UIFont systemFontOfSize:11];
    yongjinPriceL.text = @"";
    [yongjinView addSubview:yongjinPriceL];
    [yongjinPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(yongjinImgV.mas_right).offset(3);
        make.bottom.mas_equalTo(yongjinView.mas_bottom);
        make.height.mas_equalTo(15);
        make.right.mas_equalTo(yongjinPriceL.superview).offset(-4);
    }];
    self.yongjinL = yongjinPriceL;
    
    NSString *titleStr = [AppTool getCurrentLevalBtnInfo];
    UIButton *addShopwindowBtn = [BaseButton CreateBaseButtonTitle:titleStr Target:self Action:@selector(addShopWindow) Font:[UIFont systemFontOfSize:12] BackgroundColor:UIColor.redColor Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    [addShopwindowBtn setImage:IMAGE_NAMED([AppTool getCurrentLevalBtnImageName]) forState:UIControlStateNormal];
    addShopwindowBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    addShopwindowBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    addShopwindowBtn.layer.cornerRadius = 15;
    addShopwindowBtn.layer.masksToBounds = YES;
    [self.bgView addSubview:addShopwindowBtn];
    [addShopwindowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).offset(-12);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
        make.bottom.mas_equalTo(self.productImgV.mas_bottom);
    }];
    
    UILabel *priceLable = [[UILabel alloc] initWithFrame:CGRectZero];
    priceLable.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    priceLable.font = DIN_Medium_FONT_R(25);
    priceLable.text = @"";
    [self.bgView addSubview:priceLable];
    [priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productTitleL.mas_left);
        make.bottom.mas_equalTo(self.productImgV.mas_bottom);
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(addShopwindowBtn.mas_left).offset(-10);
    }];
    self.allpriceLab = priceLable;
}

- (void)setDataModel:(GoodsListVosModel *)dataModel{
    _dataModel = dataModel;
    
    self.productTitleL.text = dataModel.goodsName;
    [self.productImgV sd_setImageWithURL:[NSURL URLWithString:dataModel.goodsThumb] placeholderImage:KPlaceholder_DefaultImage];
    
    self.yongjinL.text = [NSString stringWithFormat:@"高佣%@%@赚积分%@",dataModel.feeRate,@"%",dataModel.commission];
    
    self.selectImgV.image = dataModel.isSelect ? IMAGE_NAMED(@"all_select_selected") : IMAGE_NAMED(@"all_select_select");
    
    NSString *newprice = [NSString stringWithFormat:@"¥%@",dataModel.salePrice];
    NSString *oldprice = [NSString stringWithFormat:@"¥%@",dataModel.marketPrice];
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",newprice,oldprice]];
    NSRange oldPriceRange = NSMakeRange(newprice.length+1,oldprice.length);
    [attributeMarket setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:oldPriceRange];
    [attributeMarket addAttribute:NSForegroundColorAttributeName value:KBlack999TextColor range:oldPriceRange];
    [attributeMarket addAttribute:NSFontAttributeName value:DIN_Regular_FONT_R(12) range:oldPriceRange];
    [attributeMarket addAttribute:NSFontAttributeName value:DIN_Medium_FONT_R(18) range:NSMakeRange(0, 1)];
    if ([newprice containsString:@"."]) {
        NSString *first = [newprice componentsSeparatedByString:@"."].firstObject;
        [attributeMarket addAttribute:NSFontAttributeName value:DIN_Medium_FONT_R(18) range:NSMakeRange(first.length, newprice.length - first.length)];
    }
    self.allpriceLab.attributedText = attributeMarket;
}
    
- (void)addShopWindow{
    [AppTool roleBtnClickWithID:self.dataModel.goodsId withModel:self.dataModel];
}

- (void)setIsManager:(BOOL)isManager{
    _isManager = isManager;
    [self.productImgV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(isManager ? 48 : 12);
    }];
    self.selectImgV.hidden = !_isManager;
}

- (void)setShowYongJin:(BOOL)showYongJin{
    _showYongJin = showYongJin;
    self.yongjinV.hidden = showYongJin;
    self.yongjinLab.hidden = !showYongJin;
}

@end


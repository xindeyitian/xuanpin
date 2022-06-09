//
//  RankListContentTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/7.
//

#import "RankListContentTableViewCell.h"

@interface  RankListContentTableViewCell ()

@property(nonatomic , strong)UIImageView *productImgV;
@property(nonatomic , strong)UILabel *productTitleL;
@property(nonatomic , strong)UIView *lineV;

@property(nonatomic , strong)UILabel *yongjinLab;
@property(nonatomic , strong)UILabel *hasSoldLab;
@property(nonatomic , strong)UILabel *allpriceLab;

@end

@implementation RankListContentTableViewCell

- (void)k_creatSubViews {
    
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.productImgV = [[UIImageView alloc]init];
    self.productImgV.layer.cornerRadius = 4;
    self.productImgV.layer.masksToBounds = YES;
    [self.bgView addSubview:self.productImgV];
    [self.productImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(12);
        make.top.mas_equalTo(self.bgView).offset(12);
        make.height.width.mas_equalTo(94);
    }];
    
    self.topImgV = [[UIImageView alloc]init];
    [self.bgView addSubview:self.topImgV];
    [self.topImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(16);
        make.top.mas_equalTo(self.bgView).offset(6);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(35);
    }];
    self.topImgV.hidden = YES;
    
    self.productTitleL = [[UILabel alloc]init];
    self.productTitleL.font = BOLD_FONT_R(15);
    self.productTitleL.textColor = KBlack333TextColor;
    self.productTitleL.text = @"";
    [self.bgView addSubview:self.productTitleL];
    [self.productTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productImgV.mas_right).offset(12);
        make.right.mas_equalTo(self.bgView).offset(-7);
        make.top.mas_equalTo(self.productImgV.mas_top);
        make.height.mas_equalTo(25);
    }];

    UILabel *soldLable = [[UILabel alloc] initWithFrame:CGRectZero];
    soldLable.backgroundColor = [UIColor colorWithHexString:@"#FFECE3"];
    soldLable.textColor = KJianBianTextColor;
    soldLable.font = DEFAULT_FONT_R(11);
    soldLable.myWidth = MyLayoutSize.wrap;
    soldLable.layer.cornerRadius = 2;
    soldLable.layer.masksToBounds = YES;
    soldLable.text = @"";
    [self.bgView addSubview:soldLable];
    [soldLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productTitleL.mas_left);
        make.top.mas_equalTo(soldLable.superview).offset(50);
        make.height.mas_equalTo(20);
    }];
    self.hasSoldLab = soldLable;

    UILabel *yongjinlable = [[UILabel alloc] initWithFrame:CGRectZero];
    yongjinlable.textColor = KOrangeTextColor;
    yongjinlable.font = DEFAULT_FONT_R(12);
    yongjinlable.text = @"";
    yongjinlable.textAlignment = NSTextAlignmentRight;
    yongjinlable.weight = 1;
    [self.bgView addSubview:yongjinlable];
    [yongjinlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).offset(-14);
        make.top.mas_equalTo(soldLable.mas_top);
        make.height.mas_equalTo(20);
    }];
    self.yongjinLab = yongjinlable;

    UIButton *addShopwindowBtn = [BaseButton CreateBaseButtonTitle:[AppTool getCurrentLevalBtnInfo] Target:self Action:@selector(addShopWindow) Font:[UIFont systemFontOfSize:12] BackgroundColor:UIColor.redColor Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    [addShopwindowBtn setImage:IMAGE_NAMED([AppTool getCurrentLevalBtnImageName]) forState:UIControlStateNormal];
    addShopwindowBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    addShopwindowBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    addShopwindowBtn.layer.cornerRadius = 15;
    addShopwindowBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:addShopwindowBtn];
    [addShopwindowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).offset(-12);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(90);
        make.bottom.mas_equalTo(self.productImgV.mas_bottom);
    }];
    
    UILabel *priceLable = [[UILabel alloc] initWithFrame:CGRectZero];
    priceLable.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    priceLable.font = DIN_Bold_FONT_R(14);
    priceLable.text = @"";
    [self.bgView addSubview:priceLable];
    [priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productTitleL.mas_left);
        make.bottom.mas_equalTo(self.productImgV.mas_bottom);
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(addShopwindowBtn.mas_left).offset(-10);
    }];
    self.allpriceLab = priceLable;
    
//    self.lineV = [[UIView alloc]init];
//    self.lineV.backgroundColor = KBlackLineColor;
//    [self.bgView addSubview:self.lineV];
//    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.bgView).offset(12);
//        make.right.mas_equalTo(self.bgView).offset(-12);
//        make.bottom.mas_equalTo(self.bgView).offset(-0.5);
//        make.height.width.mas_equalTo(0.5);
//    }];
}

- (void)setModel:(GoodsListVosModel *)model{
    _model = model;
    
    self.productTitleL.text = model.goodsName;
    [self.productImgV sd_setImageWithURL:[NSURL URLWithString:model.goodsThumb] placeholderImage:KPlaceholder_DefaultImage];
    
    BOOL isRankList = self.cellType == contentCellTypeRankList;
    self.yongjinLab.hidden = !isRankList;
    if (isRankList) {
        self.hasSoldLab.text = [NSString stringWithFormat:@"已售%@件",model.saleCount];
        self.yongjinLab.text = [NSString stringWithFormat:@"赚积分%@",model.commission];
    }else{
        self.hasSoldLab.text = [NSString stringWithFormat:@"高佣%@%%赚积分%@",model.feeRate,model.commission];
    }
    self.allpriceLab.font =  isRankList ? BOLD_FONT_R(15) : BOLD_FONT_R(18);
    
    NSString *newprice = [NSString stringWithFormat:@"¥%@",model.salePrice];
    NSString *oldprice = [NSString stringWithFormat:@"¥%@",model.marketPrice];
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",newprice,oldprice]];
    NSRange oldPriceRange = NSMakeRange(newprice.length+1,oldprice.length);
    [attributeMarket setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:oldPriceRange];
    [attributeMarket addAttribute:NSForegroundColorAttributeName value:KBlack333TextColor range:oldPriceRange];
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_R(11) range:oldPriceRange];
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_R(12) range:NSMakeRange(0, 1)];
    self.allpriceLab.attributedText = attributeMarket;
}

-(void)setCellType:(contentCellType)cellType{
    _cellType = cellType;
}

- (void)addShopWindow{
    [AppTool roleBtnClickWithID:self.model.goodsId withModel:self.model];
}

@end

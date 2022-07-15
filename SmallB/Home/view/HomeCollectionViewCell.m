//
//  HomeCollectionViewCell.m
//  SmallB
//
//  Created by 张昊男 on 2022/4/6.
//

#import "HomeCollectionViewCell.h"

@interface HomeCollectionViewCell()

@property (strong, nonatomic) UIImageView    *productImage;
@property (strong, nonatomic) UILabel        *productName;
@property (strong, nonatomic) UILabel        *productprice;
@property (strong, nonatomic) UILabel        *productSoldNum;
@property (strong, nonatomic) UILabel        *commissionNum;
@property (strong, nonatomic) UIButton       *addShopWindowBtn;
@property (strong, nonatomic)MyLinearLayout *numLay;
@property (strong, nonatomic)MyLinearLayout *bottomLay;

@end

@implementation HomeCollectionViewCell
- (void)addShopWindow:(UIButton *)sender{
    
    [AppTool roleBtnClickWithID:self.model.goodsId withModel:self.model];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)setModel:(GoodsListVosModel *)model{
    _model = model;
    self.productName.text = model.goodsName;
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:model.goodsThumb] placeholderImage:KPlaceholder_DefaultImage];
    self.productSoldNum.text = [NSString stringWithFormat:@" 已售%@ ",K_NotNullHolder(model.saleCount, @"0")];
    self.commissionNum.text = [NSString stringWithFormat:@" 赚积分 %.2f ",[K_NotNullHolder(model.commission, @"0") floatValue]];
    
    NSString *price = [NSString stringWithFormat:@"¥%@",model.salePrice];
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:price];
    NSString *last = [price componentsSeparatedByString:@"."].lastObject;
    [attributeMarket addAttribute:NSFontAttributeName value:DIN_Medium_FONT_R(18) range:NSMakeRange(price.length - last.length,last.length)];
    [attributeMarket addAttribute:NSFontAttributeName value:DIN_Medium_FONT_R(18) range:NSMakeRange(0,1)];
    if (![price containsString:@"."]) {
        [attributeMarket addAttribute:NSFontAttributeName value:DIN_Medium_FONT_R(25) range:NSMakeRange(1,price.length-1)];
    }
    self.productprice.attributedText = attributeMarket;
    
    self.numLay.hidden = self.bottomLay.hidden = self.productName.hidden = model.isFirst;
    self.rootLy.padding = UIEdgeInsetsMake(0, 0,model.isFirst ? 0: 12, 0);
    self.productImage.myHeight = model.isFirst ? (ScreenWidth - 31) / 2: ((ScreenWidth - 31) / 2) * 3 / 4;
}

- (void)initView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.layer.cornerRadius = 8;
    self.rootLy.layer.masksToBounds = YES;
    self.rootLy.myWidth = (ScreenWidth - 31) / 2;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.padding = UIEdgeInsetsMake(0, 0, 12, 0);
    self.rootLy.cacheEstimatedRect = YES;
    self.rootLy.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.rootLy];
    
    self.productImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.productImage.myHorzMargin = 0;
    self.productImage.myHeight = ((ScreenWidth - 31) / 2) * 3 / 4;
    self.productImage.contentMode = UIViewContentModeScaleAspectFill;
    self.productImage.layer.masksToBounds = YES;
    [self.rootLy addSubview:self.productImage];

    self.productName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productName.myHorzMargin = 12;
    self.productName.myHeight = MyLayoutSize.wrap;
    self.productName.myTop = 8;
    self.productName.numberOfLines = 2;
    self.productName.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    self.productName.textColor = UIColor.blackColor;
    self.productName.text = @"";
    [self.rootLy addSubview:self.productName];
    
    MyLinearLayout *numLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    numLy.myHorzMargin = 12;
    numLy.myHeight = 35;
    numLy.myTop = 5;
    numLy.gravity = MyGravity_Vert_Center;
    [self.rootLy addSubview:numLy];
    self.numLay = numLy;
    
    self.productprice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productprice.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.productprice.font = DIN_Medium_FONT_R(25);
    self.productprice.text = @"";
    self.productprice.myWidth = MyLayoutSize.wrap;
    self.productprice.myHeight = 35;
    [numLy addSubview:self.productprice];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 35;
    [numLy addSubview:nilView];
    
    self.productSoldNum = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productSoldNum.textColor = [UIColor colorWithHexString:@"#999999"];
    self.productSoldNum.font = [UIFont systemFontOfSize:12];
    self.productSoldNum.myWidth = MyLayoutSize.wrap;
    self.productSoldNum.myHeight = 20;
    self.productSoldNum.text = @"";
    [numLy addSubview:self.productSoldNum];
    
    MyLinearLayout *bottomLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    bottomLy.myHorzMargin = 12;
    bottomLy.myHeight = 25;
    bottomLy.myTop = 8;
    bottomLy.gravity = MyGravity_Vert_Center;
    [self.rootLy addSubview:bottomLy];
    self.bottomLay = bottomLy;
    
    self.commissionNum = [[UILabel alloc] initWithFrame:CGRectZero];
    self.commissionNum.myWidth = MyLayoutSize.wrap;
    self.commissionNum.myHeight = 15;
    self.commissionNum.layer.cornerRadius = 4;
    self.commissionNum.layer.masksToBounds = YES;
    self.commissionNum.backgroundColor = [UIColor colorWithHexString:@"#FFECE3"];
    self.commissionNum.textColor = [UIColor colorWithHexString:@"#FF6010"];
    self.commissionNum.textAlignment = NSTextAlignmentCenter;
    self.commissionNum.text = @"";
    self.commissionNum.font = [UIFont systemFontOfSize:11];
    [bottomLy addSubview:self.commissionNum];
    
    UIView *nilView1 = [[UIView alloc] initWithFrame:CGRectZero];
    nilView1.weight = 1;
    nilView1.myHeight = 25;
    [bottomLy addSubview:nilView1];
    
    NSString *titleStr = [AppTool getCurrentLevalBtnInfo];
    self.addShopWindowBtn = [BaseButton CreateBaseButtonTitle:titleStr Target:self Action:@selector(addShopWindow:) Font:[UIFont systemFontOfSize:12] BackgroundColor:KMainBGColor Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    self.addShopWindowBtn.myWidth = 76;
    self.addShopWindowBtn.myHeight = 25;
    self.addShopWindowBtn.layer.cornerRadius = 12.5;
    self.addShopWindowBtn.layer.masksToBounds = YES;
    [bottomLy addSubview:self.addShopWindowBtn];
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    return [self.rootLy sizeThatFits:targetSize];
}

@end

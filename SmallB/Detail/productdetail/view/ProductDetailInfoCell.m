//
//  ProductDetailInfoCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/8.
//

#import "ProductDetailInfoCell.h"

#define cycleViewHeight 375

@interface ProductDetailInfoCell()<SDCycleScrollViewDelegate>

@property (strong, nonatomic) SDCycleScrollView *cycleView;
@property (strong, nonatomic) UILabel           *pageLable, *productTitle, *productPrice, *soldNum, *yongjin;
@property (strong, nonatomic) MyLinearLayout    *rootLy, *infoLy;
@property (strong, nonatomic) UIView *yongjinBGView;

@end

@implementation ProductDetailInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    [self.contentView addSubview:self.rootLy];
    
    self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
    self.cycleView.showPageControl = NO;
    self.cycleView.autoScroll = YES;
    self.cycleView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
    self.cycleView.backgroundColor = UIColor.whiteColor;
    self.cycleView.myWidth = ScreenWidth;
    self.cycleView.myHeight = ScreenWidth;
    [self.rootLy addSubview:self.cycleView];
    
    UILabel *pageCtl = [[UILabel alloc] initWithFrame:CGRectZero];
    pageCtl.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    pageCtl.myWidth = 44;
    pageCtl.myHeight = 22;
    pageCtl.myTop = -34;
    pageCtl.myLeft = ScreenWidth - 44 - 12;
    pageCtl.layer.cornerRadius = 11;
    pageCtl.layer.masksToBounds = YES;
    pageCtl.text = @"";
    pageCtl.font = [UIFont systemFontOfSize:12];
    pageCtl.textAlignment = NSTextAlignmentCenter;
    pageCtl.textColor = KWhiteTextColor;
    [self.rootLy addSubview:pageCtl];
    self.pageLable = pageCtl;
    
    self.infoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.infoLy.myTop = 12;
    self.infoLy.myHorzMargin = 0;
    self.infoLy.myHeight = MyLayoutSize.wrap;
    self.infoLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    self.infoLy.backgroundColor = UIColor.whiteColor;
    [self.rootLy addSubview:self.infoLy];
    
    self.productTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productTitle.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    self.productTitle.numberOfLines = 0;
    self.productTitle.myHorzMargin = 0;
    self.productTitle.myHeight = MyLayoutSize.wrap;
    self.productTitle.textColor = UIColor.blackColor;
    self.productTitle.text = @"";
    [self.infoLy addSubview:self.productTitle];
    
    MyLinearLayout *numLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    numLy.myHorzMargin = 0;
    numLy.myHeight = MyLayoutSize.wrap;
    numLy.gravity = MyGravity_Vert_Center;
    numLy.myTop = 8;
    [self.infoLy addSubview:numLy];
    
    self.productPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productPrice.font = DIN_Medium_FONT_R(25);
    self.productPrice.textColor = KMaintextColor;
    self.productPrice.myWidth = MyLayoutSize.wrap;
    self.productPrice.myHeight = 33;
    [numLy addSubview:self.productPrice];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.weight = 1;
    view.myHeight = 33;
    view.backgroundColor = UIColor.whiteColor;
    [numLy addSubview:view];
    
    self.soldNum = [[UILabel alloc] initWithFrame:CGRectZero];
    self.soldNum.font = [UIFont systemFontOfSize:12];
    self.soldNum.textColor = [UIColor colorWithHexString:@"#999999"];
    self.soldNum.myWidth = MyLayoutSize.wrap;
    self.soldNum.myHeight = 20;
    self.soldNum.text = @"";
    [numLy addSubview:self.soldNum];
    
    float width = 20.0f;
    
    UIView *yongjinV = [[UIView alloc]initWithFrame:CGRectMake(12, 0, width, 30)];
    [self.infoLy addSubview:yongjinV];
    self.yongjinBGView = yongjinV;
    
    UIImageView *image = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"home_product_qianbao")];
    image.frame = CGRectMake(8, 8, 14, 14);
    [yongjinV addSubview:image];
    
    self.yongjin = [[UILabel alloc] initWithFrame:CGRectZero];
    self.yongjin.myWidth = width;
    self.yongjin.myHeight = 22;
    self.yongjin.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.yongjin.text = @"";
    self.yongjin.font = DEFAULT_FONT_M(12);
    self.yongjin.frame = CGRectMake(26, 0, width, 30);
    [yongjinV addSubview:self.yongjin];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    self.pageLable.text = [NSString stringWithFormat:@"%ld/%lu",index+1,(unsigned long)self.detailModel.productImgAry.count];
}

- (void)setDetailModel:(ProductDetailModel *)detailModel{
    _detailModel = detailModel;
    self.productTitle.text = detailModel.goodsName;
    
    self.soldNum.text = [NSString stringWithFormat:@"已售: %@",detailModel.saleCount];

    self.cycleView.imageURLStringsGroup = detailModel.productImgAry;
    if (detailModel.productImgAry.count) {
        self.pageLable.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)detailModel.productImgAry.count];
    }
   
    NSString *titleStr = [NSString stringWithFormat:@"赚积分 %@",K_NotNullHolder(detailModel.commission, @"")];
    float width = [titleStr sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:DEFAULT_FONT_M(12), NSFontAttributeName, nil]].width+1;
    self.yongjinBGView.frame = CGRectMake(12, 0, width + 34, 30);
    self.yongjinBGView.backgroundColor = [UIColor bm_colorGradientChangeWithSize:self.yongjinBGView.size direction:IHGradientChangeDirectionLevel startColor:kRGB(255, 212, 212) endColor:kRGB(255, 227, 197)];
    self.yongjin.text = titleStr;
    self.yongjin.frame = CGRectMake(26, 0, width, 30);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.yongjinBGView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(4, 4)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.yongjinBGView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.yongjinBGView.layer.mask = maskLayer;

    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.yongjinBGView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(12, 12)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.yongjinBGView.bounds;
    maskLayer1.path = maskPath1.CGPath;
    self.yongjinBGView.layer.mask = maskLayer1;
    
    NSString *newprice = [NSString stringWithFormat:@"¥%@",detailModel.salePrice];
    NSString *oldprice = [NSString stringWithFormat:@"¥%@",detailModel.marketPrice];
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",newprice,oldprice]];
    NSRange oldPriceRange = NSMakeRange(newprice.length+1,oldprice.length);
    [attributeMarket setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:oldPriceRange];
    [attributeMarket addAttribute:NSForegroundColorAttributeName value:KBlack999TextColor range:oldPriceRange];
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_R(15) range:oldPriceRange];
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_R(15) range:NSMakeRange(0, 1)];
    self.productPrice.attributedText = attributeMarket;
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end

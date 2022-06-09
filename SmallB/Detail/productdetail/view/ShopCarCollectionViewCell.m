//
//  ShopCarCollectionViewCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/3/26.
//

#import "ShopCarCollectionViewCell.h"

@interface ShopCarCollectionViewCell()

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) UIImageView    *productImage;
@property (strong, nonatomic) UILabel        *productName;
@property (strong, nonatomic) UILabel        *productprice;
@property (strong, nonatomic) UILabel        *productDiscounts;
@property (strong, nonatomic) UIButton       *addShopWindowBtn;

@end

@implementation ShopCarCollectionViewCell
- (void)setItemWithModel:(ShopCarModel *)model{
    
    self.productName.text = model.productName;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.layer.cornerRadius = 8;
    self.rootLy.layer.masksToBounds = YES;
    self.rootLy.myWidth = (ScreenWidth - 32) / 2;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.backgroundColor = UIColor.whiteColor;
    self.rootLy.paddingBottom = 12;
    [self.contentView addSubview:self.rootLy];
    
    self.productImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.productImage.myHorzMargin = 0;
    self.productImage.myHeight = ((ScreenWidth - 32.0) / 2.0) * 3 / 4;
    self.productImage.contentMode = UIViewContentModeScaleAspectFill;
    self.productImage.layer.masksToBounds = YES;
    [self.rootLy addSubview:self.productImage];

    self.productName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productName.myHorzMargin = 12;
    self.productName.myHeight = MyLayoutSize.wrap;
    self.productName.myTop = 8;
    self.productName.numberOfLines = 2;
    self.productName.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    self.productName.textColor = [UIColor colorWithHexString:@"333333"];
    self.productName.text = @"";
    [self.rootLy addSubview:self.productName];
    
    self.productDiscounts = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productDiscounts.textColor = [UIColor colorWithHexString:@"#F65200"];
    self.productDiscounts.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    self.productDiscounts.myHorzMargin = 12;
    self.productDiscounts.myHeight = 20;
    self.productDiscounts.text = @"满199立减20";
    self.productDiscounts.myTop = 4;
    [self.rootLy addSubview:self.productDiscounts];
    
    MyLinearLayout *numLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    numLy.myHorzMargin = 12;
    numLy.myHeight = 35;
    numLy.myTop = 4;
    numLy.gravity = MyGravity_Vert_Center;
    [self.rootLy addSubview:numLy];
    
    self.productprice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productprice.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.productprice.font = DIN_Medium_FONT_R(25);
    self.productprice.text = @"¥99.90";
    self.productprice.myWidth = MyLayoutSize.wrap;
    self.productprice.myHeight = 35;
    [numLy addSubview:self.productprice];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 35;
    [numLy addSubview:nilView];
    
    self.addShopWindowBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(addShopCar) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"addShopCar" HeightLightBackgroundImage:@"addShopCar"];
    self.addShopWindowBtn.myWidth = 30;
    self.addShopWindowBtn.myHeight = 30;
    [numLy addSubview:self.addShopWindowBtn];
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
-(UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGSize size = [self.rootLy systemLayoutSizeFittingSize: layoutAttributes.size];
    CGRect cellFrame = layoutAttributes.frame;
    cellFrame.size.height = size.height;
    layoutAttributes.frame = cellFrame;
    return layoutAttributes;
}
@end

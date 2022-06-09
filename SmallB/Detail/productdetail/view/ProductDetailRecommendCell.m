//
//  ProductDetailRecommendCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/8.
//

#import "ProductDetailRecommendCell.h"

@interface ProductDetailRecommendCell()

@property (strong, nonatomic) MyLinearLayout *rootLy, *productLy;

@end

@implementation ProductDetailRecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    
    //root 布局
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.rootLy.padding = UIEdgeInsetsMake(0, 0, 12, 0);
    [self.contentView addSubview:self.rootLy];
    
    //内容布局
    MyLinearLayout *contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    contentLy.myHorzMargin = 12;
    contentLy.myHeight = MyLayoutSize.wrap;
    contentLy.layer.cornerRadius = 8;
    contentLy.layer.masksToBounds = YES;
    contentLy.backgroundColor = UIColor.whiteColor;
    contentLy.padding = UIEdgeInsetsMake(12, 12, 16, 12);
    contentLy.gravity = MyGravity_Horz_Center;
    [self.rootLy addSubview:contentLy];
    
    MyLinearLayout *titleLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    titleLy.myHorzMargin = 0;
    titleLy.myHeight = 25;
    titleLy.gravity = MyGravity_Vert_Center;
    [contentLy addSubview:titleLy];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectZero];
    line.backgroundColor = UIColor.redColor;
    line.myWidth = 3;
    line.myHeight = 13;
    line.layer.cornerRadius = 1.5;
    line.layer.masksToBounds = YES;
    [titleLy addSubview:line];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    title.text = @"为你推荐";
    title.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    title.textColor = UIColor.blackColor;
    title.myLeft = 4;
    title.myWidth = title.myHeight = MyLayoutSize.wrap;
    [titleLy addSubview:title];
    
    self.productLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.productLy.myHorzMargin = 0;
    self.productLy.myHeight = MyLayoutSize.wrap;
    self.productLy.gravity = MyGravity_Vert_Center;
    self.productLy.subviewHSpace = 8;
    self.productLy.myTop = 16;
    [contentLy addSubview:self.productLy];
    
    for (int i = 0; i < 3; i++) {
        
        [self addProductWith];
    }
}
- (void)addProductWith{
    
    MyLinearLayout *productLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    productLy.myWidth = (ScreenWidth - 64) / 3;
    productLy.myHeight = MyLayoutSize.wrap;
    productLy.subviewVSpace = 5;
    [self.productLy addSubview:productLy];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectZero];
    img.myWidth = img.myHeight = (ScreenWidth - 64) / 3;
    img.layer.cornerRadius = 5;
    img.layer.masksToBounds = YES;
    [productLy addSubview:img];
    
    UILabel *nowPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    nowPrice.font = [UIFont systemFontOfSize:12];
    nowPrice.textColor = UIColor.redColor;
    nowPrice.myHorzMargin = 0;
    nowPrice.myHeight = 20;
    nowPrice.text = @"￼￼拉夏贝尔欧…";
    [productLy addSubview:nowPrice];
    
    UILabel *oldprice = [[UILabel alloc] initWithFrame:CGRectZero];
    oldprice.font = DIN_Medium_FONT_R(12);
    oldprice.textColor = UIColor.redColor;
    oldprice.myHorzMargin = 0;
    oldprice.myHeight = 20;
    oldprice.text = @"¥99.99";
    [productLy addSubview:oldprice];
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end

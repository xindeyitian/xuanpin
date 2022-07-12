//
//  ProductDetailCommentHeaderView.m
//  SmallB
//
//  Created by zhang on 2022/4/24.
//

#import "ProductDetailCommentHeaderView.h"
#import "ProductDetailCommentViewController.h"
#import "rightPushView.h"

@interface ProductDetailCommentHeaderView ()

@property (nonatomic , strong)UILabel *titleL;
@property (nonatomic , strong)rightPushView *rightView;

@end

@implementation ProductDetailCommentHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
   
    self.backgroundColor = KBGColor;
    
    UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(12, 12, ScreenWidth - 24, self.frame.size.height-12)];
    whiteV.backgroundColor = KWhiteBGColor;
    [self addSubview:whiteV];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:whiteV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = whiteV.bounds;
    maskLayer.path = maskPath.CGPath;
    whiteV.layer.mask = maskLayer;
    
    UILabel *title = [UILabel creatLabelWithTitle:@"评价" textColor:KBlack666TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    title.frame = CGRectMake(12, 12, ScreenWidth - 36 - 100, 35);
    [whiteV addSubview:title];
    self.titleL = title;
    
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:@"评价（0)"];
    NSRange range = NSMakeRange(0,2);
    [attributeMarket addAttribute:NSForegroundColorAttributeName value:KBlack333TextColor range:range];
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_M(17) range:range];
    title.attributedText = attributeMarket;

    rightPushView *rightV = [[rightPushView alloc]initWithFrame:CGRectMake(ScreenWidth-36 - 120, 0, 120, 20)];
    rightV.centerY = title.centerY;
    rightV.imageNameString = @"my_right_gray";
    rightV.titleL.textColor = KMaintextColor;
    rightV.titleL.font = DEFAULT_FONT_R(12);
    rightV.imageHeight = 16;
    [whiteV addSubview:rightV];
    rightV.viewClickBlock = ^{
        ProductDetailCommentViewController *vc = [[ProductDetailCommentViewController alloc]init];
        vc.productID = self.productID;
        [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
    };
    self.rightView = rightV;

}

- (void)setDetailModel:(ProductDetailModel *)detailModel{
    _detailModel = detailModel;
    if (detailModel.appraisesListVoPage) {
        NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"评价（%@)",detailModel.appraisesListVoPage.total]];
        NSRange range = NSMakeRange(0,2);
        [attributeMarket addAttribute:NSForegroundColorAttributeName value:KBlack333TextColor range:range];
        [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_M(17) range:range];
        self.titleL.attributedText = attributeMarket;
    }
    if (detailModel.applauseRate) {
        NSMutableAttributedString *attributeM = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"好评度 %@%%",_detailModel.applauseRate]];
        NSRange rang = NSMakeRange(0,3);
        [attributeM addAttribute:NSForegroundColorAttributeName value:KBlack333TextColor range:rang];
        self.rightView.titleL.attributedText = attributeM;
    }
}

@end


@implementation ProductDetailNoCommentHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
   
    self.backgroundColor = KBGColor;
    
    UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(12, 12, ScreenWidth - 24, 77)];
    whiteV.backgroundColor = KWhiteBGColor;
    [self addSubview:whiteV];
    whiteV.clipsToBounds = YES;
    whiteV.layer.cornerRadius = 8;
    
    UILabel *title = [UILabel creatLabelWithTitle:@"评价" textColor:KBlack666TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    title.frame = CGRectMake(12, 12, ScreenWidth - 48, 25);
    [whiteV addSubview:title];
    
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:@"评价（0)"];
    NSRange range = NSMakeRange(0,2);
    [attributeMarket addAttribute:NSForegroundColorAttributeName value:KBlack333TextColor range:range];
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_M(17) range:range];
    title.attributedText = attributeMarket;
    
    UILabel *content = [UILabel creatLabelWithTitle:@"暂时还没有评价哦~" textColor:KBlack666TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    content.frame = CGRectMake(12, 45, ScreenWidth - 48, 20);
    [whiteV addSubview:content];
}

@end

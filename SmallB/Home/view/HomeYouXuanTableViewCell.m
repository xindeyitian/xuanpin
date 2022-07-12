//
//  HomeYouXuanTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/20.
//

#import "HomeYouXuanTableViewCell.h"

@interface HomeYouXuanTableViewCell ()<UIScrollViewDelegate,XHPageControlDelegate>

@property (nonatomic , strong)UIView *BGView;
@property (nonatomic , strong)XHPageControl *pageCon;
@property (nonatomic , strong)UIScrollView *scrolView;

@end

@implementation HomeYouXuanTableViewCell

-(void)k_creatSubViews{
    [super k_creatSubViews];
    
    self.contentView.backgroundColor = KViewBGColor;
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, ScreenWidth - 24, 20)];
    bgView.backgroundColor = KWhiteBGColor;
    [self.contentView addSubview:bgView];
    self.BGView = bgView;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.BGView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.BGView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.BGView.layer.mask = maskLayer;
    
    UIScrollView *scrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 24, 240)];
    scrol.contentSize = CGSizeMake((ScreenWidth - 24)*3, 0);
    scrol.delegate = self;
    scrol.showsHorizontalScrollIndicator = NO;
    scrol.pagingEnabled = YES;
    [bgView addSubview:scrol];
    self.scrolView = scrol;
    
    XHPageControl  *pageControl = [[XHPageControl alloc] initWithFrame:CGRectMake(0, 252,[UIScreen mainScreen].bounds.size.width, 15)];
    pageControl.numberOfPages = 3;
    pageControl.otherMultiple = 1;
    pageControl.currentMultiple = 2;
    pageControl.type = PageControlMiddle;
    pageControl.otherColor = KViewBGColor;
    pageControl.currentColor= KMaintextColor;
    pageControl.delegate = self;
    [bgView addSubview:pageControl];
    self.pageCon = pageControl;
    
    self.scrolView.hidden = self.pageCon.hidden = YES;
}

- (void)setModel:(BlockDefineGoodsVosModel *)model{
    _model = model;

    self.BGView.hidden = self.scrolView.hidden = self.pageCon.hidden = NO;
    self.BGView.frame = CGRectMake(12, 0, ScreenWidth - 24, 275);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.BGView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.BGView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.BGView.layer.mask = maskLayer;
    
    [self.scrolView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSMutableArray *dataAry = [NSMutableArray arrayWithArray:model.goodsListVos];
    
    NSInteger num = dataAry.count%2 == 0 ? dataAry.count/2 : dataAry.count/2+1;
    self.pageCon.numberOfPages = num;
    self.scrolView.contentSize = CGSizeMake((ScreenWidth - 24)*num, 0);
    
    for (int i =0; i < num; i ++) {
        YouXuanProductView *view = [[YouXuanProductView alloc]initWithFrame:CGRectMake((ScreenWidth - 24)*i, 0, ScreenWidth - 24, 120)];
        GoodsListVosModel *model = [dataAry objectAtIndex:i *2];
        view.goodModel = model;
        [self.scrolView addSubview:view];
        
        if (dataAry.count%2 != 0 && i == num -1) {
            
        }else{
            YouXuanProductView *view1 = [[YouXuanProductView alloc]initWithFrame:CGRectMake((ScreenWidth - 24)*i, 120, ScreenWidth - 24, 120)];
            GoodsListVosModel *model1 = [dataAry objectAtIndex:i *2+1];
            view1.goodModel = model1;
            [self.scrolView addSubview:view1];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/(ScreenWidth - 24);
    self.pageCon.currentPage = index;
}

@end

@interface YouXuanProductView ()

@property(nonatomic , strong)UIImageView *productImgV;
@property(nonatomic , strong)UILabel *productTitleL;
@property(nonatomic , strong)UIView *lineV;

@property(nonatomic , strong)UILabel *yongjinLab;
@property(nonatomic , strong)UILabel *hasSoldLab;
@property(nonatomic , strong)UILabel *allpriceLab;

@end

@implementation YouXuanProductView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    self.backgroundColor = UIColor.clearColor;
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)]];
    
    self.productImgV = [[UIImageView alloc]init];
    self.productImgV.layer.cornerRadius = 4;
    self.productImgV.layer.masksToBounds = YES;
    [self addSubview:self.productImgV];
    [self.productImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(12);
        make.top.mas_equalTo(self).offset(12);
        make.height.width.mas_equalTo(94);
    }];
    
    self.productTitleL = [[UILabel alloc]init];
    self.productTitleL.font = FONTWEIGHT_MEDIUM_FONT_R(15);
    self.productTitleL.textColor = KBlack333TextColor;
    self.productTitleL.text = @"范德萨范德萨范德萨发";
    [self addSubview:self.productTitleL];
    [self.productTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productImgV.mas_right).offset(12);
        make.right.mas_equalTo(self).offset(-7);
        make.top.mas_equalTo(self.productImgV.mas_top);
        make.height.mas_equalTo(20);
    }];

    UILabel *soldLable = [[UILabel alloc] initWithFrame:CGRectZero];
    soldLable.backgroundColor = [UIColor colorWithHexString:@"#FFECE3"];
    soldLable.textColor = KJianBianTextColor;
    soldLable.font = DEFAULT_FONT_R(11);
    soldLable.myWidth = MyLayoutSize.wrap;
    soldLable.layer.cornerRadius = 2;
    soldLable.layer.masksToBounds = YES;
    soldLable.text = @" 已售0件 ";
    [self addSubview:soldLable];
    [soldLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productTitleL.mas_left);
        make.top.mas_equalTo(soldLable.superview).offset(54);
        make.height.mas_equalTo(20);
    }];
    self.hasSoldLab = soldLable;

    UILabel *yongjinlable = [[UILabel alloc] initWithFrame:CGRectZero];
    yongjinlable.textColor = KOrangeTextColor;
    yongjinlable.font = DEFAULT_FONT_R(12);
    yongjinlable.text = @"";
    yongjinlable.textAlignment = NSTextAlignmentRight;
    yongjinlable.weight = 1;
    [self addSubview:yongjinlable];
    [yongjinlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-14);
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
    [self addSubview:addShopwindowBtn];
    [addShopwindowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-12);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
        make.bottom.mas_equalTo(self.productImgV.mas_bottom);
    }];
    
    UILabel *priceLable = [[UILabel alloc] initWithFrame:CGRectZero];
    priceLable.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    priceLable.font = DIN_Medium_FONT_R(17);
    priceLable.text = @"¥108.88";
    [self addSubview:priceLable];
    [priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productTitleL.mas_left);
        make.bottom.mas_equalTo(self.productImgV.mas_bottom);
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(addShopwindowBtn.mas_left).offset(-10);
    }];
    self.allpriceLab = priceLable;
}

- (void)setGoodModel:(GoodsListVosModel *)goodModel{
    _goodModel = goodModel;
    [self.productImgV sd_setImageWithURL:[NSURL URLWithString:goodModel.goodsThumb] placeholderImage:KPlaceholder_DefaultImage];
    self.productTitleL.text = goodModel.goodsName;
    self.hasSoldLab.text = [NSString stringWithFormat:@" 已售%@件 ",goodModel.saleCount];
    self.yongjinLab.text = [NSString stringWithFormat:@"赚积分 %@",goodModel.commission];
    
    NSString *newprice = [NSString stringWithFormat:@"¥%@",goodModel.salePrice];
    NSString *oldprice = [NSString stringWithFormat:@"¥%@",goodModel.marketPrice];
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",newprice,oldprice]];
    NSRange oldPriceRange = NSMakeRange(newprice.length+1,oldprice.length);
    [attributeMarket setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:oldPriceRange];
    [attributeMarket addAttribute:NSForegroundColorAttributeName value:KBlack999TextColor range:oldPriceRange];
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_R(11) range:oldPriceRange];
    [attributeMarket addAttribute:NSFontAttributeName value:DIN_Medium_FONT_R(13) range:NSMakeRange(0, 1)];
    self.allpriceLab.attributedText = attributeMarket;
}

- (void)tapClick{
    [AppTool GoToProductDetailWithID:self.goodModel.goodsId];
}

- (void)addShopWindow{
    [AppTool roleBtnClickWithID:self.goodModel.goodsId withModel:self.goodModel];
}

@end

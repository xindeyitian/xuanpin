//
//  HomeRecommendTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/20.
//

#import "HomeRecommendTableViewCell.h"
#import "MerchantDetailBaseViewController.h"

@interface HomeRecommendTableViewCell ()<UIScrollViewDelegate,XHPageControlDelegate>

@property (nonatomic , strong)XHPageControl *pageControl;
@property (nonatomic , strong)UIScrollView *scrolView;
@property (nonatomic , strong)UIView *BGView;

@end

@implementation HomeRecommendTableViewCell

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
    
    float height = 252 - 76 + 76*KScreenW_Ratio - 20;
    
    UIScrollView *scrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 24, height)];
    scrol.contentSize = CGSizeMake((ScreenWidth - 24)*3, 0);
    scrol.delegate = self;
    scrol.showsHorizontalScrollIndicator = NO;
    scrol.pagingEnabled = YES;
    scrol.userInteractionEnabled = YES;
    [bgView addSubview:scrol];
    
    for (int i =0; i < 3; i ++) {
        HomeRecommendStoreView *storeV = [[HomeRecommendStoreView alloc]initWithFrame:CGRectMake((ScreenWidth-24)*i, 0, ScreenWidth-24, height)];
        storeV.haveBtn = self.haveBtn;
        [scrol addSubview:storeV];
    }
    self.scrolView = scrol;

    XHPageControl *pageC = [[XHPageControl alloc] initWithFrame:CGRectMake(0, height+3,[UIScreen mainScreen].bounds.size.width, 15)];
    pageC.numberOfPages = 3;
    pageC.otherMultiple = 1;
    pageC.currentMultiple = 2;
    pageC.type = PageControlMiddle;
    pageC.otherColor = KViewBGColor;
    pageC.currentColor= KMaintextColor;
    pageC.delegate = self;
    [bgView addSubview:pageC];
    self.pageControl = pageC;
    
    self.scrolView.hidden = self.pageControl.hidden = YES;
    
    UIView *blackV = [[UIView alloc]initWithFrame:CGRectMake(0, height, ScreenWidth, 20)];
    blackV.backgroundColor = UIColor.blueColor;
    //[bgView addSubview:blackV];
}

- (void)setModel:(BlockDefineGoodsVosModel *)model{
    _model = model;
    
    float height = 252 - 76 + 76*KScreenW_Ratio;
    self.BGView.frame = CGRectMake(12, 0, ScreenWidth - 24, height);
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.BGView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.BGView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.BGView.layer.mask = maskLayer;
    
    self.scrolView.hidden = self.pageControl.hidden = NO;
    NSMutableArray *array = [NSMutableArray arrayWithArray:model.brandConceptVos];
    
    [self.scrolView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.pageControl.numberOfPages = array.count;
    self.scrolView.contentSize = CGSizeMake((ScreenWidth - 24)*array.count, 0);
    
    self.BGView.userInteractionEnabled = self.scrolView.userInteractionEnabled = YES;
    
    for (int i =0; i < array.count; i ++) {
        BrandConceptVosModel *goodModel = array[i];
        HomeRecommendStoreView *storeV = [[HomeRecommendStoreView alloc]initWithFrame:CGRectMake((ScreenWidth-24)*i, 0, ScreenWidth-24, height - 28)];
        storeV.haveBtn = YES;
        storeV.goodModel = goodModel;
        [self.scrolView addSubview:storeV];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/(ScreenWidth - 24);
    self.pageControl.currentPage = index;
}

-(void)xh_PageControlClick:(XHPageControl*)pageControl index:(NSInteger)clickIndex{
   
}

@end

@implementation HomeRecommendStoreView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    
    self.userInteractionEnabled = YES;
    
    UIImageView *image = [[UIImageView alloc]init];
    image.frame = CGRectMake(12, 12, 44, 44);
    image.clipsToBounds = YES;
    image.layer.cornerRadius = 4;
    [self addSubview:image];
    self.logoImgV = image;
   
    UILabel *title = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(17)];
    title.frame = CGRectMake(66, 12, ScreenWidth - 78 - 24, 25);
    [self addSubview:title];
    self.titleL = title;
    
    UILabel *subTitle = [UILabel creatLabelWithTitle:@"" textColor:KBlack999TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    subTitle.frame = CGRectMake(66, 36, ScreenWidth - 78 -24, 20);
    [self addSubview:subTitle];
    self.subtitleL = subTitle;
    
    UIButton *rightBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(btnClick) Font:[UIFont systemFontOfSize:12] BackgroundColor:UIColor.clearColor Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    [rightBtn setImage:IMAGE_NAMED(@"my_right_gray") forState:UIControlStateNormal];
    [rightBtn setImage:IMAGE_NAMED(@"my_right_gray") forState:UIControlStateHighlighted];
    rightBtn.frame = CGRectMake(ScreenWidth - 36 - 20, 20, 20, 28);
    [self addSubview:rightBtn];
    self.pushBtn = rightBtn;
    
    self.attentionBtn = [BaseButton CreateBaseButtonTitle:@"关注" Target:self Action:@selector(attentionBtnClicked:) Font:[UIFont systemFontOfSize:12] BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.attentionBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    self.attentionBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.attentionBtn.layer.cornerRadius = 14;
    self.attentionBtn.layer.masksToBounds = YES;
    [self.attentionBtn setImage:IMAGE_NAMED(@"store_attention") forState:UIControlStateNormal];
    [self.attentionBtn setTitle:@"已关注" forState:UIControlStateSelected];
    self.attentionBtn.frame = CGRectMake(ScreenWidth - 24 - 107, 20, 70, 28);
    [self addSubview:self.attentionBtn];
    self.pushBtn.hidden = self.attentionBtn.hidden = YES;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(12, 12, ScreenWidth - 48, 44)];
    [btn addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    float width = 76*KScreenW_Ratio;
    for (int i =0; i < 4; i ++) {
        StoreProductView *view = [[StoreProductView alloc]initWithFrame:CGRectMake(12*KScreenW_Ratio+(width + 8*KScreenW_Ratio)*i, 73, width, width +76)];
        view.tag = 200+i;
        [self addSubview:view];
    }
}

- (void)setGoodModel:(BrandConceptVosModel *)goodModel{
    _goodModel = goodModel;
    self.titleL.text = goodModel.supplyName;
    self.subtitleL.text = [NSString stringWithFormat:@"共%@款",goodModel.goodsCount];
    [self.logoImgV sd_setImageWithURL:[NSURL URLWithString:goodModel.logoImgUrl] placeholderImage:KPlaceholder_DefaultImage];

    NSMutableArray *productAry = [NSMutableArray arrayWithArray:goodModel.goodsListVos];
   
    NSInteger num = 4;
    if (productAry.count < 4) {
        num = productAry.count;
    }
    for (int i =0; i < 4; i ++) {
        StoreProductView *view = [self viewWithTag:200+i];
        view.hidden = YES;;
    }
    for (int i =0; i < num; i ++) {
        GoodsListVosModel *model = productAry[i];
        StoreProductView *view = [self viewWithTag:200+i];
        view.hidden = NO;
        view.goodModel = model;
    }
}

- (void)setHaveBtn:(BOOL)haveBtn{
    _haveBtn = haveBtn;
    self.pushBtn.hidden = self.attentionBtn.hidden = !haveBtn;
    float btnWidth = haveBtn ? 100 : 0;
    btnWidth = 0;
    self.subtitleL.frame = CGRectMake(66, 36, ScreenWidth - 78 -24 - btnWidth, 20);
    self.titleL.frame = CGRectMake(66, 12, ScreenWidth - 78 - 24 - btnWidth, 25);
    self.attentionBtn.hidden = YES;
}

- (void)btnClick{
    MerchantDetailBaseViewController *vc = [[MerchantDetailBaseViewController alloc]init];
    vc.supplierID = self.goodModel.supplyId;
    [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
}

- (void)detailClick{
    MerchantDetailBaseViewController *vc = [[MerchantDetailBaseViewController alloc]init];
    vc.supplierID = self.goodModel.supplyId;
    [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
}

- (void)attentionBtnClicked:(BaseButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        btn.backgroundColor = UIColor.clearColor;
        btn.layer.borderColor = KBlack999TextColor.CGColor;
        btn.layer.borderWidth = 1;
        [btn setTitleColor:KBlack999TextColor forState:UIControlStateNormal];
    }else{
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        btn.backgroundColor = KMainBGColor;
        btn.layer.borderWidth = 0;
        [btn setTitleColor:KWhiteTextColor forState:UIControlStateNormal];
    }
}

@end

@interface StoreProductView ()

@property (nonatomic , strong)UIImageView *productImgV;
@property (nonatomic , strong)UILabel *productPriceL;
@property (nonatomic , strong)UILabel *zhuanL;
@property (nonatomic , strong)UILabel *numL;

@end

@implementation StoreProductView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)]];
    
    float width = self.frame.size.width;
    
    UIImageView *image = [[UIImageView alloc]initWithImage:KPlaceholder_DefaultImage];
    image.frame = CGRectMake(0, 0, width, width);
    image.clipsToBounds = YES;
    image.layer.cornerRadius = 4;
    [self addSubview:image];
    self.productImgV = image;
   
    UILabel *num = [UILabel creatLabelWithTitle:@"" textColor:KWhiteTextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(10)];
    num.frame = CGRectMake(0, width - 20, 0, 16);
    num.backgroundColor = kRGBA(0, 0, 0, 0.55);
    num.layer.cornerRadius = 8;
    num.clipsToBounds = YES;
    [image addSubview:num];
    self.numL = num;
    
    UILabel *price = [UILabel creatLabelWithTitle:@"" textColor:KMaintextColor textAlignment:NSTextAlignmentCenter font:DIN_Medium_FONT_R(17)];
    price.frame = CGRectMake(5, width, width - 10, 25);
    [self addSubview:price];
    self.productPriceL = price;
    
    UILabel *zhuan = [UILabel creatLabelWithTitle:@"" textColor:KBlack999TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(11)];
    zhuan.frame = CGRectMake(5, width+25, width - 10, 20);
    [self addSubview:zhuan];
    self.zhuanL = zhuan;
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:[AppTool getCurrentLevalBtnInfo] Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_R(12) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:13];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 13;
    btn.frame = CGRectMake(5, width+50, width - 10, 26);
    [self addSubview:btn];
}

- (void)setGoodModel:(GoodsListVosModel *)goodModel{
    _goodModel = goodModel;
    [self.productImgV sd_setImageWithURL:[NSURL URLWithString:goodModel.goodsThumb] placeholderImage:KPlaceholder_DefaultImage];

    self.zhuanL.text = [NSString stringWithFormat:@"赚积分 %@",goodModel.commission];
    
    float width = self.frame.size.width;
    NSString *string = [NSString stringWithFormat:@"  热销:%@  ",goodModel.saleCount];
    float biaoqian = [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:DEFAULT_FONT_R(10), NSFontAttributeName, nil]].width;
    self.numL.frame = CGRectMake(width/2.0 - biaoqian/2.0, width - 20, biaoqian, 16);
    self.numL.backgroundColor = kRGBA(0, 0, 0, 0.55);
    self.numL.layer.cornerRadius = 8;
    self.numL.clipsToBounds = YES;
    self.numL.text = string;
    
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",goodModel.salePrice]];
    NSRange range = NSMakeRange(0,1);
    [attributeMarket addAttribute:NSFontAttributeName value:DEFAULT_FONT_M(13) range:range];
    self.productPriceL.attributedText = attributeMarket;
}

- (void)tapClick{
    [AppTool GoToProductDetailWithID:self.goodModel.goodsId];
}

- (void)btnClick{
    NSLog(@"234567");
    [AppTool roleBtnClickWithID:self.goodModel.goodsId withModel:self.goodModel];
}

@end

//
//  ProductDetailStoreCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/8.
//

#import "ProductDetailStoreCell.h"
#import "MerchantDetailBaseViewController.h"

@interface ProductDetailStoreCell()

@property (strong, nonatomic) MyLinearLayout *rootLy, *productLy;
@property (strong, nonatomic) UIImageView    *storeImg;
@property (strong, nonatomic) UILabel        *storeName, *noticeLable;

@end

@implementation ProductDetailStoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
    }
    return self;
}

- (void)initCustomView{
    self.contentView.backgroundColor = KBGColor;
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, ScreenWidth - 24, 200+76*KScreenW_Ratio)];
    whiteView.backgroundColor = KWhiteBGColor;
    [self.contentView addSubview:whiteView];
    whiteView.clipsToBounds = YES;
    whiteView.layer.cornerRadius = 8;
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 24, 70)];
    imgV.image = IMAGE_NAMED(@"product_detail_store_bg");
    [whiteView addSubview:imgV];
    
    imgV.userInteractionEnabled = YES;
    [imgV addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)]];
    
    self.storeImg = [[UIImageView alloc] initWithImage:KPlaceholder_DefaultImage];
    self.storeImg.frame = CGRectMake(12, 12, 44, 44);
    self.storeImg.layer.cornerRadius = 4;
    self.storeImg.clipsToBounds = YES;
    [imgV addSubview:self.storeImg];
    
    self.storeName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.storeName.font = DEFAULT_FONT_M(15);
    self.storeName.textColor = KBlack333TextColor;
    self.storeName.frame = CGRectMake(68, 12, ScreenWidth - 24 - 80, 23);
    [whiteView addSubview:self.storeName];
    
    self.noticeLable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.noticeLable.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    self.noticeLable.textColor = KBlack999TextColor;
    self.noticeLable.frame = CGRectMake(68, 36, ScreenWidth - 24 - 80, 20);
    [whiteView addSubview:self.noticeLable];
    
    //右箭头
    UIImageView *right = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"youjiantou")];
    right.myWidth = right.myHeight = 18;
    right.frame = CGRectMake(ScreenWidth - 24 - 30, 0, 18, 18);
    right.centerY = self.storeImg.centerY;
    [whiteView addSubview:right];
    
    UIButton *enterStore = [BaseButton CreateBaseButtonTitle:@"进店逛逛" Target:self Action:@selector(goToStoreDetail) Font:[UIFont systemFontOfSize:12] BackgroundColor:UIColor.whiteColor Color:UIColor.blackColor Frame:CGRectMake(0, 144+76*KScreenW_Ratio, 125, 40) Alignment:NSTextAlignmentCenter Tag:1];
    enterStore.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
    enterStore.layer.borderWidth = 1;
    enterStore.layer.cornerRadius = 20;
    enterStore.layer.masksToBounds = YES;
    enterStore.centerX = whiteView.centerX;
    [whiteView addSubview:enterStore];
    
    for (int i = 0; i < 4; i++) {
        [self addProductWithIndex:i view:whiteView];
    }
}

- (void)tapClick{
    [self goToStoreDetail];
}

- (void)goToStoreDetail{
    
    MerchantDetailBaseViewController *vc = [[MerchantDetailBaseViewController alloc] init];
    vc.supplierID = self.model.supplyId;
    [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
}

- (void)addProductWithIndex:(NSInteger)index view:(UIView *)bgView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(12*KScreenW_Ratio + 84*KScreenW_Ratio * index, 70, 76*KScreenW_Ratio, 76*KScreenW_Ratio + 60)];
    view.backgroundColor = KWhiteBGColor;
    [bgView addSubview:view];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 76*KScreenW_Ratio, 76*KScreenW_Ratio)];
    img.layer.cornerRadius = 5;
    img.layer.masksToBounds = YES;
    [img setImage:IMAGE_NAMED(@"")];
    img.tag = 111+index;
    [view addSubview:img];
    
    float y = 76*KScreenW_Ratio;
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, y + 4, 76*KScreenW_Ratio, 20)];
    name.font = [UIFont systemFontOfSize:12];
    name.textColor = [UIColor colorWithHexString:@"#000000"];
    name.text = @"￼￼";
    name.numberOfLines = 1;
    name.tag = 121+index;
    [view addSubview:name];
    
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(0, y + 24, 76*KScreenW_Ratio, 20)];
    price.font = DIN_Medium_FONT_R(8);
    price.textColor = KMaintextColor;
    price.text = @"";
    price.tag = 131+index;
    [view addSubview:price];
    
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(0, y + 44, 76*KScreenW_Ratio, 20)];
    num.font = DEFAULT_FONT_R(11);
    num.textColor = KBlack999TextColor;
    num.tag = 141+index;
    [view addSubview:num];
}

-(void)setModel:(ProductDetailModel *)model{
    _model = model;
    
    [self.storeImg sd_setImageWithURL:[NSURL URLWithString:model.supplyInfoGoodsVo.logoImgUrl] placeholderImage:KPlaceholder_DefaultImage];
    
    self.storeName.text = model.supplyInfoGoodsVo.supplyName;
    self.noticeLable.text = [NSString stringWithFormat:@"%@人关注",model.supplyInfoGoodsVo.collectCount];
    
    NSInteger num = model.supplyInfoGoodsVo.goodsListVos.count  > 4 ? 4:model.supplyInfoGoodsVo.goodsListVos.count;
    for (int i =0; i < num; i ++) {
        GoodsListVosModel *goodsModel = model.supplyInfoGoodsVo.goodsListVos[i];
        UIImageView *img = [self viewWithTag:111+i];
        UILabel *name = [self viewWithTag:121+i];
        UILabel *price = [self viewWithTag:131+i];
        UILabel *num = [self viewWithTag:141+i];
        [img sd_setImageWithURL:[NSURL URLWithString:goodsModel.goodsThumb] placeholderImage:KPlaceholder_DefaultImage];
        name.text = goodsModel.goodsName;
        num.text = [NSString stringWithFormat:@"销量%@",goodsModel.saleCount];
        
        NSString *moneyStr = [NSString stringWithFormat:@"¥%@",goodsModel.salePrice];
        NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:moneyStr];
        NSString *money = @"";
        NSRange range;
        if ([moneyStr containsString:@"."]) {
            money = [goodsModel.salePrice componentsSeparatedByString:@"."].firstObject;
            range = NSMakeRange(1,money.length);
        }else{
            money = moneyStr;
            range = NSMakeRange(1,money.length-1);
        }
        [attributeMarket addAttribute:NSFontAttributeName value:DIN_Medium_FONT_R(12) range:range];
        price.attributedText = attributeMarket;
    }
}

@end

//
//  ProductDetailBottomView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/8.
//

#import "ProductDetailBottomView.h"
#import "MerchantDetailBaseViewController.h"
#import "chatAlertViewController.h"

@interface ProductDetailBottomView()

@property (strong, nonatomic) MyLinearLayout *rootLy, *productLy;
@property (strong, nonatomic) DKSButton *buyBtn;
@property (strong, nonatomic) DKSButton *collectionBtn;
@property (strong, nonatomic) DKSButton *chatBtn;

@end

@implementation ProductDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{

    for (int i = 0; i < 2; i ++) {
        
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(ScreenWidth - 20 - 206*KScreenW_Ratio + (103 *KScreenW_Ratio+8)*i, 10, 103*KScreenW_Ratio, 44);
        [btn setTitle:i == 0 ? @"转发赚":@"立即购买" forState:UIControlStateNormal];
        if ([AppTool getCurrentLevalIsAdd]) {
            [btn setTitle:i == 0 ? @"加入橱窗":@"立即购买" forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 114+i ;
        btn.titleLabel.font = DEFAULT_FONT_R(11);
        btn.titleLabel.numberOfLines = 2;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.textColor = KBlack333TextColor;
        btn.layer.cornerRadius = 22;
        btn.clipsToBounds = YES;
        btn.backgroundColor = i == 1 ? KMainBGColor : KOrangeBGtColor;
        [self addSubview:btn];
    }
    
    float width = (ScreenWidth - 226*KScreenW_Ratio - 13  - 12 *3)/3.0;
    
    NSArray *array = @[@"店铺",@"客服",@"收藏"];
    NSArray *imageAry = @[@"product_detail_store",@"product_detail_store_chat",@"product_detail_collection"];
    for (int i = 0; i < array.count; i ++) {
        
        DKSButton *btn = [[DKSButton alloc]init];
        btn.padding = 4;
        btn.buttonStyle = DKSButtonImageTop;
        btn.frame = CGRectMake(12*KScreenW_Ratio + (12 *KScreenW_Ratio +width)*i, 10, width, 44);
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 111+i ;
        [btn setTitleColor:KBlack333TextColor forState:UIControlStateNormal];
        btn.titleLabel.font = DEFAULT_FONT_R(11);
        [btn setImage:IMAGE_NAMED(imageAry[i]) forState:UIControlStateNormal];
        [btn setImage:IMAGE_NAMED(imageAry[i]) forState:UIControlStateHighlighted];
        if ( i == 2) {
            [btn setImage:IMAGE_NAMED(@"product_detail_collectioned") forState:UIControlStateSelected];
            [btn setTitleColor:KMaintextColor forState:UIControlStateSelected];
            [btn setTitle:@"已收藏" forState:UIControlStateSelected];
            self.collectionBtn = btn;
        }
        if (i == 1) {
            self.chatBtn = btn;
        }
        [btn layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyleTop) imageTitleSpace:0];
        [self addSubview:btn];
    }
}

- (void)setModel:(ProductDetailModel *)model{
    _model = model;
    
    UIButton *shareBtn = [self viewWithTag:114];
    UIButton *buyBtn = [self viewWithTag:115];
    [shareBtn setTitle:[NSString stringWithFormat:@"转发赚\n¥%@",model.commission] forState:UIControlStateNormal];
    [buyBtn setTitle:[NSString stringWithFormat:@"立即购买\n¥%@",model.salePrice] forState:UIControlStateNormal];
    if ([AppTool getCurrentLevalIsAdd]) {
        [shareBtn setTitle:@"加入橱窗" forState:UIControlStateNormal];
        [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    }
    self.collectionBtn.selected = [model.ifCollect intValue] == 1;
    
    DKSButton *btn = [self viewWithTag:111];
    NSInteger num = 3;
    if (self.model.supplyInfoGoodsVo) {
        btn.hidden = NO;
    }else{
        btn.hidden = YES;
        num = 2;
        float width = (ScreenWidth - 226*KScreenW_Ratio - 13  - 12 *num)/num;
        self.collectionBtn.frame = CGRectMake(13 + (12+width)*1, 10, width, 44);
        self.chatBtn.frame = CGRectMake(13 + (12+width)*0, 10, width, 44);
    }
}

- (void)collectionBtnOperation:(BaseButton *)btn{
    NSString *url = @"goods/goodsInfo/saveGoodsCollect";
    NSDictionary *dica = @{@"goodsId":self.model.goodsId};
    [THHttpManager FormatPOST:url parameters:dica dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        if (returnCode == 200) {
            btn.selected = !btn.selected;
            [btn setTitle:btn.selected ? @"已收藏":@"收藏" forState:UIControlStateNormal];
            if (btn.selected) {
                //取消收藏
                [XHToast dismiss];
                [XHToast showCenterWithText:@"收藏成功" withName:@""];
            }else{
                [XHToast dismiss];
                [XHToast showCenterWithText:@"取消收藏成功"];
            }
        }
    }];
}

- (void)btnClick:(BaseButton *)btn{
    
    if (btn.tag == 113) {
        [self collectionBtnOperation:btn];
    }
    if (btn.tag == 112) {
        chatAlertViewController *vc = [[chatAlertViewController alloc]init];
        vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        vc.phoneStr = self.model.serviceTel;
        [[AppTool currentVC]  presentViewController:vc animated:NO completion:nil];
    }
    if (btn.tag == 111) {
        MerchantDetailBaseViewController *vc = [[MerchantDetailBaseViewController alloc] init];
        vc.supplierID = self.model.supplyId;
        [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 114) {
        GoodsListVosModel *productModel = [[GoodsListVosModel alloc]init];
        productModel.commission = self.model.commission;
        productModel.goodsId = self.model.goodsId;
        productModel.goodsName = self.model.goodsName;
        //productModel.goodsThumb = self.model.productImgAry.count ? self.model.productImgAry[0] : @"";
        productModel.marketPrice = self.model.marketPrice;
        productModel.saleCount = self.model.saleCount;
        productModel.salePrice = self.model.salePrice;

        [AppTool roleBtnClickWithID:self.model.goodsId withModel:productModel];
    }
    if (btn.tag == 115) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"LLWF:productID:%@&supplierID:%@",self.model.goodsId,self.model.supplyInfoGoodsVo.supplyId]]];
    }
}

@end

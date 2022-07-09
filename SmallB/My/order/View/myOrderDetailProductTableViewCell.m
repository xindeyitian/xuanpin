//
//  myOrderDetailProductTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/12.
//

#import "myOrderDetailProductTableViewCell.h"
#import "chatAlertViewController.h"

@interface myOrderDetailProductTableViewCell ()

@property(nonatomic , strong)UIImageView *productImgV;
@property(nonatomic , strong)UILabel *productpriceL;
@property(nonatomic , strong)UILabel *instrucL;
@property(nonatomic , strong)UILabel *numL;

@property(nonatomic , strong)UIView *lineV;

@property(nonatomic , strong)UILabel *yongjinL;
@property(nonatomic , strong)UILabel *hasSoldLab;
@property(nonatomic , strong)UILabel *allpriceLab;

@end

@implementation myOrderDetailProductTableViewCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    
    self.contentView.backgroundColor = KBGColor;

    UIImageView *productImgV = [[UIImageView alloc]init];
    [self.bgView addSubview:productImgV];
    [productImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(12);
        make.top.mas_equalTo(self.bgView).offset(12);
        make.height.width.mas_equalTo(72);
    }];
    self.productImgV = productImgV;

    UILabel *productprice = [[UILabel alloc]init];
    productprice.font = DIN_Medium_FONT_R(13);
    productprice.textAlignment = NSTextAlignmentRight;
    productprice.textColor = KBlack333TextColor;
    productprice.text = @"";
    [self.bgView addSubview:productprice];
    [productprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.top.mas_equalTo(productImgV.mas_top);
        make.height.mas_equalTo(22);
    }];
    self.productpriceL = productprice;
    
    UILabel *productName = [[UILabel alloc]init];
    productName.font = DEFAULT_FONT_M(13);
    productName.textAlignment = NSTextAlignmentLeft;
    productName.textColor = KBlack333TextColor;
    productName.text = @"";
    [self.bgView addSubview:productName];
    [productName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(productImgV.mas_right).offset(12);
        make.right.mas_equalTo(productprice.mas_left).offset(-12);
        make.top.mas_equalTo(productImgV.mas_top);
        make.height.mas_equalTo(22);
    }];
    self.productTitleL = productName;
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    view.clipsToBounds = YES;
    view.layer.cornerRadius = 10;
    [self.bgView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(productName.mas_left);
        make.top.mas_equalTo(productName.mas_bottom).offset(8);
    }];
    
    UILabel *instrucLable = [UILabel creatLabelWithTitle:@"" textColor:KBlack666TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(11)];
    [view addSubview:instrucLable];
    [instrucLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(12);
        make.right.mas_equalTo(view).offset(-12);
        make.top.mas_equalTo(view.mas_top);
        make.height.mas_equalTo(20);
    }];
    self.instrucL = instrucLable;
    
    UILabel *numLable = [UILabel creatLabelWithTitle:@"" textColor:KBlack666TextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_R(15)];
    [self.bgView addSubview:numLable];
    [numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.top.mas_equalTo(productprice.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    self.numL = numLable;
    
    UILabel *yongjinLable = [UILabel creatLabelWithTitle:@"" textColor:KMaintextColor textAlignment:NSTextAlignmentRight font:DIN_Medium_FONT_R(15)];
    yongjinLable.backgroundColor = UIColor.clearColor;
    [self.bgView addSubview:yongjinLable];
    [yongjinLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(12);
        make.bottom.mas_equalTo(self.bgView).offset(-12);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.height.mas_equalTo(24);
    }];
    self.yongjinL = yongjinLable;
}

- (void)setModel:(OrderListProductModel *)model{
    _model = model;
    [self.productImgV sd_setImageWithURL:[NSURL URLWithString:model.skuImgUrl] placeholderImage:[UIImage imageNamed:@"icon_image"]];
    self.productpriceL.text = [NSString stringWithFormat:@"¥%@",model.priceSale];
    self.productTitleL.text = model.goodsName;
    self.instrucL.text = model.skuName;
    self.numL.text = [NSString stringWithFormat:@"x%@",model.quantityTotal];
    self.yongjinL.text = [NSString stringWithFormat:@"积分 %@",K_NotNullHolder(model.moneyAgent, @"-")];
    self.yongjinL.hidden = self.type == 2;
}

@end

@interface myOrderDetailCommentTableViewCell ()

@property(nonatomic , strong)UILabel *leftL;
@property(nonatomic , strong)UILabel *rightL;
@property(nonatomic , strong)BaseButton *btn;

@end

@implementation myOrderDetailCommentTableViewCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    self.leftL = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(15)];
    [self.bgView addSubview:self.leftL];
    
    self.rightL = [UILabel creatLabelWithTitle:@"" textColor:KBlack666TextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_R(15)];
    self.rightL.numberOfLines = 0;
    [self.bgView addSubview:self.rightL];
    
    [self.leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.bgView);
        make.left.mas_equalTo(self.bgView).offset(12);
        make.right.mas_equalTo(self.rightL.mas_left).offset(-10);
    }];
    [self.rightL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.bgView);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.left.mas_equalTo(self.leftL.mas_right).offset(10);
    }];
    [self.leftL setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.rightL setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    self.btn = [BaseButton CreateBaseButtonTitle:@"复制" Target:self Action:@selector(copyClick) Font:DEFAULT_FONT_R(12) BackgroundColor:kRGBA(74, 154, 255, 0.11) Color:kRGBA(74, 154, 255, 1)  Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    self.btn.clipsToBounds = YES;
    self.btn.layer.cornerRadius = 4;
    [self.bgView addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self.rightL.mas_centerY);
    }];
}

- (void)copyClick{
    
    NSString *copyStr= [NSString stringWithFormat:@"订单号:%@",self.rightL.text];
    [AppTool copyWithString:self.rightL.text];
    [XHToast showCenterWithText:[NSString stringWithFormat:@"%@\n\n复制成功",copyStr]];
}

- (void)setDataModel:(orderDataModel *)dataModel{
    _dataModel = dataModel;
    self.leftL.text = _dataModel.titleStr;
    self.rightL.text = _dataModel.detailStr;
    self.rightL.textColor = _dataModel.rightColor ? : KBlack666TextColor;
    self.leftL.textColor = _dataModel.leftColor ? : KBlack333TextColor;
    self.leftL.font = _dataModel.leftFont ? : DEFAULT_FONT_R(15);
    self.rightL.font = _dataModel.rightFont ? : DEFAULT_FONT_R(15);
    self.btn.hidden = !_dataModel.showCopy;
    self.separatorLineView.hidden = !_dataModel.showLineV;
    if (_dataModel.showCopy) {
        float width = [_dataModel.detailStr sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:DEFAULT_FONT_R(15), NSFontAttributeName, nil]].width+1;
        [self.btn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bgView).offset(-12- width - 10);
        }];
    }
}

@end


@interface myOrderDetailChatTableViewCell ()

@end

@implementation myOrderDetailChatTableViewCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
   
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"客服" Target:self Action:@selector(chatClick) Font:DEFAULT_FONT_R(15) BackgroundColor:UIColor.clearColor Color:KBlack333TextColor Frame:CGRectMake(ScreenWidth/2.0 - 30, 12, 60, 25) Alignment:NSTextAlignmentCenter Tag:1];
    [btn setImage:IMAGE_NAMED(@"order_chat") forState:UIControlStateNormal];
    [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    [self.bgView addSubview:btn];
}

- (void)chatClick{
    [THHttpManager GET:@"commons/articleInfo/getArticleInfo" parameters:@{@"articleCode":@"ServiceTel"} block:^(NSInteger returnCode, THRequestStatus status, id data) {
        if (returnCode == 200 && [data isKindOfClass:[NSDictionary class]]) {
            chatAlertViewController *alertVC = [chatAlertViewController new];
            alertVC.phoneStr = [data objectForKey:@"content"];
            alertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [[AppTool currentVC] presentViewController:alertVC animated:NO completion:nil];
        }
    }];
}

@end

@interface myOrderDetailShouhouTableViewCell ()

@property(nonatomic , strong)UILabel *titleL;
@property(nonatomic , strong)UIView *photoView;
@property(nonatomic , strong)UIView *grayV;

@end

@implementation myOrderDetailShouhouTableViewCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
   
    UIView *grayView = [[UIView alloc]init];
    grayView.backgroundColor = KBGColor;
    grayView.layer.cornerRadius = 8;
    grayView.clipsToBounds = YES;
    [self.bgView addSubview:grayView];
    self.grayV = grayView;
    
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.bgView).insets(UIEdgeInsetsMake(0, 12, 12, 12));
    }];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
    title.numberOfLines = 0;
    [grayView addSubview:title];
    self.titleL = title;
    
    self.photoView= [[UIView alloc]init];
    self.photoView.backgroundColor = KBGColor;
    [grayView addSubview:self.photoView];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(grayView).offset(12);
        make.right.mas_equalTo(grayView).offset(-12);
        make.left.mas_equalTo(grayView).offset(12);
        //make.bottom.mas_equalTo(self.photoView.mas_top);
    }];
   
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom);
        make.right.mas_equalTo(grayView).offset(-12);
        make.left.mas_equalTo(grayView).offset(12);
        make.bottom.mas_equalTo(grayView.mas_bottom).offset(-12);
    }];
}

- (void)setDataModel:(orderDataModel *)dataModel{
    _dataModel = dataModel;
    self.titleL.text = dataModel.propertyData;
    
    NSArray *array = (NSArray *)dataModel.propertyDatAry;
    float oneWidth = (ScreenWidth - 72 - 16)/3.0;
    [self.photoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0; i < array.count; i ++) {
        UIImageView *img = [[UIImageView alloc]init];
        img.frame = CGRectMake((oneWidth + 8)*(i%3), 12+(oneWidth + 8)*(i/3), oneWidth, oneWidth);
        [self.photoView addSubview:img];
        
        if (i == array.count -1) {
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.photoView).offset((oneWidth + 8)*(i%3));
                make.top.mas_equalTo(self.photoView).offset(12+(oneWidth + 8)*(i/3));
                make.width.height.mas_equalTo(oneWidth);
                make.bottom.mas_equalTo(self.photoView.mas_bottom).offset(-12);
            }];
        }else{
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.photoView).offset((oneWidth + 8)*(i%3));
                make.top.mas_equalTo(self.photoView).offset(12+(oneWidth + 8)*(i/3));
                make.width.height.mas_equalTo(oneWidth);
            }];
        }
    }
}

@end

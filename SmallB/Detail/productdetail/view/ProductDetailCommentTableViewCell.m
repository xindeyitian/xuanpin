//
//  ProductDetailCommentTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/24.
//

#import "ProductDetailCommentTableViewCell.h"

@interface ProductDetailCommentTableViewCell ()

@property (nonatomic , strong)UILabel *useName;
@property (nonatomic , strong)UILabel *titleL;
@property (nonatomic , strong)UIImageView *userImageV;
@property (nonatomic , strong)UILabel *contentL;
@property (nonatomic , strong)UILabel *productL;

@property (nonatomic , strong)UIView *biaoQianView;
@property (nonatomic , strong)UIView *imageBGView;

@property (nonatomic , strong)JZLStarView *starView;

@end

@implementation ProductDetailCommentTableViewCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    
    self.separatorLineView.hidden = YES;
    self.contentView.backgroundColor = KBGColor;
    
    UIImageView *image = [[UIImageView alloc]init];
    image.clipsToBounds = YES;
    image.layer.cornerRadius = 17.5;
    [self.bgView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(12);
        make.left.mas_equalTo(self.bgView).offset(12);
        make.height.width.mas_equalTo(35);
    }];
    self.userImageV = image;
    
    JZLStarView *starView = [[JZLStarView alloc] initWithFrame:CGRectMake(0, 0, 67, 11) starCount:5 starStyle:WholeStar isAllowScroe:YES];
    starView.currentScore = 3;
    starView.tag = 11;
    starView.userInteractionEnabled = NO;
    [self.bgView addSubview:starView];
    self.starView  = starView;
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(image.mas_top).offset(12);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.width.mas_equalTo(67);
        make.height.mas_equalTo(11);
    }];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"一个苹果" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
    [self.bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(image.mas_top);
        make.right.mas_equalTo(starView.mas_left).offset(-12);
        make.left.mas_equalTo(image.mas_right).offset(10);
        make.height.mas_equalTo(35);
    }];
    self.titleL = title;
    
    UILabel *content = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(13)];
    content.numberOfLines = 0;
    [self.bgView addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.left.mas_equalTo(self.bgView).offset(12);
        make.top.mas_equalTo(image.mas_bottom).offset(8);
    }];
    self.contentL = content;
    
    UIView *biaoqianV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.biaoQianView = biaoqianV;
    [self.bgView addSubview:biaoqianV];
    
    UIView *imageBGV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.bgView addSubview:imageBGV];
    self.imageBGView = imageBGV;
    
    UILabel *product = [UILabel creatLabelWithTitle:@"" textColor:KBlack999TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    [self.bgView addSubview:product];
    [product mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.left.mas_equalTo(self.bgView).offset(12);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-12);
        make.height.mas_equalTo(20);
    }];
    self.productL = product;
}

- (void)setModel:(commentRecordModel *)model{
    _model = model;
    self.productL.text = model.goodsSkuName;
    [self.userImageV sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:KPlaceholder_DefaultImage];
    self.titleL.text = model.nickName;
    self.starView.currentScore = model.goodsScore.floatValue;
    
    self.contentL.text = model.content;
    if (model.biaoQianAry.count == 0) {
        [self.contentL mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.userImageV.mas_bottom).offset(8);
            //make.height.mas_equalTo(model.contentBGHeight);
        }];
        self.biaoQianView.hidden = YES;
    }else{
        self.biaoQianView.hidden = NO;
        [self.biaoQianView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bgView).offset(-12);
            make.left.mas_equalTo(self.bgView).offset(12);
            make.top.mas_equalTo(self.userImageV.mas_bottom);
            make.height.mas_equalTo(model.biaoQianBGHeight+8);
        }];
        [self.contentL mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.userImageV.mas_bottom).offset(8 + 8 + model.biaoQianBGHeight);
            //make.height.mas_equalTo(model.contentBGHeight);
        }];
        [self.biaoQianView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        for (int i = 0 ;i < model.biaoQianAry.count; i ++) {
            UILabel *type = [UILabel creatLabelWithTitle:@"商品很好用" textColor:KWhiteTextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(13)];
            type.backgroundColor = KOrangeBGtColor;
            type.frame = CGRectMake(0, 8, 80, 30);
            type.clipsToBounds = YES;
            type.layer.cornerRadius = 15;
            [self.biaoQianView addSubview:type];
        }
    }

    self.imageBGView.hidden = model.imageAry.count == 0;
    [self.imageBGView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.left.mas_equalTo(self.bgView).offset(12);
        make.top.mas_equalTo(self.contentL.mas_bottom);
        make.height.mas_equalTo(model.imageBGHeight + 8);
    }];
    [self.imageBGView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i =0; i < model.imageAry.count; i ++) {
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake( (model.oneImageHeight + 8) * (i%model.num), 8 +(model.oneImageHeight + 12) * (i/model.num), model.oneImageHeight, model.oneImageHeight)];
        [imgV sd_setImageWithURL:[NSURL URLWithString:model.imageAry[i]] placeholderImage:KPlaceholder_DefaultImage];
        [self.imageBGView addSubview:imgV];
    }
}

@end

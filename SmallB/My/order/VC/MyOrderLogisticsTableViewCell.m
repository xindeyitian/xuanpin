//
//  MyOrderLogisticsTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/27.
//

#import "MyOrderLogisticsTableViewCell.h"

@interface MyOrderLogisticsTableViewCell ()

@property(nonatomic , strong)UIImageView *productImgV;
@property(nonatomic , strong)UILabel *allpriceLab;
@property(nonatomic , strong)UIImageView *selectImgV;

@end

@implementation MyOrderLogisticsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews {
    
    self.contentView.backgroundColor = KBGColor;
    
    UIView *whiteBGV = [[UIView alloc]init];
    whiteBGV.backgroundColor = KWhiteBGColor;
    [self.contentView addSubview:whiteBGV];
    [whiteBGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 12, 0, 12));
    }];
    
    UIImageView *selectImg = [[UIImageView alloc]init];
    [selectImg setImage:IMAGE_NAMED(@"choose")];
    [whiteBGV addSubview:selectImg];
    [selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(whiteBGV).offset(11);
        make.top.mas_equalTo(whiteBGV).offset(39);
        make.height.width.mas_equalTo(18);
    }];
    self.selectImgV = selectImg;
    
    UIImageView *productImgV = [[UIImageView alloc]init];
    productImgV.clipsToBounds = YES;
    productImgV.layer.cornerRadius = 4;
    [whiteBGV addSubview:productImgV];
    [productImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selectImg.mas_right).offset(12);
        make.top.mas_equalTo(whiteBGV).offset(7);
        make.height.width.mas_equalTo(72);
    }];
  
    UILabel *productName = [[UILabel alloc]init];
    productName.font = DEFAULT_FONT_M(13);
    productName.textAlignment = NSTextAlignmentLeft;
    productName.textColor = KBlack333TextColor;
    productName.text = @"三只松鼠坚果";
    [whiteBGV addSubview:productName];
    [productName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(productImgV.mas_right).offset(12);
        make.right.mas_equalTo(whiteBGV).offset(-12);
        make.top.mas_equalTo(productImgV.mas_top);
        make.height.mas_equalTo(18);
    }];
    self.productTitleL = productName;
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    view.clipsToBounds = YES;
    view.layer.cornerRadius = 10;
    [whiteBGV addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(productName.mas_left);
        make.top.mas_equalTo(productName.mas_bottom).offset(8);
    }];
    
    UILabel *instrucLable = [UILabel creatLabelWithTitle:@"桶装每日坚果" textColor:KBlack666TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(11)];
    [view addSubview:instrucLable];
    [instrucLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(12);
        make.right.mas_equalTo(view).offset(-12);
        make.top.mas_equalTo(view.mas_top);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *numLable = [UILabel creatLabelWithTitle:@"x1" textColor:KBlack666TextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_R(15)];
    [whiteBGV addSubview:numLable];
    [numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(whiteBGV).offset(-12);
        make.bottom.mas_equalTo(productImgV.mas_bottom);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *productprice = [[UILabel alloc]init];
    productprice.font = DIN_Medium_FONT_R(13);
    productprice.textAlignment = NSTextAlignmentLeft;
    productprice.textColor = KBlack333TextColor;
    productprice.text = @"¥199.9";
    [whiteBGV addSubview:productprice];
    [productprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(productName.mas_left);
        make.bottom.mas_equalTo(productImgV.mas_bottom);
        make.height.mas_equalTo(22);
        make.right.mas_equalTo(numLable.mas_left).offset(-12);
    }];
}

@end

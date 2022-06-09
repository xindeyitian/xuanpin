//
//  BasePhotoTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/13.
//

#import "BasePhotoTableViewCell.h"

@interface BasePhotoTableViewCell ()
{
    float oneWidth;
}
@end

@implementation BasePhotoTableViewCell

-(void)k_creatSubViews{
    [super k_creatSubViews];
    
    oneWidth = (ScreenWidth - 48)/3.0;
    
    UILabel *title = [UILabel creatLabelWithTitle:@"其他行业经营资质" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(17)];
    [self.contentView addSubview:title];
    self.titleL = title;
    
    UILabel *subTitle = [UILabel creatLabelWithTitle:@"(特殊行业请上传经营资质，最多可上传6张)" textColor:kRGB(250, 119, 109) textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    [self.contentView addSubview:subTitle];
    self.subTitleL = subTitle;
    
    UIView *phototV = [[UIView alloc]init];
    phototV.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:phototV];
    self.allPhotoView = phototV;
    [phototV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(12);
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.top.mas_equalTo(subTitle.mas_bottom).offset(12);
        make.bottom.mas_equalTo(self.contentView).offset(-20);
    }];
    
    BaseButton *add = [[BaseButton alloc]initWithFrame:CGRectZero];
    [add addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [add setBackgroundImage:IMAGE_NAMED(@"my_supplier_app_btn") forState:UIControlStateNormal];
    [phototV addSubview:add];
    add.clipsToBounds = YES;
    add.layer.cornerRadius = 4;
    self.addBtn = add;
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(12);
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.top.mas_equalTo(self.contentView).offset(12);
        make.height.mas_equalTo(25);
    }];
    
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(12);
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.top.mas_equalTo(title.mas_bottom).offset(3);
        make.height.mas_equalTo(20);
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(oneWidth);
        make.left.top.mas_equalTo(phototV);
    }];
    
    self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(oneWidth-22, 4, 18, 18)];
    [self.deleteButton setImage:IMAGE_NAMED(@"supplier_add_photo_delete") forState:UIControlStateNormal];
    [self.deleteButton addTarget:self action:@selector(oneDeleteClick) forControlEvents:UIControlEventTouchUpInside];
    [self.addBtn addSubview:self.deleteButton];
    self.deleteButton.hidden = YES;
}

- (void)setPhotoAry:(NSMutableArray *)photoAry{
    _photoAry = photoAry;
    self.addBtn.hidden = YES;
    [self.allPhotoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    BOOL isMax = photoAry.count == 6;
    NSInteger num = isMax ? 6 : photoAry.count+1;
    for (int i =0; i < num; i ++) {
        UIButton *btn = [[UIButton alloc]init];
        [self.allPhotoView addSubview:btn];
        btn.frame = CGRectMake((oneWidth+12)*(i%3), (oneWidth+12)*(i/3), oneWidth, oneWidth);
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = 4;
        if ((!isMax && i == num -1) || photoAry.count == 0) {
            [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:IMAGE_NAMED(@"my_supplier_app_btn") forState:UIControlStateNormal];
        }else{
            btn.backgroundColor = UIColor.blueColor;
            
            UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(oneWidth-22, 4, 18, 18)];
            [deleteBtn setImage:IMAGE_NAMED(@"supplier_add_photo_delete") forState:UIControlStateNormal];
            deleteBtn.tag = 100+i;
            [btn addSubview:deleteBtn];
      
            [deleteBtn addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (i < photoAry.count) {
            [btn setBackgroundImage:photoAry[i] forState:UIControlStateNormal];
            [btn setBackgroundImage:photoAry[i] forState:UIControlStateHighlighted];
        }
    }
}

- (void)setYingyeImage:(UIImage *)yingyeImage{
    if (yingyeImage) {
        [self.addBtn setBackgroundImage:yingyeImage forState:UIControlStateNormal];
        [self.addBtn setBackgroundImage:yingyeImage forState:UIControlStateHighlighted];
        self.deleteButton.hidden = YES;
    }else{
        [self.addBtn setBackgroundImage:IMAGE_NAMED(@"my_supplier_app_btn") forState:UIControlStateNormal];
        [self.addBtn setBackgroundImage:IMAGE_NAMED(@"my_supplier_app_btn") forState:UIControlStateHighlighted];
        self.deleteButton.hidden = YES;
    }
}

- (void)btnClick{
    if (_viewClickBlock) {
        _viewClickBlock(YES,0);
    }
}

- (void)closeClick:(BaseButton *)btn{
    if (_viewClickBlock) {
        _viewClickBlock(NO,btn.tag - 100);
    }
}

- (void)oneDeleteClick{
    if (_viewClickBlock) {
        _viewClickBlock(NO,0);
    }
}

@end

@interface BaseOnePhotoTableViewCell ()
{
    float oneWidth;
}
@end

@implementation BaseOnePhotoTableViewCell

-(void)k_creatSubViews{
    [super k_creatSubViews];
    
    oneWidth = (ScreenWidth - 48)/3.0;
    
    UILabel *title = [UILabel creatLabelWithTitle:@"其他行业经营资质" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(17)];
    [self.contentView addSubview:title];
    self.titleL = title;
    
    UILabel *subTitle = [UILabel creatLabelWithTitle:@"(特殊行业请上传经营资质，最多可上传6张)" textColor:kRGB(250, 119, 109) textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
    [self.contentView addSubview:subTitle];
    self.subTitleL = subTitle;

    BaseButton *add = [[BaseButton alloc]initWithFrame:CGRectZero];
    [add addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [add setBackgroundImage:IMAGE_NAMED(@"my_supplier_app_btn") forState:UIControlStateNormal];
    [self.contentView addSubview:add];
    add.clipsToBounds = YES;
    add.layer.cornerRadius = 4;
    self.addBtn = add;
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(12);
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.top.mas_equalTo(self.contentView).offset(12);
        make.height.mas_equalTo(25);
    }];
    
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(12);
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.top.mas_equalTo(title.mas_bottom).offset(3);
        make.height.mas_equalTo(20);
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(oneWidth);
        make.left.mas_equalTo(self.contentView).offset(12);
        make.bottom.mas_equalTo(self.contentView).offset(-20);
    }];
    
    self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(oneWidth-22, 4, 18, 18)];
    [self.deleteButton setImage:IMAGE_NAMED(@"supplier_add_photo_delete") forState:UIControlStateNormal];
    [self.deleteButton addTarget:self action:@selector(oneDeleteClick) forControlEvents:UIControlEventTouchUpInside];
    [self.addBtn addSubview:self.deleteButton];
    self.deleteButton.hidden = YES;
}

- (void)setYingyeImage:(UIImage *)yingyeImage{
    if (yingyeImage) {
        [self.addBtn setBackgroundImage:yingyeImage forState:UIControlStateNormal];
        [self.addBtn setBackgroundImage:yingyeImage forState:UIControlStateHighlighted];
        self.deleteButton.hidden = YES;
    }else{
        [self.addBtn setBackgroundImage:IMAGE_NAMED(@"my_supplier_app_btn") forState:UIControlStateNormal];
        [self.addBtn setBackgroundImage:IMAGE_NAMED(@"my_supplier_app_btn") forState:UIControlStateHighlighted];
        self.deleteButton.hidden = YES;
    }
}

- (void)btnClick{
    if (_viewClickBlock) {
        _viewClickBlock(YES,0);
    }
}

- (void)oneDeleteClick{
    if (_viewClickBlock) {
        _viewClickBlock(NO,0);
    }
}

@end


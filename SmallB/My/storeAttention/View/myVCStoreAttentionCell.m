//
//  myVCStoreAttentionCell.m
//  SmallB
//
//  Created by zhang on 2022/4/8.
//

#import "myVCStoreAttentionCell.h"
#import "rightPushView.h"

@interface myVCStoreAttentionCell ()

@property(nonatomic , strong)UIImageView *storeImgV;
@property(nonatomic , strong)UIImageView *selectImgV;
@property(nonatomic , strong)UILabel *storeTitleL;
@property(nonatomic , strong)UILabel *storeProductNumLab;
@property(nonatomic , strong)UIView *lineV;
@property(nonatomic , strong)UIButton *seeStoreBtn;
@property(nonatomic , strong)UIImageView *rightImgV;

@property(nonatomic , strong)UIView *photoView;

@end

@implementation myVCStoreAttentionCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    
    self.selectImgV = [[UIImageView alloc]init];
    self.selectImgV.image = IMAGE_NAMED(@"all_select_select");
    [self.bgView addSubview:self.selectImgV];
    self.selectImgV.hidden = YES;
    [self.selectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(12);
        make.width.height.mas_equalTo(24);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
    }];
    
    self.storeImgV = [[UIImageView alloc]init];
    self.storeImgV.layer.cornerRadius = 4;
    self.storeImgV.layer.masksToBounds = YES;
    self.storeImgV.layer.borderWidth = 1;
    self.storeImgV.layer.borderColor = KBGLightColor.CGColor;
    [self.bgView addSubview:self.storeImgV];
    [self.storeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(12);
        make.top.mas_equalTo(self.bgView).offset(12);
        make.height.width.mas_equalTo(45);
    }];
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"取消关注" Target:self Action:@selector(cancelBtnClick) Font:DEFAULT_FONT_R(12) BackgroundColor:UIColor.clearColor Color:KBlack999TextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 12;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = KBlack999TextColor.CGColor;
    [self.bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(23);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(70);
    }];
    
    self.storeTitleL = [[UILabel alloc]init];
    self.storeTitleL.font = DEFAULT_FONT_M(15);
    self.storeTitleL.textColor = UIColor.blackColor;
    [self.bgView addSubview:self.storeTitleL];
    [self.storeTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.storeImgV.mas_right).offset(12);
        make.right.mas_equalTo(btn.mas_left).offset(-10);
        make.top.mas_equalTo(self.storeImgV.mas_top);
        make.centerY.mas_equalTo(self.storeImgV.mas_centerY);
    }];
    
    self.photoView = [[UIView alloc]init];
    [self.bgView addSubview:self.photoView];
    
    float width = (ScreenWidth - 24 - 24 - 24)/4.0;
    
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.storeImgV.mas_left);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.top.mas_equalTo(self.storeImgV.mas_bottom).offset(12);
        make.height.mas_equalTo(width);
    }];
    
    for (int i =0; i < 4; i ++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((width + 8)*i, 0, width, width)];
        image.tag = 100 +i;
        [self.photoView addSubview:image];
    }
}

- (void)cancelBtnClick{
    THBaseViewController *vc = (THBaseViewController *)[AppTool currentVC];
    [vc startLoadingHUD];
    [THHttpManager FormatPOST:@"shop/shopInfo/saveSupplyCollect" parameters:@{@"supplyId":self.model.supplyId} dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [vc stopLoadingHUD];
        if (returnCode == 200) {
            [XHToast dismiss];
            [XHToast showCenterWithText:@"取消关注成功"];
            if (_updateBlock) {
                _updateBlock();
            }
        }
    }];
}

- (void)setModel:(StoreCollectionRecordsModel *)model{
    _model = model;
    [self.storeImgV sd_setImageWithURL:[NSURL URLWithString:model.logoImgUrl] placeholderImage:KPlaceholder_DefaultImage];
    
    self.storeTitleL.text = model.supplyName;
    
    self.selectImgV.image = model.isSelect ? IMAGE_NAMED(@"all_select_selected") : IMAGE_NAMED(@"all_select_select");
    
    NSInteger num = model.goodsListVos.count > 4 ? 4 :model.goodsListVos.count;
    for (int i =0; i < num; i ++) {
        UIImageView *image = [self viewWithTag:100 +i];
        GoodsListVosModel *model = _model.goodsListVos[i];
        [image sd_setImageWithURL:[NSURL URLWithString:model.goodsThumb] placeholderImage:KPlaceholder_DefaultImage];
    }
}

- (void)setIsManager:(BOOL)isManager{
    _isManager = isManager;
    self.selectImgV.hidden = !isManager;
    [self.storeImgV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(isManager ? 48 : 12);
    }];
}

- (void)k_creatSubViews1{
    [super k_creatSubViews];
    
    self.storeImgV = [[UIImageView alloc]init];
    self.storeImgV.layer.cornerRadius = 4;
    self.storeImgV.layer.masksToBounds = YES;
    [self.bgView addSubview:self.storeImgV];
    [self.storeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(12);
        make.top.mas_equalTo(self.bgView).offset(12);
        make.height.width.mas_equalTo(44);
    }];
    
    rightPushView *rightV = [[rightPushView alloc]init];
    rightV.titleL.text = @"进入店铺";
    rightV.titleL.font = DEFAULT_FONT_R(12);
    rightV.titleL.textColor = KBlack666TextColor;
    rightV.imageNameString = @"my_right_gray";
    [self.bgView addSubview:rightV];
    rightV.viewClickBlock = ^{
        [[AllNoticePopUtility shareInstance] popViewWithTitle:@"进入店铺" AndType:success AnddataBlock:^{
            
        }];
    };
    [rightV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
    }];
    
    self.storeTitleL = [[UILabel alloc]init];
    self.storeTitleL.font = DEFAULT_FONT_M(15);
    self.storeTitleL.textColor = UIColor.blackColor;
    self.storeTitleL.text = @"LLMF官方旗舰店";
    [self.bgView addSubview:self.storeTitleL];
    [self.storeTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.storeImgV.mas_right).offset(12);
        make.right.mas_equalTo(rightV.mas_left).offset(-5);
        make.top.mas_equalTo(self.storeImgV.mas_top);
        make.height.mas_equalTo(24);
    }];

    self.storeProductNumLab = [[UILabel alloc] initWithFrame:CGRectZero];
    self.storeProductNumLab.backgroundColor = UIColor.clearColor;
    self.storeProductNumLab.textColor = KBlack666TextColor;
    self.storeProductNumLab.font = DEFAULT_FONT_R(12);
    self.storeProductNumLab.text = @"共100款";
    [self.bgView addSubview:self.storeProductNumLab];
    [self.storeProductNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.storeTitleL.mas_left);
        make.bottom.mas_equalTo(self.storeImgV.mas_bottom);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(rightV.mas_left).offset(-5);
    }];
}

@end

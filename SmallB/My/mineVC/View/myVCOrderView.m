//
//  myVCOrderView.m
//  SmallB
//
//  Created by zhang on 2022/4/7.
//

#import "myVCOrderView.h"
#import "MyVCCollectionAndRecordsViewController.h"

@interface myVCOrderView ()

@property(nonatomic,strong)UIView *redView;
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UIImageView *imgV;

@end

@implementation myVCOrderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    
    self.titleL = [[UILabel alloc]initWithFrame:CGRectZero];
    self.titleL.textColor = KBlack333TextColor;
    self.titleL.font = DEFAULT_FONT_R(13);
    self.titleL.text = @"商品收藏";
    self.titleL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(18);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.right.mas_equalTo(self);
    }];
    
    self.imgV = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.height.mas_equalTo(40);
    }];
    
    self.redView = [[UIView alloc]initWithFrame:CGRectZero];
    self.redView.backgroundColor = UIColor.redColor;
    self.redView.clipsToBounds = YES;
    self.redView.layer.cornerRadius = 3;
    [self addSubview:self.redView];
    self.redView.hidden = YES;
    
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgV.mas_right);
        make.bottom.mas_equalTo(self.imgV.mas_top);
        make.height.width.mas_equalTo(6);
    }];
    self.imgV.userInteractionEnabled = YES;
    self.titleL.userInteractionEnabled = YES;
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)]];
}

- (void)setImageHeight:(float)imageHeight{
    _imageHeight = imageHeight;
    [self.imgV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(_imageHeight);
    }];
}

-(void)setImageNameString:(NSString *)imageNameString{
    _imageNameString = imageNameString;
    self.imgV.image = [UIImage imageNamed:_imageNameString];
}

-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    self.titleL.text = _titleString;
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    
    if (_viewClickBlock) {
        _viewClickBlock(tap.view.tag - 100);
    }
}

- (void)setHiddenRedView:(BOOL)hiddenRedView{
    _hiddenRedView = hiddenRedView;
    self.redView.hidden = _hiddenRedView;
}

@end

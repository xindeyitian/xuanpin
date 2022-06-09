//
//  myInfoDetailBtn.m
//  SmallB
//
//  Created by zhang on 2022/4/7.
//

#import "myInfoDetailView.h"
#import "MyVCCollectionAndRecordsViewController.h"
#import "myVCStoreAttentionViewController.h"

@interface myInfoDetailView ()

@property(nonatomic,strong)UIView *redView;

@end

@implementation myInfoDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    
    self.titleL = [[UILabel alloc]initWithFrame:CGRectZero];
    self.titleL.textColor = KBlack666TextColor;
    self.titleL.font = DEFAULT_FONT_R(12);
    self.titleL.text = @"商品收藏";
    self.titleL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(21);
        make.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(5);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    self.numL = [[UILabel alloc]initWithFrame:CGRectZero];
    self.numL.textColor = KBlack333TextColor;
    self.numL.font = DIN_Bold_FONT_R(15);
    self.numL.text = @"108";
    self.numL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.numL];
    [self.numL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.titleL.mas_top);
    }];
    
    self.redView = [[UIView alloc]initWithFrame:CGRectZero];
    self.redView.backgroundColor = kRGB(250, 23, 45);
    self.redView.clipsToBounds = YES;
    self.redView.layer.cornerRadius = 2.5;
    [self addSubview:self.redView];
    
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.numL.mas_right).offset(7);
        make.top.mas_equalTo(self.numL.mas_top).offset(3);
        make.height.width.mas_equalTo(5);
    }];
    
    self.numL.userInteractionEnabled = YES;
    self.titleL.userInteractionEnabled = YES;
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)]];
}

-(void)setNumString:(NSString *)numString{
    _numString = numString;
    self.numL.text = _numString;
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

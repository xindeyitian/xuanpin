//
//  rightPushView.m
//  SmallB
//
//  Created by zhang on 2022/4/8.
//

#import "rightPushView.h"

@interface rightPushView ()

@property(nonatomic,strong)UIImageView *rightImgV;

@end

@implementation rightPushView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    
    self.backgroundColor = UIColor.clearColor;
    
    self.rightImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back"]];
    [self addSubview:self.rightImgV];
    [self.rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(self.mas_height);
    }];
    
    self.titleL = [[UILabel alloc]initWithFrame:CGRectZero];
    self.titleL.textColor = KBlack333TextColor;
    self.titleL.font = DEFAULT_FONT_R(16);
    self.titleL.text = @"";
    self.titleL.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.rightImgV.mas_left);
        make.left.mas_equalTo(self);
    }];
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)]];
}

- (void)setImageHeight:(float)imageHeight{
    _imageHeight = imageHeight;
    [self.rightImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(_imageHeight);
    }];
}

- (void)tapClick{
    if (_viewClickBlock) {
        _viewClickBlock();
    }
}

-(void)setImageNameString:(NSString *)imageNameString{
    _imageNameString = imageNameString;
    self.rightImgV.image = [UIImage imageNamed:_imageNameString];
}

@end

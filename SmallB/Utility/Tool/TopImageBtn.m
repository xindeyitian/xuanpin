//
//  TopImageBtn.m
//  SmallB
//
//  Created by zhang on 2022/5/25.
//

#import "TopImageBtn.h"

@implementation TopImageBtn

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    self.topImgV = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2.0 - 22*KScreenW_Ratio, 0, 44*KScreenW_Ratio, 44*KScreenW_Ratio)];
    [self addSubview:self.topImgV];
    
    self.bottomTitleL = [UILabel creatLabelWithTitle:@"" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(15)];
    self.bottomTitleL.frame = CGRectMake(0, self.frame.size.height - 22, self.frame.size.width, 22);
    [self addSubview:self.bottomTitleL];
}

@end

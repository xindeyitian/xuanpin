//
//  CategoryCategoryCollectionViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/18.
//

#import "CategoryCategoryCollectionViewCell.h"

@interface CategoryCategoryCollectionViewCell ()

@end

@implementation CategoryCategoryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = KWhiteBGColor;
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews {
    
    self.goodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width)];
    [self.contentView addSubview:self.goodImageView];

    self.goodNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.goodImageView.frame)+10, self.width, 30)];
    self.goodNameLabel.textAlignment = NSTextAlignmentCenter;
    self.goodNameLabel.numberOfLines = 0;
    self.goodNameLabel.font = DEFAULT_FONT_R(13);
    self.goodNameLabel.textColor = KBlack333TextColor;
    self.goodNameLabel.text = @"三级分类";
    [self.contentView addSubview:self.goodNameLabel];
}

@end

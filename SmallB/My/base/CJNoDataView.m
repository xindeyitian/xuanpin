//
//  CJNoDataView.m
//  CJ Dropshipping
//
//  Created by 张金山 on 2020/9/28.
//  Copyright © 2020 CuJia. All rights reserved.
//

#import "CJNoDataView.h"

@interface CJNoDataView()

@end

@implementation CJNoDataView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.clearColor;
        [self addSubview:self.noDataImageView];
        [self addSubview:self.noDataTitleLabel];
        
        [self.noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(278, 145));
        }];
        [self.noDataTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.noDataImageView.mas_bottom).offset(7);
            make.height.mas_equalTo(18);
        }];
    }
    return self;
}

#pragma mark----- LazyLoad
- (UIImageView *)noDataImageView {
    if(!_noDataImageView) {
        _noDataImageView =[[UIImageView alloc]initWithImage:IMAGE_NAMED(@"all_noData_image")];
    }
    return _noDataImageView;
}

- (UILabel *)noDataTitleLabel {
    if(!_noDataTitleLabel) {
        _noDataTitleLabel = [UILabel creatLabelWithTitle:@"暂无商品哦～" textColor:KBlack999TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_R(13)];
        _noDataTitleLabel.numberOfLines = 2;
    }
    return _noDataTitleLabel;
}

- (void)setNoDataImageViewSize:(CGSize)noDataImageViewSize {
    _noDataImageViewSize = noDataImageViewSize;
    [self.noDataImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(noDataImageViewSize);
    }];
}

- (void)setNoDataTitleTopCon:(CGFloat)noDataTitleTopCon {
    _noDataTitleTopCon = noDataTitleTopCon;
    [self.noDataTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.noDataImageView.mas_bottom).offset(noDataTitleTopCon);
    }];
}

@end

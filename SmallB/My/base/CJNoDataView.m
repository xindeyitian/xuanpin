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
            make.size.mas_equalTo(CGSizeMake(110, 110));
        }];
        [self.noDataTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.noDataImageView.mas_bottom).offset(12);
        }];
    }
    return self;
}

#pragma mark----- LazyLoad
- (UIImageView *)noDataImageView {
    if(!_noDataImageView) {
        _noDataImageView =[[UIImageView alloc]initWithImage:nil];
    }
    return _noDataImageView;
}

- (UILabel *)noDataTitleLabel {
    if(!_noDataTitleLabel) {
        _noDataTitleLabel = [UILabel creatLabelWithTitle:@"暂无数据" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(16)];
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

//
//  CJNoDataView.h
//  CJ Dropshipping
//
//  Created by 张金山 on 2020/9/28.
//  Copyright © 2020 CuJia. All rights reserved.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJNoDataView : THBaseView

//没有数据的图片
@property (nonatomic, strong) UIImageView * noDataImageView;
//没有数据的标题
@property (nonatomic, strong) UILabel * noDataTitleLabel;
//没有数据图片的size
@property (nonatomic, assign) CGSize noDataImageViewSize;
//没有数据的标题距离图片底部的距离
@property (nonatomic, assign) CGFloat noDataTitleTopCon;

@end

NS_ASSUME_NONNULL_END

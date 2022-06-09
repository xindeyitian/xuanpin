//
//  BaseNavBar.h
//  SeaEgret
//
//  Created by MAC on 2021/3/23.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN


@interface BaseNavBar : THBaseView

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) UILabel *searchLable;

@end

NS_ASSUME_NONNULL_END

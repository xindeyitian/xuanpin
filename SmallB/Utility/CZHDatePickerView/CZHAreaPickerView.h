//
//  CZHAreaPickerView.h
//  ZhongbenKaGuanJia
//
//  Created by User on 2018/12/28.
//  Copyright © 2018 李经纬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZHAreaPickerView : UIView

///**
// 选择器
// 
// @param dataSource 数据源
// @param ItemBlock 选择回调
// */
+ (instancetype)sharePickerViewWithtitleText:(NSString *)titleText Province:(NSMutableArray *)province City:(NSMutableArray *)city Region:(NSMutableArray *)region ItemBlock:(void (^)(NSString* provinceName, NSString* cityName, NSString* regionName))itemBlock;

@end

NS_ASSUME_NONNULL_END

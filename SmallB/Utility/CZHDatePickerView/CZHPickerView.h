//
//  CZHPickerView.h
//  DTU
//
//  Created by 李经纬 on 2018/7/27.
//  Copyright © 2018年 李经纬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZHPickerView : UIView


/**
 选择器

 @param currentItem 选择的默认Item
 @param dataSource 数据源
 @param ItemBlock 选择回调
 */
+ (instancetype)sharePickerViewWithCurrentItem:(NSInteger)currentItem titleText:(NSString *)titleText DataSource:(NSArray *)dataSource ItemBlock:(void (^)(NSInteger))itemBlock;
@end

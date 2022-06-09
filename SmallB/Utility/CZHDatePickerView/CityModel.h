//
//  CityModel.h
//  ZhongbenKaGuanJia
//
//  Created by User on 2018/11/23.
//  Copyright © 2018 李经纬. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//@class CityDetailModel;
@interface CityModel : NSObject

@property (nonatomic, strong) NSString *region_id;
@property (nonatomic, strong) NSString *region_code;
@property (nonatomic, strong) NSString *region_name;
@property (nonatomic, strong) NSString *parent_id;
@property (nonatomic, strong) NSString *region_type;
@property (nonatomic, strong) NSString *region_name_en;
@property (nonatomic, strong) NSString *region_shortname_en;

@end

//@interface CityDetailModel : NSObject
//
//@property (nonatomic, strong) NSString *uid;
//
//@property (nonatomic, strong) NSString *value;
//
//@property (nonatomic, strong) NSString *parentId;
//
//
//@end

NS_ASSUME_NONNULL_END

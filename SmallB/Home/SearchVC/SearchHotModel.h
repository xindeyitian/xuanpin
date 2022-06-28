//
//  SearchHotModel.h
//  SmallB
//
//  Created by zhang on 2022/6/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchHotModel : NSObject

@property (nonatomic , strong)NSMutableArray *records;

@end

@interface SearchHotDataModel : NSObject

@property (nonatomic , copy)NSString *djlsh;
@property (nonatomic , copy)NSString *searchName;
@property (nonatomic , copy)NSString *searchHeat;
@property (nonatomic , copy)NSString *createTime;

@end

NS_ASSUME_NONNULL_END

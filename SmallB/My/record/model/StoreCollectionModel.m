//
//  StoreCollectionModel.m
//  SmallB
//
//  Created by zhang on 2022/5/13.
//

#import "StoreCollectionModel.h"

@implementation StoreCollectionModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"records":@"StoreCollectionRecordsModel"};
}

@end

@implementation StoreCollectionRecordsModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"goodsListVos":@"GoodsListVosModel"};
}

@end



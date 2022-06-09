//
//  OrderListModel.m
//  SmallB
//
//  Created by zhang on 2022/5/14.
//

#import "OrderListModel.h"

@implementation OrderListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"records":@"OrderListRecordsModel"};
}

@end

@implementation OrderListRecordsModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"orderGoodsListVos":@"OrderListProductModel"};
}

@end

@implementation OrderListProductModel

@end

@implementation OrderDetailModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"orderGoodsListVo":@"OrderListProductModel"};
}

@end

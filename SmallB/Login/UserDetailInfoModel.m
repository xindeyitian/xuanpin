//
//  UserDetailInfoModel.m
//  SmallB
//
//  Created by zhang on 2022/5/3.
//

#import "UserDetailInfoModel.h"

@implementation UserDetailInfoModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"productList":@"CJPurchaseOrderProductListModel"};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

@end

@implementation UserDetailInfoLoginUserVoModel

@end

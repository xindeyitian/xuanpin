//
//  NSDictionary+SCCommon.m
//  LDSpecialCarService
//
//  Created by Mac on 2017/3/1.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "NSDictionary+SCCommon.h"

@implementation NSDictionary (SCCommon)

- (NSString *)JSONString
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];

    NSString *jsonString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return jsonString;
}
@end

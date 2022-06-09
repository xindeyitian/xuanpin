//
//  ChooseAddressPopUtility.m
//  LLWFan
//
//  Created by 张昊男 on 2022/3/26.
//

#import "ChooseAddressPopUtility.h"

static ChooseAddressPopUtility* _instance = nil;

@interface ChooseAddressPopUtility()

@property (strong, nonatomic) UIView *maskView;

@end

@implementation ChooseAddressPopUtility

+ (instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        
        _instance = [[ChooseAddressPopUtility alloc] init];
    }) ;
    return _instance ;
}

@end

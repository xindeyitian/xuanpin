//
//  BuyTuanModel.m
//  SmallB
//
//  Created by zhang on 2022/5/13.
//

#import "BuyTuanModel.h"

@implementation BuyTuanModel

- (NSString *)salePrice{
    if (_salePrice) {
        _salePrice = [NSString stringWithFormat:@"%.2f",_salePrice.floatValue];
    }
    return _salePrice;
}

@end

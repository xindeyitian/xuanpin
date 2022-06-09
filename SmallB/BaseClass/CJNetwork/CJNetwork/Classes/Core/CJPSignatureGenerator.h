//
//  CJPSignatureGenerator.h
//  AFNetworking
//
//  Created by Architray on 2019/10/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 */
@interface CJPSignatureGenerator : NSObject

+ (NSString *)sign:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END

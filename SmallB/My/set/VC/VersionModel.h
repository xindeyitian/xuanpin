//
//  VersionModel.h
//  SmallB
//
//  Created by zhang on 2022/7/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VersionModel : NSObject

@property (nonatomic , copy)NSString *versionCode;
@property (nonatomic , copy)NSString *versionDesc;
@property (nonatomic , copy)NSString *createTime;

@end

NS_ASSUME_NONNULL_END

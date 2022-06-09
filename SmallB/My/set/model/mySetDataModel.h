//
//  mySetDataModel.h
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface mySetDataModel : NSObject

@property (nonatomic , copy)NSString *titleStr;
@property (nonatomic , copy)NSString *detailStr;
@property (nonatomic , copy)NSString *placerHolderStr;
@property (nonatomic , copy)UIColor *detailColor;
@property (nonatomic , assign)BOOL hiddenRightImgV;

@end

NS_ASSUME_NONNULL_END

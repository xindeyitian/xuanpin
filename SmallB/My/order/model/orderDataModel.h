//
//  orderDataModel.h
//  SmallB
//
//  Created by zhang on 2022/4/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface orderDataModel : NSObject

@property (nonatomic , copy)NSString *titleStr;
@property (nonatomic , copy)NSString *detailStr;
@property (nonatomic , assign)BOOL hiddenRightImgV;
@property (nonatomic , strong)UIFont *rightFont;
@property (nonatomic , strong)UIColor *rightColor;
@property (nonatomic , strong)UIFont *leftFont;
@property (nonatomic , strong)UIColor *leftColor;
@property (nonatomic , assign)BOOL showLineV;
@property (nonatomic , assign)float rowHeight;//默认40
@property (nonatomic , assign)BOOL showCopy;
@property (nonatomic , assign)NSInteger type;

@property (nonatomic , strong)id propertyData;
@property (nonatomic , strong)id propertyDatAry;

@end

NS_ASSUME_NONNULL_END

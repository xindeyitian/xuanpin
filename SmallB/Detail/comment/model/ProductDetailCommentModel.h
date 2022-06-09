//
//  ProductDetailCommentModel.h
//  SmallB
//
//  Created by zhang on 2022/4/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailCommentModel : NSObject

@property (nonatomic ,strong)NSMutableArray *biaoQianAry;
@property (nonatomic ,strong)NSMutableArray *imageAry;
@property (nonatomic ,strong)NSString *contentStr;

@property (nonatomic ,assign)float rowHeight;
@property (nonatomic ,assign)float biaoQianBGHeight;
@property (nonatomic ,assign)float imageBGHeight;
@property (nonatomic ,assign)float oneImageHeight;
@property (nonatomic ,assign)float contentBGHeight;
@property (nonatomic ,assign)NSInteger num;

@end

NS_ASSUME_NONNULL_END

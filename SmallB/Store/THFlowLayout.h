//
//  THFlowLayout.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class THFlowLayout;
@protocol THFlowLayoutDelegate <NSObject>

- (CGFloat)waterflowLayout:(THFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;
@end

@interface THFlowLayout : UICollectionViewLayout

@property (nonatomic, assign) UIEdgeInsets sectionInset;
/** 段头的size */
@property (nonatomic, assign) CGSize headerReferenceSize;

/** 每一列之间的间距 */
@property (nonatomic, assign) CGFloat columnMargin;
/** 每一行之间的间距 */
@property (nonatomic, assign) CGFloat rowMargin;
/** 显示多少列 */
@property (nonatomic, assign) int columnsCount;

@property (nonatomic, weak) id<THFlowLayoutDelegate> delegate;
/** header是否停留*/
@property (nonatomic, assign) BOOL isHeaderStick;

@property (nonatomic, assign) CGFloat stickHight;

@end

NS_ASSUME_NONNULL_END

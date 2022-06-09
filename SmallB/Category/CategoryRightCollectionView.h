//
//  CategoryRightCollectionView.h
//  SmallB
//
//  Created by zhang on 2022/4/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryRightCollectionView : UICollectionView

@property (nonatomic, strong) NSMutableArray * dataAry;

@property (nonatomic, strong) NSMutableArray * currentAry;
@property (nonatomic, assign) NSInteger selectedRow;

@property (nonatomic, copy  ) void(^CellSelectedBlock)(NSString * title,NSString * categoryID);

-(void)setDataWithDataAry:(NSMutableArray*)allAry withSelectedRow:(NSInteger)Row;

@end

NS_ASSUME_NONNULL_END

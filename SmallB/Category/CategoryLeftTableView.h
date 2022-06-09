//
//  CategoryLeftTableView.h
//  SmallB
//
//  Created by zhang on 2022/4/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryLeftTableView : UITableView

@property (nonatomic, strong) NSMutableArray *dataAry;
@property (nonatomic, copy  ) void(^CellSelectedBlock)(NSIndexPath *indexPath);
@property (nonatomic, assign) NSInteger selectedRow;

@end

NS_ASSUME_NONNULL_END

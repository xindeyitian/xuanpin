//
//  MyVCCollectionAndRecordsViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/8.
//

#import "THBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, vcTypeIndex) {
    vcTypeIndexProductCollection = 0,//商品收藏
    vcTypeIndexStoreAttention,//店铺关注
    vcTypeIndexRecordList,//浏览记录
};

@interface MyVCCollectionAndRecordsViewController : THBaseTableViewController

@property (nonatomic , assign)vcTypeIndex typeIndex;

@end

@interface MyVCCollectionAndRecordsBottomView : UIView

@property (nonatomic , assign)vcTypeIndex typeIndex;
@property (nonatomic , strong)BaseButton *operationBtn;
@property (nonatomic , strong)UIImageView *selectImg;
@property (nonatomic , strong)void(^selectOperation)(BOOL isSelect);
@property (nonatomic , strong)UIControl *controL;
@property (nonatomic , strong)void(^deleteOperation)(void);

@end

NS_ASSUME_NONNULL_END

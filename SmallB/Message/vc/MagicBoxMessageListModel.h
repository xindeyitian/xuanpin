//
//  MagicBoxMessageListModel.h
//  SmallB
//
//  Created by zhang on 2022/6/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MagicBoxMessageModel : NSObject

@property (nonatomic , strong)NSMutableArray *data;

@end

@interface MagicBoxMessageListModel : NSObject

@property (nonatomic , copy)NSString *msgTitle;
@property (nonatomic , assign)NSInteger readSign;//是否已读0未读1已读
@property (nonatomic , copy)NSString *msgId;
@property (nonatomic , copy)NSString *msgContent;
@property (nonatomic , copy)NSString *createTime;
@property (nonatomic , copy)NSString *msgUrl;

@end

NS_ASSUME_NONNULL_END

//
//  SearchNavBar.h
//  SmallB
//
//  Created by 张昊男 on 2022/4/6.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchNavBar : THBaseView

@property (nonatomic, assign)BOOL needSave;
@property (strong, nonatomic) UITextField *searchTF;
@property (copy, nonatomic) NSString *searchStr;
@property (nonatomic , strong)void(^searchBtnOperationBlock)(NSString *searchStr);

@end

NS_ASSUME_NONNULL_END

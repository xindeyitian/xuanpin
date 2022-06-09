//
//  BaseTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/13.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self k_creatSubViews];
    }
    return self;
}

- (void)k_creatSubViews{
    
}

@end

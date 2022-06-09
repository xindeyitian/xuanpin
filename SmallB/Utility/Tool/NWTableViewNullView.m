//
//  NWTableViewNullView.m
//  WildFireChat
//
//  Created by 杨晓铭 on 2020/8/9.
//  Copyright © 2020 WildFireChat. All rights reserved.
//

#import "NWTableViewNullView.h"

@implementation NWTableViewNullView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    
    self.myMargin = 0;
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iconIamgeView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"无数据"]];
    iconIamgeView.myHeight = iconIamgeView.myWidth = MyLayoutSize.wrap;
    iconIamgeView.centerYPos.equalTo(@0);
    iconIamgeView.centerXPos.equalTo(@0);
    [self addSubview:iconIamgeView];
    
    UILabel *titlabel = [UILabel new];
    titlabel.text = @"暂无数据";
    titlabel.textColor = [UIColor grayColor];
    titlabel.centerXPos.equalTo(@0);
    titlabel.myHeight = titlabel.myWidth = MyLayoutSize.wrap;
    titlabel.topPos.equalTo(iconIamgeView.bottomPos).offset(20);
   [self addSubview:titlabel];

}

@end

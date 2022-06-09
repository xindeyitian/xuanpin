//
//  THBaseView.m
//  LLWFan
//
//  Created by MAC on 2022/3/21.
//

#import "THBaseView.h"

@implementation THBaseView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initView];
        
        [self initData];
    }
    
    return self;
}

- (void)initView
{
    self.backgroundColor = [UIColor whiteColor];
    
}

- (void)initData
{
    
}
- (void)loadNetworkData
{
    
}

- (THBaseViewController *)currentViewController
{

     return [THAPPService shareAppService].currentViewController;
}


@end

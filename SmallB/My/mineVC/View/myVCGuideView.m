//
//  myVCGuideView.m
//  SmallB
//
//  Created by zhang on 2022/4/8.
//

#import "myVCGuideView.h"

@interface myVCGuideView ()

@property (nonatomic ,strong)SDCycleScrollView *bannerCycle;

@end

@implementation myVCGuideView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    self.backgroundColor = KBGColor;
    
    self.bannerCycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
    self.bannerCycle.imageURLStringsGroup = @[];
    self.bannerCycle.frame = CGRectMake(12*KScreenW_Ratio, 0, ScreenWidth - 24 * KScreenW_Ratio, 80*KScreenW_Ratio);
    self.bannerCycle.autoScroll = YES;
    self.bannerCycle.pageControlDotSize = CGSizeMake(10, 10);
    self.bannerCycle.currentPageDotImage = IMAGE_NAMED(@"banner_select_image");
    self.bannerCycle.pageDotImage = IMAGE_NAMED(@"banner_normal_image");
    self.bannerCycle.showPageControl = YES;
    self.bannerCycle.backgroundColor = UIColor.clearColor;
    self.bannerCycle.layer.cornerRadius = 10;
    self.bannerCycle.clipsToBounds = YES;
    [self addSubview:self.bannerCycle];
}

- (void)setBannerAry:(NSArray *)bannerAry{
    _bannerAry = bannerAry;
    self.bannerCycle.imageURLStringsGroup = _bannerAry;
}

- (void)tapClick{
    [[AllNoticePopUtility shareInstance] popViewWithTitle:@"新人引导" AndType:success AnddataBlock:^{
        
    }];
}

@end

//
//  HomeStoreContentTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/28.
//

#import "HomeStoreContentTableViewCell.h"
#import "HomeRecommendTableViewCell.h"

@interface HomeStoreContentTableViewCell ()

@property (nonatomic , strong)HomeRecommendStoreView *storeV;
@end

@implementation HomeStoreContentTableViewCell

- (void)k_creatSubViews{
    [super k_creatSubViews];
    
    self.storeV = [[HomeRecommendStoreView alloc]initWithFrame:CGRectMake(12, 12, ScreenWidth-24, 210)];
    self.storeV.haveBtn = YES;
    [self addSubview:self.storeV];
}

- (void)setModel:(BrandConceptVosModel *)model{
    _model = model;
    self.storeV.goodModel = model;
}

@end

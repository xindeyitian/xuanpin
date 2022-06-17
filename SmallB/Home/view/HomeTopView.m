//
//  HomeTopView.m
//  SmallB
//
//  Created by 张昊男 on 2022/4/1.
//

#import "HomeTopView.h"
#import "BaseCollectionViewController.h"
#import "HomeMoreCommonViewController.h"

@interface HomeTopView()<SDCycleScrollViewDelegate,UIScrollViewDelegate>
{
    float maxY;
}
@property (strong, nonatomic) SDCycleScrollView *bannerCycle;
@property (strong, nonatomic) UIScrollView *youxuanScroll, *hotScroll;
@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UIButton *item1, *item2;
@property (strong, nonatomic) MyLinearLayout *nineProductLy, *miaoshaLy, *hotLy;
@property (strong, nonatomic) MyFlowLayout *youxuanProductLy , *merchantLy;

@end

@implementation HomeTopView

#pragma mark - init --
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView{
    
    self.backgroundColor = KWhiteBGColor;
    
    NSArray *titleArr = @[@"品牌产品",@"好货优选",@"9.9包邮",@"全球嗨购",@"带货榜单",@"品牌产品",@"好货优选",@"9.9包邮",@"全球嗨购",@"带货榜单"];
    NSArray *imgArr = @[@"pinpai",@"haohuo",@"99",@"quanqiu",@"daihuo",@"pinpai",@"haohuo",@"99",@"quanqiu",@"daihuo"];
}

- (void)setCategoryModel:(GoodsCategoryListVosModel *)categoryModel{
    _categoryModel = categoryModel;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.backgroundColor = KWhiteBGColor;
    
    NSArray *dataAry = categoryModel.listVos;
    maxY = .0f;
    if (dataAry.count) {
        float jiange = 12.0f;
        float width = (ScreenWidth - jiange * 6)/5.0f;;
        UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(12, 0, ScreenWidth - 24, self.frame.size.height)];
        whiteV.tag = 111;
        [self addSubview:whiteV];
        
        for (int i = 0; i < dataAry.count; i++) {
            HomeListVosModel *model = dataAry[i];
            
            TopImageBtn *imgBtn = [[TopImageBtn alloc]initWithFrame:CGRectMake((jiange+width)*(i%5),12+(12 + 44*KScreenW_Ratio + 30)*(i/5), width, 44*KScreenW_Ratio + 30)];
            imgBtn.bottomTitleL.font = DEFAULT_FONT_R(12*KScreenW_Ratio);
            imgBtn.backgroundColor = UIColor.clearColor;
            [imgBtn.topImgV sd_setImageWithURL:[NSURL URLWithString:[model.categoryThumb stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            imgBtn.bottomTitleL.text = model.categoryName;
            [imgBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            imgBtn.tag = 200+i;
            [whiteV addSubview:imgBtn];
        }
    }
    
    if (categoryModel.bannerUrls.count) {

        self.bannerCycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        self.bannerCycle.imageURLStringsGroup = @[];
        self.bannerCycle.frame = CGRectMake(12, self.frame.size.height - 140*KScreenW_Ratio - 10, ScreenWidth - 24, 140*KScreenW_Ratio);
        self.bannerCycle.autoScroll = YES;
        self.bannerCycle.showPageControl = YES;
        self.bannerCycle.pageControlDotSize = CGSizeMake(10, 10);
        self.bannerCycle.currentPageDotImage = IMAGE_NAMED(@"banner_select_image");
        self.bannerCycle.pageDotImage = IMAGE_NAMED(@"banner_normal_image");
        self.bannerCycle.backgroundColor = UIColor.clearColor;
        self.bannerCycle.imageURLStringsGroup = categoryModel.bannerUrls;
        self.bannerCycle.layer.cornerRadius = 10;
        self.bannerCycle.clipsToBounds = YES;
        [self addSubview:self.bannerCycle];
    }
}

-(void)setOthers{
    
}

- (void)btnClick:(DKSButton *)btn{
    HomeMoreCommonViewController *vc = [[HomeMoreCommonViewController alloc]init];
    vc.homeMoreCommonType = HomeMoreCommonType_HomeCategory;
    
    NSArray *dataAry = self.categoryModel.listVos;
    HomeListVosModel *model = dataAry[btn.tag - 200];
    vc.categoryId = model.categoryId;
        
    [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end

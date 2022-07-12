//
//  HomeFirstTopView.m
//  SmallB
//
//  Created by zhang on 2022/4/22.
//

#import "HomeFirstTopView.h"
#import "BaseCollectionViewController.h"

@interface HomeFirstTopView()<SDCycleScrollViewDelegate,UIScrollViewDelegate>
{
    float maxY;
}
@property (strong, nonatomic) SDCycleScrollView *bannerCycle;
@property (strong, nonatomic) UIScrollView *youxuanScroll, *hotScroll;
@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UIButton *item1, *item2;
@property (strong, nonatomic) MyLinearLayout *nineProductLy, *miaoshaLy, *hotLy;
@property (strong, nonatomic) MyFlowLayout *youxuanProductLy , *merchantLy;
@property (strong, nonatomic) UIImageView *bgImage;

@end

@implementation HomeFirstTopView

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
    
    self.backgroundColor = KViewBGColor;
    
    self.bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 90)];
    self.bgImage.image = IMAGE_NAMED(@"home_bg_bottom");
    [self addSubview:self.bgImage];
    
    self.bannerCycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:KPlaceholder_DefaultImage];
    self.bannerCycle.imageURLStringsGroup = @[];
    self.bannerCycle.frame = CGRectMake(12, 12, ScreenWidth - 24, 140*KScreenW_Ratio);
    self.bannerCycle.autoScroll = YES;
    self.bannerCycle.pageControlDotSize = CGSizeMake(10, 10);
    self.bannerCycle.currentPageDotImage = IMAGE_NAMED(@"banner_select_image");
    self.bannerCycle.pageDotImage = IMAGE_NAMED(@"banner_normal_image");
    self.bannerCycle.showPageControl = YES;
    self.bannerCycle.backgroundColor = UIColor.clearColor;
    self.bannerCycle.layer.cornerRadius = 10;
    self.bannerCycle.clipsToBounds = YES;
    [self addSubview:self.bannerCycle];
    
    NSArray *titleArr = @[@"品牌产品",@"好货优选",@"9.9包邮",@"全球嗨购",@"带货榜单"];
    NSArray *imgArr = @[@"pinpai",@"haohuo",@"99",@"quanqiu",@"daihuo"];
    
    float width = (ScreenWidth - 12 * 6)/5.0;
    
    UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(12, 140*KScreenW_Ratio + 18, ScreenWidth - 24, 80)];
    whiteV.backgroundColor = UIColor.clearColor;
    [self addSubview:whiteV];
    
    for (int i = 0; i < imgArr.count; i++) {
        DKSButton *btn = [[DKSButton alloc] initWithFrame:CGRectMake((12+width)*i,15, width, 65)];
        btn.tag = i;
        btn.buttonStyle = DKSButtonImageTop;
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = DEFAULT_FONT_R(12);
        [btn setTitleColor:KBlack333TextColor forState:UIControlStateNormal];
        btn.backgroundColor = UIColor.clearColor;
        //[btn setImage:IMAGE_NAMED(imgArr[i]) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        if (i == imgArr.count - 1) {
            maxY = btn.frame.size.height + btn.frame.origin.y;
        }
        [whiteV addSubview:btn];
    }
}

- (void)setDataModel:(HomeDataModel *)dataModel{
    _dataModel = dataModel;
    NSArray *array = dataModel.bannerListVos;
    NSMutableArray *imageAry = [NSMutableArray array];
    for (int i =0; i < array.count; i ++) {
        BannerListVosModel *model = array[i];
        [imageAry addObject:[NSString stringWithFormat:@"%@%@",model.ossImgPath,model.ossImgName]];
    }
    self.bannerCycle.imageURLStringsGroup = imageAry;
    
    for (int i =0; i< dataModel.blockDefineVos.count; i ++) {
        BlockDefineVosModel *model = dataModel.blockDefineVos[i];
        DKSButton *btn = [self viewWithTag:100+i];
        [btn setTitle:model.blockName forState:UIControlStateNormal];
        [btn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",model.logoImgPath,model.logoImgName]] forState:UIControlStateNormal];
        [btn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",model.logoImgPath,model.logoImgName]] forState:UIControlStateHighlighted];
    }
}

-(void)setOthers{
   
}

- (void)btnClick:(BaseButton *)btn{
    HomeMoreViewController *vc = [[HomeMoreViewController alloc]init];
    vc.homeMoreType = btn.tag - 100;
    
    BlockDefineVosModel *model = self.dataModel.blockDefineVos[btn.tag - 100];
    vc.blockId = model.blockId;
    
    [[AppTool currentVC].navigationController pushViewController:vc animated:YES];
}

@end

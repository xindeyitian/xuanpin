//
//  BaseNavBar.m
//  SeaEgret
//
//  Created by MAC on 2021/3/23.
//

#import "BaseNavBar.h"
#import "SearchListViewController.h"

@interface BaseNavBar()<UITextFieldDelegate>
//JXCategoryViewDelegate
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIView *searchBackView;

//@property (strong, nonatomic) JXCategoryTitleView *titleView;
@property (strong, nonatomic) MyLinearLayout *line, *searchLy;

@end

@implementation BaseNavBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
-(void)initView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.rootLy.myHorzMargin = 10;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.backgroundColor = UIColor.clearColor;
    self.rootLy.cacheEstimatedRect = YES;
    self.rootLy.subviewHSpace = 10;
    [self addSubview:self.rootLy];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchBtnClicked:)];
    
    self.searchLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.searchLy.weight = 1;
    self.searchLy.myHeight = 30;
    self.searchLy.myTop = RootStatusBarHeight;
    self.searchLy.gravity = MyGravity_Vert_Center;
    self.searchLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5" alpha:0.45];
    self.searchLy.layer.cornerRadius = 5;
    self.searchLy.layer.masksToBounds = YES;
    self.searchLy.layer.borderWidth = .5;
    self.searchLy.layer.borderColor = UIColor.clearColor.CGColor;
    [self.searchLy addGestureRecognizer:tap];
    [self.rootLy addSubview:self.searchLy];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"放大镜")];
    img.myWidth = img.myHeight = 20;
    img.myLeft = 10;
    [self.searchLy addSubview:img];
    
    self.searchLable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.searchLable.font = DEFAULT_FONT_R(13);
    self.searchLable.text = @"输入宝贝名称";
    self.searchLable.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.75];
    self.searchLable.myWidth = 80;
    self.searchLable.myHeight = 20;
    self.searchLable.myLeft = 7;
    [self.searchLy addSubview:self.searchLable];

    
    UIButton *searchBtn = [BaseButton CreateBaseButtonTitle:@"搜索" Target:self Action:@selector(searchBtnClicked:) Font:DEFAULT_FONT_R(15) BackgroundColor:UIColor.clearColor Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    searchBtn.myWidth = 40;
    searchBtn.myHeight = 20;
    searchBtn.myTop = RootStatusBarHeight + 5;
    [self.rootLy addSubview:searchBtn];
    
}
- (void)searchBtnClicked:(UIButton *)sender{
    
    [[AppTool currentVC].navigationController pushViewController:[[SearchListViewController alloc] init] animated:YES];
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end

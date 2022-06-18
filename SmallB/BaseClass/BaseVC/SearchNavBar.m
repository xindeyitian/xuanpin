//
//  SearchNavBar.m
//  SmallB
//
//  Created by 张昊男 on 2022/4/6.
//

#import "SearchNavBar.h"
#import "SearchResultViewController.h"

@interface SearchNavBar()

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) UIButton       *backBtn;

@end

@implementation SearchNavBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)back{
    [AppTool.currentVC.navigationController popViewControllerAnimated:YES];
}
-(void)initView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.rootLy.myHorzMargin = 0;
    self.rootLy.myHeight = KNavBarHeight;
    self.rootLy.subviewHSpace = 0;
    self.rootLy.gravity = MyGravity_Vert_Bottom;
    self.rootLy.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.rootLy];
    
    self.backBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(back) Font:DEFAULT_FONT_R(10) Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1 BackgroundImage:@"back" HeightLightBackgroundImage:@"back"];
    self.backBtn.myWidth = 40;
    self.backBtn.myHeight = 40;
    [self.rootLy addSubview:self.backBtn];
    
    MyLinearLayout *searchLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    searchLy.weight = 1;
    searchLy.myHeight = 30;
    searchLy.myBottom = 5;
    searchLy.layer.borderWidth = 1;
    searchLy.layer.borderColor = [UIColor colorWithHexString:@"#E61F10"].CGColor;
    searchLy.layer.cornerRadius = 6;
    searchLy.layer.masksToBounds = YES;
    searchLy.gravity = MyGravity_Vert_Center;
    searchLy.padding = UIEdgeInsetsMake(0, 12, 0, 12);
    [self.rootLy addSubview:searchLy];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectZero];
    [img setImage:IMAGE_NAMED(@"放大镜_black")];
    img.myWidth = img.myHeight = 20;
    [searchLy addSubview:img];
    
    self.searchTF = [[UITextField alloc] initWithFrame:CGRectZero];
    self.searchTF.weight = 1;
    self.searchTF.myHeight = 30;
    self.searchTF.placeholder = @"手机";
    self.searchTF.backgroundColor = UIColor.whiteColor;
    self.searchTF.tintColor = UIColor.redColor;
    self.searchTF.myLeft = 10;
    self.searchTF.myRight = -10;
    self.searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchTF.font = DEFAULT_FONT_R(13);
    [searchLy addSubview:self.searchTF];
    NSAttributedString *attrString = [[NSAttributedString alloc]initWithString:@"手机" attributes:@{NSForegroundColorAttributeName:KBlack666TextColor,NSFontAttributeName:self.searchTF.font}];
    self.searchTF.attributedPlaceholder = attrString;
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    searchBtn.titleLabel.font = DEFAULT_FONT_R(15);
    searchBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    searchBtn.backgroundColor = UIColor.whiteColor;
    searchBtn.myWidth = 50;
    searchBtn.myHeight = 40;
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rootLy addSubview:searchBtn];
}

- (void)setSearchStr:(NSString *)searchStr{
    _searchStr = searchStr;
    self.searchTF.text = searchStr;
}

- (void)searchBtnClick{
    [self.searchTF resignFirstResponder];
    if (_searchBtnOperationBlock) {
        _searchBtnOperationBlock(self.searchTF.text);
    }
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end

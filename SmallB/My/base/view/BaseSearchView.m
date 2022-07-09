//
//  BaseSearchView.m
//  SmallB
//
//  Created by zhang on 2022/4/26.
//

#import "BaseSearchView.h"
#import "SearchListViewController.h"

@interface BaseSearchView()<UITextFieldDelegate>
//JXCategoryViewDelegate
@property (strong, nonatomic) UIView *searchV;

@end

@implementation BaseSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

-(void)creatSubViews{
    
    self.backgroundColor = UIColor.whiteColor;
    
    self.backBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(back) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1 BackgroundImage:@"bar_back" HeightLightBackgroundImage:@"bar_back"];
    self.backBtn.frame = CGRectMake(0, 0, 40, 40);
    [self addSubview:self.backBtn];
    self.backBtn.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchClick)];
    
    UIView *searchBgView = [[UIView alloc]initWithFrame:CGRectMake(12, 5, ScreenWidth - 12 - 60, 30)];
    searchBgView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5" alpha:0.45];
    searchBgView.layer.cornerRadius = 5;
    searchBgView.layer.masksToBounds = YES;
    searchBgView.layer.borderWidth = .5;
    searchBgView.layer.borderColor = KMainBGColor.CGColor;
    [searchBgView addGestureRecognizer:tap];
    //searchBgView.centerY = self.centerY;
    [self addSubview:searchBgView];
    self.searchV = searchBgView;
 
    UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"放大镜")];
    img.frame = CGRectMake(13, 5, 20, 20);
    [searchBgView addSubview:img];
    self.leftSearchImgv = img;
    
    self.searchField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.searchField.font = [UIFont systemFontOfSize:13];
    self.searchField.placeholder = @"输入宝贝名称";
    self.searchField.textColor = KBlack333TextColor;
    self.searchField.frame = CGRectMake(38, 0, ScreenWidth - 12 - 60 - 40 , 30);
    self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.fieldEnabled = YES;
    self.searchField.userInteractionEnabled = YES;
    [searchBgView addSubview:self.searchField];
    
    NSAttributedString *attrString = [[NSAttributedString alloc]initWithString:@"输入宝贝名称" attributes:@{NSForegroundColorAttributeName:KWhiteTextColor,NSFontAttributeName:self.searchField.font}];
    self.searchField.attributedPlaceholder = attrString;
    
    UIButton *searchB = [BaseButton CreateBaseButtonTitle:@"搜索" Target:self Action:@selector(searchBtnClicked) Font:[UIFont systemFontOfSize:15] BackgroundColor:KWhiteBGColor Color:KMaintextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:10];
    searchB.frame = CGRectMake(ScreenWidth - 52, 0, 40 , 30);
    searchB.centerY = searchBgView.centerY;
    [self addSubview:searchB];
    self.searchBtn = searchB;
}

- (void)setShowBackBtn:(BOOL)showBackBtn{
    _showBackBtn = showBackBtn;
    self.backBtn.hidden = !_showBackBtn;
    self.searchV.frame = CGRectMake((_showBackBtn ? 40:12), 5, ScreenWidth - 60 - (_showBackBtn ? 40:12), 30);
    
    self.searchField.frame = CGRectMake(38, 0, self.searchV.frame.size.width - 43 , 30);
    self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (void)back{
    [[AppTool currentVC].navigationController popViewControllerAnimated:YES];
}

- (void)setFieldEnabled:(BOOL)fieldEnabled{
    _fieldEnabled = fieldEnabled;
    self.searchField.userInteractionEnabled = fieldEnabled;
    self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (void)searchClick{
    if (!self.fieldEnabled) {
        [[AppTool currentVC].navigationController pushViewController:[[SearchListViewController alloc] init] animated:YES];
    }
}

- (void)searchBtnClicked{
    if (!self.fieldEnabled) {
        [[AppTool currentVC].navigationController pushViewController:[[SearchListViewController alloc] init] animated:YES];
    }else{
        [self.searchField resignFirstResponder];
        if (_viewClickBlock) {
            _viewClickBlock(0,self.searchField.text);
        }
    }
}

@end


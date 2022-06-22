//
//  BaseSearchNavBarView.m
//  SmallB
//
//  Created by zhang on 2022/4/22.
//

#import "BaseSearchNavBarView.h"
#import "SearchListViewController.h"
#import "ScanViewController.h"
#import "MyQRViewController.h"
#import "BeforeScanSingleton.h"

@interface BaseSearchNavBarView()<UITextFieldDelegate>
//JXCategoryViewDelegate

@end

@implementation BaseSearchNavBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubviews];
    }
    return self;
}

-(void)creatSubviews{
    
    self.backgroundColor = UIColor.clearColor;
    
    self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, KStatusBarHeight + 7, 30, 30)];
    [self.backBtn setBackgroundImage:IMAGE_NAMED(@"bar_back") forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backOperation) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchClick)];
    UIView *searchBgView = [[UIView alloc]initWithFrame:CGRectMake(44, KStatusBarHeight + 7 , ScreenWidth - 44 - 60, 30)];
    searchBgView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5" alpha:0.45];
    searchBgView.layer.cornerRadius = 5;
    searchBgView.layer.masksToBounds = YES;
    searchBgView.layer.borderWidth = .5;
    searchBgView.layer.borderColor = UIColor.clearColor.CGColor;
    [searchBgView addGestureRecognizer:tap];
    [self addSubview:searchBgView];
    self.searchView = searchBgView;
 
    UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"放大镜")];
    img.frame = CGRectMake(13, 5, 20, 20);
    [searchBgView addSubview:img];
    self.searchImgV = img;
    
    self.searchField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.searchField.font = [UIFont systemFontOfSize:13];
    self.searchField.placeholder = @"输入宝贝名称";
    self.searchField.textColor = KWhiteTextColor;
    self.searchField.frame = CGRectMake(38, 0, searchBgView.frame.size.width - 43, 30);
    self.searchField.userInteractionEnabled = NO;
    self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [searchBgView addSubview:self.searchField];
    
    NSAttributedString *attrString = [[NSAttributedString alloc]initWithString:@"输入宝贝名称" attributes:@{NSForegroundColorAttributeName:KWhiteTextColor,NSFontAttributeName:self.searchField.font}];
    self.searchField.attributedPlaceholder = attrString;
    
    UIButton *searchB = [BaseButton CreateBaseButtonTitle:@"搜索" Target:self Action:@selector(searchBtnClicked:) Font:[UIFont systemFontOfSize:15] BackgroundColor:UIColor.clearColor Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:10];
    searchB.frame = CGRectMake(ScreenWidth - 52, 0, 40 , 30);
    searchB.centerY = searchBgView.centerY;
    [self addSubview:searchB];
    self.searchBtn = searchB;
}

- (void)setFieldEnabled:(BOOL)fieldEnabled{
    _fieldEnabled = fieldEnabled;
    self.searchField.userInteractionEnabled = fieldEnabled;
}

- (void)setHiddenBackBtn:(BOOL)hiddenBackBtn{
    _hiddenBackBtn = hiddenBackBtn;
    self.backBtn.hidden = _hiddenBackBtn;
    self.searchView.frame = CGRectMake( _hiddenBackBtn ? 12 : 44, KStatusBarHeight + 7 , ScreenWidth- 60 - (_hiddenBackBtn ?12 : 44), 30);
    self.searchField.frame = CGRectMake(38, 0, self.searchView.frame.size.width - 43, 30);
}

- (void)setBtnAry:(NSArray *)btnAry{
    _btnAry = btnAry;
    if (_btnAry.count) {
        self.searchBtn.hidden = YES;
        for (int i = 0 ; i < _btnAry.count; i++) {
            UIButton *searchB = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(searchBtnClicked:) Font:[UIFont systemFontOfSize:15] BackgroundColor:UIColor.clearColor Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:11+i];
            [searchB setImage:IMAGE_NAMED(btnAry[i]) forState:UIControlStateNormal];
            [searchB setImage:IMAGE_NAMED(btnAry[i]) forState:UIControlStateHighlighted];
            searchB.frame = CGRectMake(ScreenWidth - 35 * _btnAry.count + 35*i, 0, 30 , 30);
            searchB.centerY = self.searchView.centerY;
            [self addSubview:searchB];
        }
    }
    self.searchView.frame = CGRectMake(_hiddenBackBtn ? 12 : 44, KStatusBarHeight + 7 , ScreenWidth- 35 * _btnAry.count -12- (_hiddenBackBtn ? 12 : 44), 30);
}

- (void)searchClick{
    if (!self.fieldEnabled) {
        [[AppTool currentVC].navigationController pushViewController:[[SearchListViewController alloc] init] animated:YES];
    }else{
        
    }
}

- (void)searchBtnClicked:(UIButton *)sender{
    if (sender.tag == 10 ) {
        if (!self.fieldEnabled) {
            [[AppTool currentVC].navigationController pushViewController:[[SearchListViewController alloc] init] animated:YES];
        }else{
            [self.searchField resignFirstResponder];
            if (_viewClickBlock) {
                _viewClickBlock(0,self.searchField.text);
            }
        }
    }
    if (sender.tag == 11) {
        NSLog(@"消息");
        if (_viewClickBlock) {
            _viewClickBlock(1,self.searchField.text);
        }
    }
    if (sender.tag == 12) {
        NSLog(@"扫描");
        [self scan];
        if (_viewClickBlock) {
            _viewClickBlock(2,self.searchField.text);
        }
    }
}

- (void)scan{
    [[BeforeScanSingleton shareScan] ShowSelectedType:QQStyle WithViewController:AppTool.currentVC];
}

- (void)backOperation{
    [[AppTool currentVC].navigationController popViewControllerAnimated:YES];
}

@end

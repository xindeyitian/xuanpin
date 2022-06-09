//
//  BingDingYanZhengViewController.m
//  SmallB
//
//  Created by zhang on 2022/5/18.
//

#import "BingDingYanZhengViewController.h"
#import "SafeKeyboard.h"
#import "SMSCodeInputView.h"
#import <IQKeyboardManager.h>

@interface BingDingYanZhengViewController ()

@property(nonatomic , strong)SMSCodeInputView *inputV;

@end

@implementation BingDingYanZhengViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(154));
    }];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"身份证后6位验证" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(18)];
    title.frame = CGRectMake(40, 20, ScreenWidth - 48 - 80, 26);
    [self.bgView addSubview:title];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectZero];
    [btn setImage:IMAGE_NAMED(@"btn_delete_btn") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnCliCK) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(22);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.top.mas_equalTo(self.bgView).offset(22);
    }];

    SMSCodeInputView *inputView = [[SMSCodeInputView alloc] initWithFrame:CGRectMake(24, 76, ScreenWidth - 96, 40)];
    inputView.firstSpace = 12;
    inputView.codeSpace = 10;
    inputView.codeCount = 6;
    [self.bgView addSubview:inputView];
    CJWeakSelf()
    
    inputView.viewBlock = ^{
        CJStrongSelf()
        [inputView resignFirstResponder];
        NSLog(@"输入结果1:%@",inputView.codeText);
        [self yanZheng];
    };
    self.inputV = inputView;
    [inputView.textField becomeFirstResponder];
    
    SafeKeyboard *safeKeyboard = [SafeKeyboard keyboardWithTextField:inputView.textField];
    [safeKeyboard safeKeyBoardDidChanged:^(NSString *value) {
        
    }];
}

- (void)yanZheng{
    [self startLoadingHUD];
    [THHttpManager FormatPOST:@"shop/shopUser/verifyIdCard" parameters:@{@"idCardNo":self.inputV.codeText} dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode == 200) {
            [self showSuccessMessageWithString:@"身份证后6位验证成功"];
            if (_viewBlock) {
                _viewBlock();
            }
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    }];
}

- (void)btnCliCK{
    [self dismissViewControllerAnimated:NO completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

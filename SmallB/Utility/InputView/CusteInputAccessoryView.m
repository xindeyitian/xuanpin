//
//  CusteInputAccessoryView.m
//  CreditManager
//
//  Created by 李经纬 on 2017/8/31.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "CusteInputAccessoryView.h"

#import "IQKeyboardManager.h"

@interface CusteInputAccessoryView ()<ShowCodeViewDelegate,UITextFieldDelegate>
{
    UITextField *_tempTextField;
    UIView *_maskView;
}

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *forgetButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UILabel *promptLable;

@property (nonatomic, strong) ShowCodeView *verCodeView;

@property (nonatomic, strong) UITextField *tempTextField;
@property (nonatomic, strong) UIView *maskView;

@end

@implementation CusteInputAccessoryView

/**
 开始响应
 */
- (BOOL)becomeFirstResponder
{
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self.tempTextField];
//    self.verCodeView.numberOfVertificationCode = _numberOfVertificationCode;
    [self cleanCode];
    
    _tempTextField.inputAccessoryView = self;
    NSLog(@"%@", self.verCodeView.subviews);
    return [_tempTextField becomeFirstResponder];
}
/**
 放弃响应
 */
- (BOOL)resignFirstResponder{
    [self cleanCode];
    return  [_tempTextField resignFirstResponder];
}

/** 清除信息*/
- (void)cleanCode{
    self.promptLable.text = @"";
    [self.verCodeView cleanCode];
}

- (void)forgetAction{
    if (self.delegate !=nil && [self.delegate respondsToSelector:@selector(forgetAction)]) {
        [self.delegate forgetAction];
    }
}



- (void)cancelAction{
    [self cleanCode];
    [self.tempTextField resignFirstResponder];
}

#pragma mark -- 基础设置
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.backgroundColor = [UIColor whiteColor];
     [self addSubview:self.titleLabel];
    [self addSubview:self.verCodeView];
    [self addSubview:self.lineView];
    [self addSubview:self.cancelButton];
    [self addSubview:self.forgetButton];
    [self addSubview:self.promptLable];
//    self.isShowForgetButton = NO;
}


-(void)setBorderColor:(UIColor *)borderColor
{
    self.verCodeView.borderColor = borderColor;
}

- (void)setRectViewGap:(CGFloat)rectViewGap
{
    self.verCodeView.rectViewGap = rectViewGap;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    self.verCodeView.secureTextEntry = secureTextEntry;
}


-(void)setBackgroudImageName:(NSString *)backgroudImageName
{
    self.verCodeView.backgroudImageName = backgroudImageName;
}

- (void)setNumberOfVertificationCode:(NSInteger)numberOfVertificationCode
{
    _numberOfVertificationCode = numberOfVertificationCode;
    self.verCodeView.numberOfVertificationCode = numberOfVertificationCode;
}

- (void)setVertificationCode:(NSString *)vertificationCode
{
    self.verCodeView.vertificationCode = vertificationCode;
}

- (void)setIsRounded:(BOOL)isRounded
{
    self.verCodeView.isRounded = isRounded;
}

- (void)setIsShowCancelButton:(BOOL)isShowCancelButton
{
    _isShowCancelButton = isShowCancelButton;
    self.cancelButton.hidden = isShowCancelButton;
}

- (void)setIsShowForgetButton:(BOOL)isShowForgetButton
{
    _isShowForgetButton = isShowForgetButton;
    self.forgetButton.hidden = !isShowForgetButton;
}

- (void)setPromptText:(NSString *)promptText
{
    _promptText = promptText;
    self.promptLable.text = promptText;
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, 0, self.width, 44);
    self.cancelButton.frame = CGRectMake(ScreenWidth - 15 - 30, 0, 30, 30);
    self.cancelButton.centerY = self.titleLabel.centerY;
    self.lineView.frame = CGRectMake(0, 44, ScreenWidth, 1);
    self.verCodeView.frame = CGRectMake(100 * 0.5, CGRectGetMaxY(self.lineView.frame) + 26, self.width - 100, 44);
    self.forgetButton.frame = CGRectMake(ScreenWidth - 15 - 80, CGRectGetMaxY(self.verCodeView.frame) + 12, 80, 22);
    self.promptLable.frame = CGRectMake(0, CGRectGetMaxY(self.verCodeView.frame) + 12, ScreenWidth, 22);
    
    
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

#pragma mark -- ShowCodeViewDelegate
- (void)achieveTargetNumber:(NSString *)code
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(achieveTargetNumber:)]) {
        [self.delegate achieveTargetNumber:code];
    }
}


//#pragma mark -- UITextFieldDelegate
//
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    NSLog(@"将要开始");
//    return YES;
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [self.maskView removeFromSuperview];
//    [self.tempTextField removeFromSuperview];
//     [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
//    NSLog(@"结束");
//}


//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {{
//   return  self.verCodeView.textField textf
//}

#pragma mark -- 懒加载
- (ShowCodeView *)verCodeView
{
    if (_verCodeView == nil) {
        _verCodeView = [[ShowCodeView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 100, 44)];
        //        _verCodeView.rectViewGap = 10;
        _verCodeView.borderColor = kRGBColor16Bit(0xe5e5e5);
        _verCodeView.isRounded = YES;
        _verCodeView.numberOfVertificationCode = 6;
        _verCodeView.delegate = self;
    }
    return _verCodeView;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    }
    return _lineView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.textColor = kRGBColor16Bit(0x333333);
        _titleLabel.text = @"请输入验证码";
    }
    return _titleLabel;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_cancelButton setImage:[UIImage imageNamed:@"tan_cha"] forState:(UIControlStateNormal)];
        _cancelButton.contentMode = UIViewContentModeCenter;
        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _cancelButton;
}

- (UIButton *)forgetButton
{
    if (_forgetButton == nil) {
        _forgetButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_forgetButton setTitle:@"忘记密码?" forState:(UIControlStateNormal)];
        //        _forgetButton.backgroundColor = KRedColor;
        [_forgetButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
        _forgetButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
         [_forgetButton addTarget:self action:@selector(forgetAction) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _forgetButton;
}

- (UILabel *)promptLable{
    if (_promptLable == nil) {
        _promptLable = [[UILabel alloc] init];
        _promptLable.textColor = kRGBColor16Bit(0x99999);
        _promptLable.font = [UIFont systemFontOfSize:16.f];
        _promptLable.textAlignment = NSTextAlignmentCenter;
    }
    return _promptLable;
}

- (UIView *)maskView
{
    if (_maskView == nil) {
        _maskView = [[UIView alloc] init];
        _maskView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _maskView.backgroundColor = kRGBA(0, 0, 0, 0.4);
    }
    return _maskView;
}

- (UITextField *)tempTextField
{
    if (_tempTextField == nil) {
        _tempTextField = [[UITextField alloc] init];
        _tempTextField.delegate = self;
        _tempTextField.keyboardType = UIKeyboardTypeNumberPad;
        if (@available(iOS 10.0, *)) {
            _tempTextField.textContentType = UITextContentTypeTelephoneNumber;
        } else {
            
        }
        self.verCodeView.textField = _tempTextField;
       
    }
    return _tempTextField;
}

@end

//
//  ShowCodeView.m
//  ZhongbenKaGuanJia
//
//  Created by 李经纬 on 2018/8/16.
//  Copyright © 2018年 李经纬. All rights reserved.
//

#import "ShowCodeView.h"
#import "IQKeyboardManager.h"
@interface ShowCodeView ()<UITextFieldDelegate,UITextPasteDelegate>
{
    //    CGFloat _cententW;
    CGFloat _cententX;
    CGFloat _cententY;
    CGFloat _rectViewW;
}

/**验证码/密码输入框的背景图片*/
@property (nonatomic, strong) UIImageView *backgroundImageView;


@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *lineArray;
@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, strong) UIView *maskView;

@end


@implementation ShowCodeView

- (NSMutableArray *)lineArray
{
    if (!_lineArray) {
        _lineArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _lineArray;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

- (NSMutableArray *)sourceArray
{
    if (!_sourceArray) {
        _sourceArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _sourceArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupView];
}

- (void)setupView{
    self.vertificationCode = @"";
    
    //    self.backgroundColor = [UIColor clearColor];
    // 设置验证码/密码的位数默认为四位
    self.numberOfVertificationCode = 6;
    /* 调出键盘的textField */
    self.textField = [[UITextField alloc] initWithFrame:self.bounds];
    self.textField.hidden = YES;
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.delegate = self;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
    self.textField.inputAccessoryView = view;
    if (@available(iOS 12.0, *)) {
        //Xcode 10 适配
        self.textField.textContentType = UITextContentTypeOneTimeCode;
        //非Xcode 10 适配
        self.textField.textContentType = @"one-time-code";
    }
    [self insertSubview:self.textField atIndex:0];
    
    UIPasteboard *pes = [[UIPasteboard alloc]init];
    
}

- (void)setTextField:(UITextField *)textField
{
    _textField = textField;
    _textField.delegate = self;
    //    _textField.hidden = YES;
    //    _textField.keyboardType = UIKeyboardTypeNumberPad;
}


- (void)setNumberOfVertificationCode:(NSInteger)numberOfVertificationCode {
    UIColor *useColor = kRGB(229, 229, 229);
    if (self.borderColor) {
        useColor = self.borderColor;
    }
    [self.textField becomeFirstResponder];
    if (self.dataArray.count != 0) {
        for (UILabel *label in self.dataArray) {
            [label removeFromSuperview];
        }
    }
    
    [self.dataArray removeAllObjects];
    
    _numberOfVertificationCode = numberOfVertificationCode;
    
    for (int i = 0; i < _numberOfVertificationCode; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = kRGBColor16Bit(0x333333);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16.f];
        label.tag = 200 + i;
        [self addSubview:label];
        if (_rectViewGap == 0 && i < _numberOfVertificationCode - 1) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = useColor;
            [self addSubview:view];
            [self.lineArray addObject:view];
        }
        if (self.isRounded) {
            ViewBorderRadius(self, 5, 1, useColor);
        }
        
        [self.dataArray addObject:label];
        
    }
    
    
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _rectViewW = (self.width - (_rectViewGap * (_numberOfVertificationCode - 1))) / _numberOfVertificationCode;
    _cententX = 0.f;
    for (int i = 0; i < self.dataArray.count; i++) {
        UILabel *label = self.dataArray[i];
        label.frame = CGRectMake(_cententX + (i % _numberOfVertificationCode) * (_rectViewW + _rectViewGap) , _cententY, _rectViewW, self.height);
    }
    
    for (int i = 0; i < self.lineArray.count ; i++) {
        UIView *view = self.lineArray[i];
        view.frame = CGRectMake(_rectViewW + (i % _numberOfVertificationCode) * (_rectViewW + _rectViewGap), 0, 1, self.height);
    }
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 判断是不是“删除”字符
    if (string.length != 0) {// 不是“删除”字符
        // 判断验证码/密码的位数是否达到预定的位数
        if (self.vertificationCode.length < self.numberOfVertificationCode) {
            
            UILabel *label = self.dataArray[self.vertificationCode.length];
            //            SBLog(@"%@",label);
            label.text = string;
            if (self.secureTextEntry) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    label.text = @"●";
                });
            }
            
            [self.sourceArray addObject:string];
            self.vertificationCode = [self.vertificationCode stringByAppendingString:string];
            if (self.vertificationCode.length == self.numberOfVertificationCode) {
                if (self.delegate != nil && [self.delegate respondsToSelector:@selector(achieveTargetNumber:)]) {
                    [self.delegate achieveTargetNumber:self.vertificationCode];
                }
            }
            
            return YES;
        } else {
            return NO;
        }
    } else { // 是“删除”字符
        self.vertificationCode = [self.vertificationCode substringToIndex:self.vertificationCode.length - 1];
        //        [self.sourceArray removeLastObject];
        UILabel *label = self.dataArray[self.vertificationCode.length];
        label.text = @"";
        [self.sourceArray removeLastObject];
        return YES;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.currentViewController.view addSubview:self.maskView];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    NSLog(@"将要开始");
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.maskView removeFromSuperview];
    [self.textField removeFromSuperview];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    NSLog(@"结束");
}

- (void)cleanCode
{
    [self.sourceArray removeAllObjects];
    for (int i = 0 ;i < self.dataArray.count ; i++) {
        UILabel *label = self.dataArray[i];
        label.text = @"";
        
    }
    NSLog(@"%@", self.subviews);
    self.textField.text = @"";
    self.vertificationCode = @"";
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



@end

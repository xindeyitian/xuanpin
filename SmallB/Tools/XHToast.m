//
//  XHToast.m

//  Copyright (c) 2016 XHToast ( https://github.com/CoderZhuXH/XHToast )

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "XHToast.h"

//Toast默认停留时间
#define ToastDispalyDuration 1.2f
//Toast到顶端/底端默认距离
#define ToastSpace 100.0f
//Toast背景颜色
#define ToastBackgroundColor [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.75]

@interface XHToast ()
@property(nonatomic,strong)UIButton *contentView;
@property(nonatomic,assign)CGFloat duration;
@end

@implementation XHToast

static XHToast *_instance;

+ (instancetype)shared{
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[super allocWithZone:nil] init];
        });
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [XHToast shared];
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [XHToast shared];
}

- (id)initWithText:(NSString *)text{
    if ((self = [XHToast shared])) {
        
        UIFont *font = [UIFont boldSystemFontOfSize:16];
        NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
        CGRect rect=[text boundingRectWithSize:CGSizeMake(ScreenWidth-50,CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,rect.size.width + 100, rect.size.height+ 30)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = font;
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        
        self.contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textLabel.frame.size.width, textLabel.frame.size.height)];
        self.contentView.layer.cornerRadius = 5.0f;
        self.contentView.backgroundColor = ToastBackgroundColor;
        [self.contentView addSubview:textLabel];
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.contentView addTarget:self action:@selector(toastTaped:) forControlEvents:UIControlEventTouchDown];
        self.contentView.alpha = 0.0f;
        self.duration = ToastDispalyDuration;
        
    }
    
    return self;
}

- (id)initWithText:(NSString *)text withName:(NSString *)imageName{
    if ((self = [XHToast shared])) {
        
        UIFont *font = [UIFont boldSystemFontOfSize:17];
        NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
        CGRect rect=[text boundingRectWithSize:CGSizeMake(ScreenWidth-50,CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 54,rect.size.width + 30, rect.size.height+ 30)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = font;
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 35, 35)];
        imgV.image = IMAGE_NAMED(imageName);
        if (imageName.length == 0) {
            imgV.image = IMAGE_NAMED(@"toast_center_img");
        }
        
        self.contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textLabel.frame.size.width+20, textLabel.frame.size.height+56)];
        self.contentView.layer.cornerRadius = 5.0f;
        self.contentView.backgroundColor = ToastBackgroundColor;
        imgV.centerX = textLabel.centerX;
        
        [self.contentView addSubview:imgV];
        [self.contentView addSubview:textLabel];
        
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.contentView addTarget:self action:@selector(toastTaped:) forControlEvents:UIControlEventTouchDown];
        self.contentView.alpha = 0.0f;
        self.duration = ToastDispalyDuration;
    }
    return self;
}

-(void)dismissToast{
    
    [self.contentView removeFromSuperview];
}

-(void)toastTaped:(UIButton *)sender{
    
    [self hideAnimation];
}

-(void)showAnimation{
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    self.contentView.alpha = 1.0f;
    [UIView commitAnimations];
}

-(void)hideAnimation{
    [UIView beginAnimations:@"hide" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissToast)];
    [UIView setAnimationDuration:0.3];
    self.contentView.alpha = 0.0f;
    [UIView commitAnimations];
}
+(UIWindow *)window
{
    return [XHToast cj_topNormalWindow];
}

+ (UIWindow *)cj_keyWindow {
    static __weak UIWindow *_keyWindow = nil;
    
    /*  (Bug ID: #23, #25, #73)   */
    UIWindow *originalKeyWindow = [[UIApplication sharedApplication] keyWindow];
    
    //If original key window is not nil and the cached keywindow is also not original keywindow then changing keywindow.
    if (originalKeyWindow != nil &&
        _keyWindow != originalKeyWindow)
    {
        _keyWindow = originalKeyWindow;
    }
    
    return _keyWindow;
}


+ (UIWindow *)cj_topNormalWindow
{
    UIWindow *topWindow = [XHToast cj_keyWindow];
    
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows)
    {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        
        if(windowOnMainScreen && windowIsVisible && windowLevelNormal)
        {
            topWindow = window;
            break;
        }
    }
    
    return topWindow;
}

- (void)showIn:(UIView *)view{
    self.contentView.center = view.center;
    [view  addSubview:self.contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:self.duration];
}

- (void)showIn:(UIView *)view fromTopOffset:(CGFloat)top{
    self.contentView.center = CGPointMake(view.center.x, top + self.contentView.frame.size.height/2);
    [view  addSubview:self.contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:self.duration];
}

- (void)showIn:(UIView *)view fromBottomOffset:(CGFloat)bottom{
    self.contentView.center = CGPointMake(view.center.x, view.frame.size.height-(bottom + self.contentView.frame.size.height/2));
    [view  addSubview:self.contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:self.duration];
}

+ (void)dismiss {
    //    [[XHToast new] hideAnimation];
    [[XHToast shared] dismissToast];
}

#pragma mark-中间显示
+ (void)showCenterWithText:(NSString *)text{
    
    [XHToast showCenterWithText:text duration:ToastDispalyDuration];
}

+ (void)showCenterWithText:(NSString *)text withName:(NSString *)imageName {
    XHToast *toast = [[XHToast alloc] initWithText:text withName:imageName];
    toast.duration = ToastDispalyDuration;
    [toast showIn:[self window]];
}

+ (void)showCenterWithText:(NSString *)text duration:(CGFloat)duration{
    
    XHToast *toast = [[XHToast alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:[self window]];
}

/**
 *  中间显示+自定义停留时间
 *
 *  @param text     内容
 *  @param duration 停留时间
 *  @param view view
 */
+ (void)showCenterWithText:(NSString *)text duration:(CGFloat)duration view:(UIView *)view {
    XHToast *toast = [[XHToast alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:view ? view : [self window]];
}
#pragma mark-上方显示
+ (void)showTopWithText:(NSString *)text{
    
    [XHToast showTopWithText:text  topOffset:ToastSpace duration:ToastDispalyDuration];
}
+ (void)showTopWithText:(NSString *)text duration:(CGFloat)duration
{
    [XHToast showTopWithText:text  topOffset:ToastSpace duration:duration];
}
+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset{
    [XHToast showTopWithText:text  topOffset:topOffset duration:ToastDispalyDuration];
}

+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration{
    XHToast *toast = [[XHToast alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:[self window] fromTopOffset:topOffset];
}
#pragma mark-下方显示
+ (void)showBottomWithText:(NSString *)text{
    
    [XHToast showBottomWithText:text  bottomOffset:ToastSpace duration:ToastDispalyDuration];
}
+ (void)showBottomWithText:(NSString *)text duration:(CGFloat)duration
{
    [XHToast showBottomWithText:text  bottomOffset:ToastSpace duration:duration];
}
+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset{
    [XHToast showBottomWithText:text  bottomOffset:bottomOffset duration:ToastDispalyDuration];
}

+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration{
    XHToast *toast = [[XHToast alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:[self window] fromBottomOffset:bottomOffset];
}

@end


@implementation UIView (XHToast)

#pragma mark-中间显示
- (void)showXHToastCenterWithText:(NSString *)text
{
    [self showXHToastCenterWithText:text duration:ToastDispalyDuration];
}

- (void)showXHToastCenterWithText:(NSString *)text duration:(CGFloat)duration
{
    XHToast *toast = [[XHToast alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:self];
}

#pragma mark-上方显示
- (void)showXHToastTopWithText:(NSString *)text
{
    [self showXHToastTopWithText:text topOffset:ToastSpace duration:ToastDispalyDuration];
}

- (void)showXHToastTopWithText:(NSString *)text duration:(CGFloat)duration
{
    [self showXHToastTopWithText:text topOffset:ToastSpace duration:duration];
}

- (void)showXHToastTopWithText:(NSString *)text topOffset:(CGFloat)topOffset
{
    [self showXHToastTopWithText:text topOffset:topOffset duration:ToastDispalyDuration];
}

- (void)showXHToastTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration
{
    XHToast *toast = [[XHToast alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:self fromTopOffset:topOffset];
}

#pragma mark-下方显示
- (void)showXHToastBottomWithText:(NSString *)text
{
    [self showXHToastBottomWithText:text bottomOffset:ToastSpace duration:ToastDispalyDuration];
}

- (void)showXHToastBottomWithText:(NSString *)text duration:(CGFloat)duration
{
    [self showXHToastBottomWithText:text bottomOffset:ToastSpace duration:duration];
}

- (void)showXHToastBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset
{
    [self showXHToastBottomWithText:text bottomOffset:bottomOffset duration:ToastDispalyDuration];
}

- (void)showXHToastBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration
{
    XHToast *toast = [[XHToast alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:self fromBottomOffset:bottomOffset];
}

@end


//
//  MessageView.m
//  ZhongbenKaGuanJia
//
//  Created by 李经纬 on 2018/8/15.
//  Copyright © 2018年 李经纬. All rights reserved.
//

#import "MassageView.h"

#import "KLCPopup.h"

@interface MassageView()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondTitleLable;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewH;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end
static MassageView* _instance = nil;

@implementation MassageView

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[[NSBundle mainBundle] loadNibNamed:@"MassageView" owner:nil options:nil] lastObject];
        _instance.frame = CGRectMake(0, 0, ScreenWidth - 80, CGRectGetMaxY(_instance.cancelButton.frame));
    }) ;
    
    return _instance ;
}


- (void)messageShowWithTitle:(NSString *)title  SecondTitle:(NSString *)secTitle Content:(NSString *)content{
    CGFloat height;
    if (content.length) {
       height = [self heightForString:content andWidth:(ScreenWidth - 80 - 20)];
    } else {
        height = [self heightForString:@"暂无消息" andWidth:(ScreenWidth - 80 - 20)];
    }
    self.contentViewH.constant = height + 150;
    
    self.frame = CGRectMake(0, 0, ScreenWidth - 80, self.contentViewH.constant + 20 + 36);
    
    if (title.length) {
      self.titleLabel.text = title;
    }
    if (secTitle.length) {
        self.secondTitleLable.text = secTitle;
    }
    
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutCenter);
    
    KLCPopup *popup = [KLCPopup popupWithContentView:self showType:(KLCPopupShowTypeSlideInFromTop) dismissType:(KLCPopupDismissTypeFadeOut) maskType:(KLCPopupMaskTypeDimmed) dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
   
    [popup showWithLayout:layout];
}

- (IBAction)dismissButtonPressed:(UIButton *)sender {
    if ([sender isKindOfClass:[UIView class]]) {
        [(UIView*)sender dismissPresentingPopup];
    }
}

/**
 @method 获取指定宽度width,字体大小fontSize,字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
- (float) heightForString:(NSString *)value andWidth:(float)width{
    //获取当前文本的属性
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:value];
     self.contentLabel.attributedText = attrStr;
    // 计算文本的大小
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:@{NSFontAttributeName: self.contentLabel.font}        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.height + 30;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

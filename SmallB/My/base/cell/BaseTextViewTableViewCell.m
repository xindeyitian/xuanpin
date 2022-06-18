//
//  BaseTextViewTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/15.
//

#import "BaseTextViewTableViewCell.h"

@interface BaseTextViewTableViewCell ()<UITextViewDelegate>

@end

@implementation BaseTextViewTableViewCell

-(void)k_creatSubViews{
    [super k_creatSubViews];
    
    self.bgView.layer.cornerRadius = 12;
    [self creatBaseSubViews];
}

- (void)creatBaseSubViews{
    self.textV = [[GCPlaceholderTextView alloc]init];
    self.textV.font = DEFAULT_FONT_R(15);
    self.textV.backgroundColor = kRGB(245, 245, 245);
    self.textV.delegate = self;
    self.textV.placeholder = @"本店精品为您优选，惊喜不断，欢迎进店选购";
    [self.bgView addSubview:self.textV];
    
    [self.textV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.bgView).insets(UIEdgeInsetsMake(5, 12, 10+18, 12));
    }];
    
    self.contentView.backgroundColor = KWhiteBGColor;
    self.bgView.backgroundColor = kRGB(245, 245, 245);
    
    UILabel *num = [UILabel creatLabelWithTitle:@"20/20" textColor:KBlack999TextColor textAlignment:NSTextAlignmentRight font:DEFAULT_FONT_R(11)];
    [self.bgView addSubview:num];
    [num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(12);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.bottom.mas_equalTo(self.bgView).offset(-5);
        make.height.mas_equalTo(18);
    }];
    self.numL = num;
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 20) {
        textView.text = [textView.text substringToIndex:20];
    }else{
        self.numL.text = [NSString stringWithFormat:@"%lu/20",(unsigned long)textView.text.length];
    }
    if (_viewBlock) {
        _viewBlock(textView.text);
    }
}

//- (void)textViewDidEndEditing:(UITextView *)textView{
//    if (textView.text.length > 20) {
//        textView.text = [textView.text substringToIndex:20];
//    }else{
//        self.numL.text = [NSString stringWithFormat:@"%lu/20",(unsigned long)textView.text.length];
//    }
//}

@end

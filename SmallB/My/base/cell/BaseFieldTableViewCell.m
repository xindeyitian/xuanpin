//
//  BaseFieldTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/13.
//

#import "BaseFieldTableViewCell.h"

@interface BaseFieldTableViewCell ()<UITextFieldDelegate>

@end

@implementation BaseFieldTableViewCell

-(void)k_creatSubViews{
    [super k_creatSubViews];
    
    self.bgView.layer.cornerRadius = 12;
    self.bgView.userInteractionEnabled = YES;
    [self creatBaseSubViews];
}

- (void)creatBaseSubViews{
    self.fieldT = [[UITextField alloc]init];
    self.fieldT.font = DEFAULT_FONT_R(15);
    self.fieldT.placeholder = @"";
    self.fieldT.delegate = self;
    [self.fieldT addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    [self.bgView addSubview:self.fieldT];
    
    [self.fieldT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.bgView).insets(UIEdgeInsetsMake(5, 12, 5, 12));
    }];
    
    self.rightImgV = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"supplier_right_select")];
    [self.bgView addSubview:self.rightImgV];
    [self.rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(18);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
    }];
    self.rightImgV.hidden = YES;
    self.contentView.backgroundColor = KWhiteBGColor;
    self.bgView.backgroundColor = kRGB(245, 245, 245);
}

- (void)setHavRightImgV:(BOOL)havRightImgV{
    self.rightImgV.hidden = !havRightImgV;
    [self.fieldT mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.bgView).insets(UIEdgeInsetsMake(5, 12, 5, havRightImgV ? 40 : 12));
    }];
    self.fieldT.userInteractionEnabled = !havRightImgV;
}

- (void)setMaxNum:(NSInteger)maxNum{
    _maxNum = maxNum;
}

- (void)textFieldDidEditing:(UITextField *)field{
    if (field.text.length > self.maxNum && self.maxNum) {
        field.text = [field.text substringToIndex:self.maxNum];
    }
    if (_viewBlock) {
        _viewBlock(field.text);
    }
}

//-(void)textFieldDidEndEditing:(UITextField *)textField{
//    if (_viewBlock) {
//        _viewBlock(textField.text);
//    }
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    if (_viewBlock) {
//        _viewBlock(textField.text);
//    }
//    return YES;
//}

@end

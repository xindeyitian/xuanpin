//
//  BasePhoneTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/15.
//

#import "BasePhoneTableViewCell.h"

@implementation BasePhoneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatBaseSubViews];
    }
    return self;
}

- (void)creatBaseSubViews{
    
    self.contentView.backgroundColor = KWhiteBGColor;
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = kRGB(245, 245, 245);
    bgView.clipsToBounds = YES;
    bgView.layer.cornerRadius = 12;
    [self.contentView addSubview:bgView];
    self.BGView = bgView;
    
    [bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 12, 0, 12));
    }];
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"+86" Target:self Action:@selector(zoneClick) Font:DEFAULT_FONT_R(14) BackgroundColor:UIColor.clearColor Color:KBlack333TextColor Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:1];
    [btn setImage:IMAGE_NAMED(@"arrow_bottom") forState:UIControlStateNormal];
    [btn layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyleRight) imageTitleSpace:12];
    [bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView).offset(6);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(50);
        make.centerY.mas_equalTo(bgView.mas_centerY);
    }];
    
    self.fieldT = [[UITextField alloc]init];
    self.fieldT.font = DEFAULT_FONT_R(15);
    self.fieldT.placeholder = @"请输入手机号";
    self.fieldT.delegate = self;
    self.fieldT.keyboardType = UIKeyboardTypeNumberPad;
    [self.fieldT addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:self.fieldT];
    
    NSString *userPhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"];
    if (userPhone.length) {
        self.fieldT.text = userPhone;
        self.fieldT.userInteractionEnabled = NO;
    }

    [self.fieldT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(bgView).insets(UIEdgeInsetsMake(5, 72, 5, 12));
    }];
}

- (void)zoneClick{
    
}

- (void)textFieldDidEditing:(UITextField *)field{
    
    if (_viewBlock) {
        _viewBlock(field.text);
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (_viewBlock) {
        _viewBlock(textField.text);
    }
}
            
@end


//
//  BaseCommonPhoneCell.m
//  SmallB
//
//  Created by zhang on 2022/6/16.
//

#import "BaseCommonPhoneCell.h"

@implementation BaseCommonPhoneCell

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
        make.edges.mas_equalTo(bgView).insets(UIEdgeInsetsMake(5, 12, 5, 12));
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


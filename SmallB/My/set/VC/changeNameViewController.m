//
//  changeNameViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import "changeNameViewController.h"

@interface changeNameViewController ()

@property(nonatomic,strong)UITextField *fieldT;

@end

@implementation changeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"昵称修改" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(18)];
    [self.bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(22);
        make.height.mas_equalTo(30);
        make.left.right.mas_equalTo(self.bgView);
    }];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = KBGLightColor;
    [self.bgView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(27);
        make.height.mas_equalTo(52);
        make.left.mas_equalTo(self.bgView).offset(12);
        make.right.mas_equalTo(self.bgView).offset(-12);
    }];
    
    UITextField *field= [[UITextField alloc]init];
    field.placeholder = @"昵称建议输入8位字符以内";
    field.text = self.nameStr;
    field.backgroundColor = KBGLightColor;
    field.clipsToBounds = YES;
    field.layer.cornerRadius = YES;
    field.layer.cornerRadius = 8;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    [field addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    [view addSubview:field];
    self.fieldT = field;
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view).insets(UIEdgeInsetsMake(0, 12, 0, 12));
    }];
    
    BaseButton *cancelBtn = [BaseButton CreateBaseButtonTitle:@"取消" Target:self Action:@selector(confirmClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:KBGColor Color:KBlack333TextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:22];
    [self.bgView addSubview:cancelBtn];
    cancelBtn.clipsToBounds = YES;
    cancelBtn.layer.cornerRadius = 22;
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-26);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(143);
        make.left.mas_equalTo(self.bgView).offset(12);
    }];
    
    BaseButton *confirmBtn = [BaseButton CreateBaseButtonTitle:@"确认" Target:self Action:@selector(confirmClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:23];
    [self.bgView addSubview:confirmBtn];
    confirmBtn.clipsToBounds = YES;
    confirmBtn.layer.cornerRadius = 22;
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-26);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(143);
        make.right.mas_equalTo(self.bgView).offset(-12);
    }];
}

- (void)textFieldDidEditing:(UITextField *)field{
    if (field.text.length > 8) {
        field.text = [field.text substringToIndex:8];
    }
}

- (void)confirmClick:(BaseButton *)btn{
    if (btn.tag == 22) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
   
    if (btn.tag == 23) {
        if(self.fieldT.text.length == 0){
            [self showMessageWithString:@"请输入名字"];
            return;
        }
        if(self.fieldT.text.length > 8){
            [self showMessageWithString:@"昵称建议输入8位字符以内"];
            return;
        }
        if (_viewBlock) {
            _viewBlock(self.fieldT.text);
        }
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

@end

//
//  WithdrawPasswordViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/25.
//

#import "WithdrawPasswordViewController.h"
#import "BasePhoneTableViewCell.h"
#import "BasePhoneCodeTableViewCell.h"

@interface WithdrawPasswordViewController ()<UITextFieldDelegate>

@property (nonatomic , copy)NSString *phone;
@property (nonatomic , copy)NSString *code;

@end

@implementation WithdrawPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置提现密码";
    if (self.isEdit) {
        self.navigationItem.title = @"修改提现密码";
    }
    
    self.view.backgroundColor = KWhiteBGColor;
    self.tableView.backgroundColor = KWhiteBGColor;
    
    self.phone = @"";
    self.code = @"";
    
    if (self.isEdit) {
        [self.tableView registerClass:[BasePhoneTableViewCell class] forCellReuseIdentifier:[BasePhoneTableViewCell description]];
        [self.tableView registerClass:[BasePhoneCodeTableViewCell class] forCellReuseIdentifier:[BasePhoneCodeTableViewCell description]];
    }else{
        UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 47)];
        headV.backgroundColor = KWhiteBGColor;
        UILabel *title = [UILabel creatLabelWithTitle:@"请谨慎输入提现密码并牢记！" textColor:KMaintextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_R(12)];
        title.frame = CGRectMake(12, 27, ScreenWidth - 24, 20);
        [headV addSubview:title];
        self.tableView.tableHeaderView = headV;
    }

    UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    footerV.backgroundColor = KWhiteBGColor;
    self.tableView.tableFooterView = footerV;
    
    for (int i =0; i < 2; i ++) {
        UIView *grayV = [[UIView alloc]initWithFrame:CGRectMake(12, 8 + (52+8)*i, ScreenWidth - 24, 52)];
        grayV.backgroundColor = KBGLightColor;
        grayV.clipsToBounds = YES;
        grayV.layer.cornerRadius = 6;
        [footerV addSubview:grayV];
        
        UITextField *field = [[UITextField alloc]init];
        field.placeholder = i == 0 ? @"请输入提现密码":@"再次输入提现密码";
        field.font = DEFAULT_FONT_R(15);
        field.tag = 111 + i;
        field.delegate = self;
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
        field.keyboardType = UIKeyboardTypeNumberPad;
        [grayV addSubview:field];
        [field addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
        [field mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(grayV).insets(UIEdgeInsetsMake(6, 12, 6, 12));
        }];
    }
    
    BaseButton *btn = [BaseButton CreateBaseButtonTitle:@"确认" Target:self Action:@selector(btnClick) Font:DEFAULT_FONT_M(17) BackgroundColor:KMainBGColor Color:KWhiteTextColor Frame:CGRectMake(12, 150, ScreenWidth - 24, 50) Alignment:NSTextAlignmentCenter Tag:3];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 25;
    [footerV addSubview:btn];
}

- (void)textFieldDidEditing:(UITextField *)field{
    if (field.text.length > 6) {
        field.text = [field.text substringToIndex:6];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (![toString isEqualToString:@""]) {
        if ([self isChinese:toString]) {
            return NO;
        }
    }
    return YES;
}
- (BOOL)isChinese:(NSString *)string {
    NSString *regex = @"^[\u4E00-\u9FA5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isEdit) {
        if (indexPath.section == 0) {
            BasePhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BasePhoneTableViewCell description]];
            cell.BGView.layer.cornerRadius = 6;
            self.phone = cell.fieldT.text;
//            cell.viewBlock = ^(NSString * _Nonnull content) {
//                self.phone = content;
//                [self.tableView reloadData];
//            };
            return cell;
        }
        if (indexPath.section == 1) {
            BasePhoneCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BasePhoneCodeTableViewCell description]];
            cell.BGView.layer.cornerRadius = 6;
            cell.phoneType = @"8";
            cell.phone = self.phone;
            cell.viewBlock = ^(NSString * _Nonnull content) {
                self.code = content;
            };
            return cell;
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell description]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.isEdit) {
        return 2;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.isEdit) {
        return 8;
    }
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.isEdit) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 8)];
        view.backgroundColor = KWhiteBGColor;
        return view;
    }
    return [UIView new];
}

- (void)btnClick{
    if (self.isEdit) {
        if (self.phone.length == 0) {
            [self showMessageWithString:@"请输入手机号"];
            return;
        }
        if (self.code.length == 0) {
            [self showMessageWithString:@"请输入验证码"];
            return;
        }
    }else{
        
    }
    UITextField *field1 = [self.view viewWithTag:111];
    UITextField *field2 = [self.view viewWithTag:112];
 
    //两次输入的密码不一致，请重新设置！
    //提现密码设置成功！
    //密码修改成功，请牢记密码！
    
    if (field1.text.length == 0) {
        [self showMessageWithString:@"请输入提现密码"];
        return;
    }
    if (field1.text.length < 6) {
        [self showMessageWithString:@"请输入6位提现密码"];
        return;
    }
    if (field2.text.length == 0) {
        [self showMessageWithString:@"请再次输入提现密码"];
        return;
    }
    if (![field2.text isEqualToString:field1.text]) {
        [self showMessageWithString:@"两次输入的密码不一致，请重新设置！"];
        return;
    }
    [self startLoadingHUD];
    NSString *url = @"";
    NSDictionary *dica;
    if (self.isEdit) {
        url = @"shop/shopIdcardAuth/updateWithdrawPwd";
        dica = @{@"pwd":field2.text,
                 @"phoneNum":self.phone,
                 @"verificationCode":self.code
        };
    }else{
        url = @"shop/shopIdcardAuth/setWithdrawPwd";
        dica = @{@"pwd":field2.text};
    }
    [THHttpManager FormatPOST:url parameters:dica dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        [self stopLoadingHUD];
        if (returnCode ==200) {
            if (_setPasswordSuccessBlock) {
                _setPasswordSuccessBlock();
            }
            if (self.isEdit) {
                [self showSuccessMessageWithString:@"密码修改成功，请牢记密码!"];
            }else{
                [self showSuccessMessageWithString:@"提现密码设置成功!"];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

@end

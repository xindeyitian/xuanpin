//
//  CancelOrderAlertViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/27.
//

#import "OrderAlertViewController.h"

@interface OrderAlertViewController ()

@property (nonatomic , strong)GCPlaceholderTextView *textV;

@end

@implementation OrderAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(240));
    }];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"确定取消订单" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(18)];
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
        make.height.mas_equalTo(70);
        make.left.mas_equalTo(self.bgView).offset(12);
        make.right.mas_equalTo(self.bgView).offset(-12);
    }];
    
    GCPlaceholderTextView *field= [[GCPlaceholderTextView alloc]init];
    field.placeholder = @"请输入取消订单的原因(限25个字符)";
    field.delegate = self;
    field.backgroundColor = KBGLightColor;
    field.clipsToBounds = YES;
    field.layer.cornerRadius = YES;
    field.layer.cornerRadius = 8;
    field.font = DEFAULT_FONT_R(15);
    [view addSubview:field];
    self.textV = field;
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view).insets(UIEdgeInsetsMake(0, 8, 0, 8));
    }];
    /**
     orderAlertType_CancelOrder = 0,//取消订单
     orderAlertType_AgreeRefund,//确定同意退款
     orderAlertType_NotAgreeRefund,//不同意退款
     orderAlertType_AgreeRefunds,//确定同意退货退款
     orderAlertType_NotAgreeRefunds,//不同意退货退款
     */
    switch (self.alertType) {
        case orderAlertType_CancelOrder:{
            title.text = @"确定取消订单";
            field.placeholder = @"请输入取消订单的原因(限25个字符)";
        }
            break;
        case orderAlertType_AgreeRefund:{
            title.text = @"确定同意退款";
            view.hidden = YES;
            [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(170));
            }];
        }
            break;
        case orderAlertType_NotAgreeRefund:{
            title.text = @"不同意退款";
            field.placeholder = @"请输入不同意的原因(限25个字符)";
        }
            break;
        case orderAlertType_AgreeRefunds:{
            title.text = @"确定同意退货退款";
            view.hidden = YES;
            [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(170));
            }];
        }
            break;
        case orderAlertType_NotAgreeRefunds:{
            title.text = @"不同意退货退款";
            field.placeholder = @"请输入不同意的原因(限25个字符)";
        }
            break;
            
        default:
            break;
    }
    
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

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 25) {
        textView.text = [textView.text substringToIndex:25];
    }
}

- (void)confirmClick:(BaseButton *)btn{
    if (btn.tag == 22) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    if (btn.tag == 23) {
        if (self.textV.text.length == 0) {
            [self showMessageWithString:@"请输入原因"];
            return;
        }
        NSString *title = @"";
        switch (self.alertType) {
            case orderAlertType_CancelOrder:{
                title = @"确定取消订单";
                [self startLoadingHUD];
                [THHttpManager POST:@"goods/orderInfo/cancel" parameters:@{@"orderId":self.orderID,@"reason":self.textV.text} dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
                    [self stopLoadingHUD];
                    if (returnCode == 200) {
                        [self showSuccessMessageWithString:@"取消订单成功"];
                        [self success];
                    }
                }];
            }
                break;
            case orderAlertType_AgreeRefund:{
                title = @"确定同意退款";
            }
                break;
            case orderAlertType_NotAgreeRefund:{
                title = @"不同意退款";
            }
                break;
            case orderAlertType_AgreeRefunds:{
                title = @"确定同意退货退款";
            }
                break;
            case orderAlertType_NotAgreeRefunds:{
                title = @"不同意退货退款";
            }
                break;
                
            default:
                break;
        }
    }
   
}

- (void)success{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelSuccess" object:nil];
}

@end

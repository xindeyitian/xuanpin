//
//  withdrawShaixuanView.m
//  SmallB
//
//  Created by zhang on 2022/4/13.
//

#import "withdrawShaixuanView.h"

@interface withdrawShaixuanView ()

@property (nonatomic , strong)shaixuanBtn *startBtn;
@property (nonatomic , strong)shaixuanBtn *endBtn;
@property (nonatomic , strong)shaixuanBtn *typeBtn;
@property (nonatomic , strong)shaixuanBtn *allBtn;

@property (nonatomic , strong)UIColor *defaultColor;
@property (nonatomic , strong)UIColor *selectColor;

@end

@implementation withdrawShaixuanView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)creaSubView{

    [self cleanDateData];
    
    self.backgroundColor = kRGBA(0, 0, 0, 0.45);
    float btnWidth = (ScreenWidth - 48 - 12)/2.0;
    self.defaultColor = kRGB(245, 245, 245);
    self.selectColor = kRGB(250, 237, 235);
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,  self.hiddenStatus ? 240:400)];
    self.bgView.backgroundColor = KWhiteBGColor;
    [self addSubview:self.bgView];
    
    UILabel *dateTitle = [UILabel creatLabelWithTitle:@"日期选择" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(17)];
    [self.bgView addSubview:dateTitle];
    [dateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(16);
        make.top.mas_equalTo(self.bgView).offset(20);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(25);
    }];
    
    shaixuanBtn *allDateBtn = [[shaixuanBtn alloc]initWithFrame:CGRectMake(12, 58 , btnWidth, 40)];
    [allDateBtn setTitle:@"全部日期" forState:UIControlStateNormal];
    [allDateBtn addTarget:self action:@selector(timeClick) forControlEvents:UIControlEventTouchUpInside];
    allDateBtn.selected = YES;
    allDateBtn.backgroundColor = self.selectColor;
    self.allBtn = allDateBtn;
    [self.bgView addSubview:allDateBtn];
 
    shaixuanBtn *startDataeBtn = [[shaixuanBtn alloc]initWithFrame:CGRectMake(12, 109 , btnWidth, 40)];
    [startDataeBtn setTitle:@"开始时间" forState:UIControlStateNormal];
    [startDataeBtn setTitleColor:KBlack999TextColor forState:UIControlStateNormal];
    startDataeBtn.tag = 21;
    [startDataeBtn addTarget:self action:@selector(selectTimeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:startDataeBtn];
    self.startBtn = startDataeBtn;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 13, 1)];
    lineView.centerX = self.bgView.centerX;
    lineView.centerY = startDataeBtn.centerY;
    lineView.backgroundColor = KBlackLineColor;
    [self.bgView addSubview:lineView];
    
    shaixuanBtn *endDataeBtn = [[shaixuanBtn alloc]initWithFrame:CGRectMake(12+btnWidth +37, 109 , btnWidth, 40)];
    [endDataeBtn setTitle:@"结束时间" forState:UIControlStateNormal];
    [endDataeBtn setTitleColor:KBlack999TextColor forState:UIControlStateNormal];
    endDataeBtn.tag = 22;
    [endDataeBtn addTarget:self action:@selector(selectTimeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:endDataeBtn];
    self.endBtn = endDataeBtn;
    
    if (!self.hiddenStatus) {
        UILabel *statusTitle = [UILabel creatLabelWithTitle:@"状态选择" textColor:KBlack333TextColor textAlignment:NSTextAlignmentLeft font:DEFAULT_FONT_M(17)];
        [self.bgView addSubview:statusTitle];
        [statusTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgView).offset(16);
            make.top.mas_equalTo(self.bgView).offset(178);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(25);
        }];
        
        NSArray *titleAry = @[@"全部状态",@"申请中",@"提现成功",@"提现失败"];
        for (int i =0; i< 4; i ++) {
            shaixuanBtn *btn = [[shaixuanBtn alloc]initWithFrame:CGRectMake(24 + (btnWidth + 12)*(i%2), 216 + (40 + 12)*(i/2) , btnWidth, 40)];
            [btn setTitle:titleAry[i] forState:UIControlStateNormal];
            btn.tag = 100+i;
            [btn addTarget:self action:@selector(typeClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.bgView addSubview:btn];
            [self setDefaultType];
        }
    }
    
    for (int i =0; i < 2; i ++) {
        float width = (ScreenWidth - 24)/2.0;
        BaseButton *btn = [BaseButton CreateBaseButtonTitle:i == 0? (self.hiddenStatus ? @"取消" : @"重置"):@"确定" Target:self Action:@selector(btnClick:) Font:DEFAULT_FONT_M(15) BackgroundColor:i == 0 ? kRGB(255, 115, 50):kRGB(250, 23, 45) Color:KWhiteTextColor Frame:CGRectMake(12+width*i, self.hiddenStatus ? 176: 336, width, 44) Alignment:NSTextAlignmentCenter Tag:300+i];
        [self.bgView addSubview:btn];

        if (i == 0 && self.hiddenStatus) {
            [btn setTitleColor:KMaintextColor forState:UIControlStateNormal];
            btn.backgroundColor = KWhiteBGColor;
            btn.layer.borderColor = KMainBGColor.CGColor;
            btn.layer.borderWidth = 1;
            btn.clipsToBounds = YES;
            btn.layer.cornerRadius = 22;
            btn.frame = CGRectMake(12+width*i, self.hiddenStatus ? 176: 336, width + 22, 44);
            [self.bgView sendSubviewToBack:btn];
        }else{
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:i== 0 ? UIRectCornerTopLeft | UIRectCornerBottomLeft : UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(22, 22)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.strokeColor = KMainBGColor.CGColor;
            maskLayer.frame = btn.bounds;
            maskLayer.path = maskPath.CGPath;
            btn.layer.mask = maskLayer;
        }
    }
}

- (void)setHiddenStatus:(BOOL)hiddenStatus{
    _hiddenStatus = hiddenStatus;
    [self creaSubView];
}

- (void)btnClick:(BaseButton *)btn{
    if (btn.tag == 300) {
        if (_cancelBlock) {
            _cancelBlock();
        }
        if (self.hiddenStatus) {
            [self dismiss];
        }else{
            [self setDefaultType];
            [self timeClick];
        }
    }
    if (btn.tag == 301) {
        
        if ((self.selectStartDate.length == 0 && self.selectEndDate.length)|| (self.selectStartDate.length && self.selectEndDate.length == 0)) {
            THBaseViewController *vc = (THBaseViewController *)AppTool.currentVC;
            [vc showMessageWithString:@"请选择开始时间和结束时间"];
            return;
        }
        
        if (self.hiddenStatus) {
            if ((self.selectStartDate.length == 0 && self.selectEndDate.length == 0) && !self.allBtn.selected) {
                THBaseViewController *vc = (THBaseViewController *)AppTool.currentVC;
                [vc showMessageWithString:@"请选择开始时间和结束时间"];
                return;
            }
        }
        
        NSString *dealSign = @"";
        switch (self.typeBtn.tag) {
            case 100:{
                dealSign = @"";
            }
                break;
            case 101:{
                dealSign = @"0";
            }
                break;
            case 102:{
                dealSign = @"1";
            }
                break;
            case 103:{
                dealSign = @"-1";
            }
                break;
                
            default:
                break;
        }
        if (_confirmBlock) {
            _confirmBlock( [NSString stringWithFormat:@"%@",self.selectStartDate], [NSString stringWithFormat:@"%@",self.selectEndDate],dealSign);
        }
        [self dismiss];
    }
}

//设置默认类型
- (void)setDefaultType{
    
    for (int i =0; i < 4; i ++) {
        shaixuanBtn *btn = [self.bgView viewWithTag:100+i];
        btn.selected = NO;
        [self.typeBtn setBackgroundColor:self.defaultColor];
    }
    
    shaixuanBtn *btn = [self.bgView viewWithTag:100];
    self.typeBtn = btn;
    self.typeBtn.selected = YES;
    [self.typeBtn setBackgroundColor:self.selectColor];
}

- (void)typeClick:(shaixuanBtn *)btn{
    if (!btn.selected) {
        [btn setBackgroundColor:self.selectColor];
        btn.selected = YES;
        
        self.typeBtn.selected = NO;
        [self.typeBtn setBackgroundColor:self.defaultColor];
        self.typeBtn = btn;
    }
}

- (void)selectTimeClick:(shaixuanBtn *)btn{
    NSString *selectValue = @"";
    NSDate *minDate = nil;
    NSDate *maxDate = nil;
    
    if (btn.tag == 21) {
        if (self.selectStartDate.length) {
            selectValue = self.selectStartDate;
        }
        if (self.endDate) {
            maxDate = self.endDate;
        }
    }
    if (btn.tag == 22) {
        if (self.selectStartDate.length == 0) {
            THBaseViewController *vc = (THBaseViewController *)AppTool.currentVC;
            [vc showMessageWithString:@"请先选择开始时间"];
            return;
        }
        
        if (self.selectEndDate.length) {
            selectValue = self.selectEndDate;
        }
        if (self.startDate) {
            minDate = self.startDate;
        }
    }
    [BRDatePickerView showDatePickerWithMode:BRDatePickerModeDate title:@"" selectValue:selectValue minDate:minDate maxDate:maxDate isAutoSelect:NO resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
        
        [self setAllBtnDefault];
        
        [btn setTitle:selectValue forState:UIControlStateNormal];
        btn.selected = YES;
        [btn setBackgroundColor:self.selectColor];
        if (btn.tag == 21) {
            self.selectStartDate = selectValue;
            self.startDate = selectDate;
        }else if(btn.tag == 22){
            self.selectEndDate = selectValue;
            self.endDate = selectDate;
        }
    }];
}

//全部时间的点击事件
- (void)timeClick{
    [self cleanDateData];
    [self timeDefaultSelectTime];
    
    self.allBtn.selected = YES;
    self.allBtn.backgroundColor = self.selectColor;
}

//全部时间未选中
- (void)setAllBtnDefault{
    self.allBtn.selected = NO;
    self.allBtn.backgroundColor = self.defaultColor;
}

//全部时间选中
- (void)setAllBtnSelect{
    self.allBtn.selected = YES;
    self.allBtn.backgroundColor = self.selectColor;
}


//开始时间  结束时间的默认
- (void)timeDefaultSelectTime{
    
    [self.startBtn setTitle:@"开始时间" forState:UIControlStateNormal];
    [self.endBtn setTitle:@"结束时间" forState:UIControlStateNormal];
    self.startBtn.selected = self.endBtn.selected = NO;
    [self.startBtn setBackgroundColor:self.defaultColor];
    [self.endBtn setBackgroundColor:self.defaultColor];
}

//清除已选择的数据
- (void)cleanDateData{
    self.selectStartDate = @"";
    self.startDate = nil;
    
    self.selectEndDate = @"";
    self.endDate = nil;
}

- (void)show {
    UIViewController *selfVC = [AppTool currentVC];
    [selfVC.view addSubview:self];
//    [UIView animateWithDuration:.3 animations:^{
//        self.bgView.height = 400;
//    }];
}

- (void)dismiss {
    [self removeFromSuperview];
//    [UIView animateWithDuration:.3 animations:^{
//        self.bgView.height = 0;
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
}

@end

@implementation shaixuanBtn

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.layer.cornerRadius = self.frame.size.height/2.0;
    self.clipsToBounds = YES;
    [self setTitleColor:KBlack333TextColor forState:UIControlStateNormal];
    [self setTitleColor:kRGB(255, 59, 48) forState:UIControlStateSelected];
    [self setBackgroundColor:kRGB(245, 245, 245)];
    self.titleLabel.font = DEFAULT_FONT_R(15);
}

@end

@implementation withdrawTimeShaixuanView


@end

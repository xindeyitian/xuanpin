//
//  CZHPickerView.m
//  DTU
//
//  Created by 李经纬 on 2018/7/27.
//  Copyright © 2018年 李经纬. All rights reserved.
//

#import "CZHPickerView.h"

#import "DatePickerHeader.h"
#import "UIButton+CZHExtension.h"

#define TOOLBAR_BUTTON_WIDTH CZH_ScaleWidth(65)

typedef NS_ENUM(NSInteger, CZHPickerViewButtonType) {
    CZHPickerViewButtonTypeCancle,
    CZHPickerViewButtonTypeSure
};
@interface CZHPickerView()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSInteger _selectItem;
}

///容器view
@property (nonatomic, weak) UIView *containView;
///pickerView
@property (nonatomic, weak) UIPickerView *pickerView;
///回调
@property (nonatomic, copy) void (^itemBlock)(NSInteger item);
///标题
@property (nonatomic, copy) NSString *titleText;
//选中的item
@property (nonatomic, assign) NSInteger currentItem;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UILabel *titleLabel;
@end

static CZHPickerView *_view = nil;

@implementation CZHPickerView

+ (instancetype)sharePickerViewWithCurrentItem:(NSInteger)currentItem titleText:(NSString *)titleText DataSource:(NSArray *)dataSource ItemBlock:(void (^)(NSInteger))itemBlock{
    
    _view = [[CZHPickerView alloc] init];
    _view.itemBlock = itemBlock;
    _view.currentItem = currentItem;
    _view.titleText = titleText;
    [_view.dataSource removeAllObjects];
    [_view.dataSource addObjectsFromArray:dataSource];
    [_view.pickerView reloadAllComponents];
    [_view.pickerView selectRow:currentItem inComponent:0 animated:NO];
    //设置时间
    
//    [_view czh_setDate];
    //显示view
    [_view czh_showView];
    return _view;
}


- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

- (instancetype)init {
    if (self = [super init]) {
        
        [self czh_setView];
        
    }
    return self;
}

- (void)setTitleText:(NSString *)titleText
{
    _titleText = titleText;
    self.titleLabel.text = titleText;
}


- (void)czh_setView {
    
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    UIView *containView = [[UIView alloc] init];
    containView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, CZH_ScaleHeight(270));
    [self addSubview:containView];
    self.containView = containView;
    
    
    UIView *toolBar = [[UIView alloc] init];
    toolBar.frame = CGRectMake(0, 0, ScreenWidth, CZH_ScaleHeight(44));
    toolBar.backgroundColor = CZHColor(0xf6f6f6);
    [containView addSubview:toolBar];
    
    UIButton *cancleButton = [UIButton czh_buttonWithTarget:self action:@selector(buttonClick:) frame:CGRectMake(0, 0, TOOLBAR_BUTTON_WIDTH, toolBar.czh_height) titleColor:CZHColor(0x666666) titleFont:CZHGlobelNormalFont(15) title:@"取消"];
    cancleButton.tag = CZHPickerViewButtonTypeCancle;
    [toolBar addSubview:cancleButton];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(0, 0, ScreenWidth, toolBar.height);
    self.titleLabel.textColor = [UIColor grayColor];
    self.titleLabel.text = self.titleText;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [toolBar addSubview:self.titleLabel];
    
    
    UIButton *sureButton = [UIButton czh_buttonWithTarget:self action:@selector(buttonClick:) frame:CGRectMake(toolBar.czh_width - TOOLBAR_BUTTON_WIDTH, 0, TOOLBAR_BUTTON_WIDTH, toolBar.czh_height) titleColor:CZHThemeColor titleFont:CZHGlobelNormalFont(15) title:@"确定"];
    sureButton.tag = CZHPickerViewButtonTypeSure;
    [toolBar addSubview:sureButton];
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.backgroundColor = CZHColor(0xffffff);
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.frame = CGRectMake(0, toolBar.czh_bottom, ScreenWidth, containView.czh_height - toolBar.czh_height);
    [containView addSubview:pickerView];
    
    self.pickerView = pickerView;
    
}


#pragma mark -- PickerDataSource
//返回的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;//返回几就有几列
}

//返回当前列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED {
    return 30;
}

//设置当前行显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    return self.dataSource[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    _selectItem = row;
}



- (void)buttonClick:(UIButton *)sender {
    
    [self czh_hideView];
    
    if (sender.tag == CZHPickerViewButtonTypeSure) {
        if (_itemBlock) {
            _itemBlock(_selectItem);
        }
    }
}


//显示
- (void)czh_showView {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = CZHRGBColor(0x000000, 0.3);
        self.containView.czh_bottom = ScreenHeight;
    }];
}

//隐藏
- (void)czh_hideView {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.containView.czh_y = ScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

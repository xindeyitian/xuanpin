//
//  CZHPickerView.m
//  DTU
//
//  Created by 李经纬 on 2018/7/27.
//  Copyright © 2018年 李经纬. All rights reserved.
//

#import "CZHAreaPickerView.h"
#import "CityModel.h"
#import "DatePickerHeader.h"
#import "UIButton+CZHExtension.h"

#define TOOLBAR_BUTTON_WIDTH CZH_ScaleWidth(65)

typedef NS_ENUM(NSInteger, CZHAreaPickerViewButtonType) {
    CZHAreaPickerViewButtonTypeCancle,
    CZHAreaPickerViewButtonTypeSure
};
@interface CZHAreaPickerView()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSString * _provinceName;
    NSString * _cityname;
    NSString * _reginname;
    NSInteger  _isEndForINCityAndProvinceArr;
}

///容器view
@property (nonatomic, weak) UIView *containView;
///pickerView
@property (nonatomic, weak) UIPickerView *pickerView;
///回调
@property (nonatomic, copy) void (^itemBlock)(NSString* provinceName, NSString* cityName, NSString* regionName);
///标题
@property (nonatomic, copy) NSString *titleText;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSMutableArray *provinceArr;//省
@property (nonatomic, strong) NSMutableArray *cityArr;//市
@property (nonatomic, strong) NSMutableArray *regionArr;//市

@property (nonatomic, strong) NSMutableArray *cityTitleArr;//选择了省就用这个数组展示市
@property (nonatomic, strong) NSMutableArray *regionTitleArr;//选择了市就用这个数组展示区

@end

static CZHAreaPickerView *_view = nil;

@implementation CZHAreaPickerView

+ (instancetype)sharePickerViewWithtitleText:(NSString *)titleText Province:(NSMutableArray *)province City:(NSMutableArray *)city Region:(NSMutableArray *)region ItemBlock:(void (^)(NSString* provinceName, NSString* cityName, NSString* regionName))itemBlock{
    
    _view = [[CZHAreaPickerView alloc] init];
    _view.itemBlock = itemBlock;
    _view.titleText = titleText;
    [_view.pickerView reloadAllComponents];
    
    [_view.cityArr removeAllObjects];
    [_view.provinceArr removeAllObjects];
    _view.provinceArr = province;
    _view.cityArr = city;
    _view.regionArr = region;
    
    [_view.pickerView selectRow:0 inComponent:1 animated:NO];
    [_view.pickerView selectRow:0 inComponent:0 animated:NO];
    
    //显示view
    [_view czh_showView];
    return _view;
}

-(NSMutableArray *)provinceArr{
    
    if (_provinceArr == nil) {
        
        _provinceArr = [[NSMutableArray alloc]init];
    }
    return _provinceArr;
}

-(NSMutableArray *)cityArr{
    
    if (_cityArr == nil) {
        
        _cityArr = [[NSMutableArray alloc]init];
    }
    return _cityArr;
}
- (NSMutableArray *)regionArr{
    
    if (_regionArr == nil) {
        
        _regionArr = [[NSMutableArray alloc]init];
    }
    return _regionArr;
}
-(NSMutableArray *)cityTitleArr{
    
    if (_cityTitleArr == nil) {
        
        _cityTitleArr = [[NSMutableArray alloc]init];
    }
    return _cityTitleArr;
}
- (NSMutableArray *)regionTitleArr{
    
    if (_regionTitleArr == nil) {
        
        _regionTitleArr = [[NSMutableArray alloc]init];
    }
    return _regionTitleArr;
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
    cancleButton.tag = CZHAreaPickerViewButtonTypeCancle;
    [toolBar addSubview:cancleButton];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(0, 0, ScreenWidth, toolBar.height);
    self.titleLabel.textColor = [UIColor grayColor];
    self.titleLabel.text = self.titleText;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [toolBar addSubview:self.titleLabel];
    
    
    UIButton *sureButton = [UIButton czh_buttonWithTarget:self action:@selector(buttonClick:) frame:CGRectMake(toolBar.czh_width - TOOLBAR_BUTTON_WIDTH, 0, TOOLBAR_BUTTON_WIDTH, toolBar.czh_height) titleColor:CZHThemeColor titleFont:CZHGlobelNormalFont(15) title:@"确定"];
    sureButton.tag = CZHAreaPickerViewButtonTypeSure;
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
    return 3;//返回几就有几列
}

//返回当前列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        
        return self.provinceArr.count;
    }else if(component == 1){
        if (self.cityTitleArr.count == 0) {
            
            return self.cityArr.count;
        }else{
            
            return  self.cityTitleArr.count;
        }
    }else{
        if (self.regionTitleArr.count == 0) {
            
            return self.regionArr.count;
        }else{
            
            return self.regionTitleArr.count;
        }
    }
    return 0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED {
    return 30;
}

//设置当前行显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        
        CityModel *provinceModel = self.provinceArr[row];
        return provinceModel.region_name;
    }else if(component == 1){
        
        if (self.cityTitleArr.count == 0) {
            
            CityModel *model = self.cityArr[row];
            return model.region_name;
        }else{
            CityModel *model = self.cityTitleArr[row];
            return model.region_name;
        }
    }else{
        if (self.regionTitleArr.count == 0) {
            
            CityModel *model = self.regionArr[row];
            return model.region_name;
        }else{
            
            CityModel *model = self.regionTitleArr[row];
            return model.region_name;
        }
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        
        CityModel *provinceModel = self.provinceArr[row];
        [self.cityTitleArr removeAllObjects];
        for (CityModel *cityModel in self.cityArr) {
            
            if (provinceModel.region_id == cityModel.parent_id) {
                
                [self.cityTitleArr addObject:cityModel];
                [self.pickerView reloadComponent:1];
            }
        }
        _provinceName = provinceModel.region_name;
    }else if(component == 1){
        if (self.cityTitleArr.count == 0) {
            
            CityModel *cityModel = self.cityArr[row];
            [self.regionTitleArr removeAllObjects];
            for (CityModel *reginModel in self.regionArr) {
                
                if (cityModel.region_id == reginModel.parent_id) {
                    
                    [self.regionTitleArr addObject:reginModel];
                    [self.pickerView reloadComponent:2];
                }
            }
            _cityname = cityModel.region_name;
        }else{
            
            CityModel *cityModel = self.cityTitleArr[row];
            [self.regionTitleArr removeAllObjects];
            for (CityModel *reginModel in self.regionArr) {
                
                if (cityModel.region_id == reginModel.parent_id) {
                    
                    [self.regionTitleArr addObject:reginModel];
                    [self.pickerView reloadComponent:2];
                }
            }
            _cityname = cityModel.region_name;
        }
    }else{
        if (self.regionTitleArr.count == 0) {
            
            CityModel *regionModel = self.regionArr[row];
            _reginname = regionModel.region_name;
        }else{
            
            CityModel *regionModel = self.regionTitleArr[row];
            _reginname = regionModel.region_name;
        }
    }
}

- (void)buttonClick:(UIButton *)sender {
    
    [self czh_hideView];
    
    if (sender.tag == CZHAreaPickerViewButtonTypeSure) {
        if (_itemBlock) {

            _itemBlock(_provinceName,_cityname,_reginname);
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

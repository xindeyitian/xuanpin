//
//  changeGenderViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import "changeGenderViewController.h"

@interface changeGenderViewController ()

@end

@implementation changeGenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *title = [UILabel creatLabelWithTitle:@"性别选择" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(18)];
    [self.bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).offset(22);
        make.height.mas_equalTo(30);
        make.left.right.mas_equalTo(self.bgView);
    }];
    
    BOOL isMan = [self.sex isEqualToString:@"1"];
    
    NSArray *titleAry = @[@"男",@"女"];
    NSArray *icon = @[isMan ? @"man_selected" : @"man_unselected", isMan ? @"woman_unselected" : @"woman_selected"];
    if ([self.sex isEqualToString:@"0"]) {
        icon = @[@"man_unselected", @"woman_unselected"];
    }
    NSArray *colorAry = @[isMan ? kRGB(74, 154, 255) : KBlack666TextColor,isMan ? KBlack666TextColor : kRGB(242, 52, 87)];
    if ([self.sex isEqualToString:@"0"]) {
        colorAry = @[KBlack666TextColor, KBlack666TextColor];
    }
    for (int i = 0; i < 2; i ++) {
        genderView *view = [[genderView alloc]initWithFrame:CGRectMake(i == 0 ? 73 : ScreenWidth - 48 - 121, 70, 50, 80)];
        view.icon.image = IMAGE_NAMED(icon[i]);
        view.titleL.text = titleAry[i];
        view.titleL.textColor = colorAry[i];
        [self.bgView addSubview:view];
        CJWeakSelf()
        view.viewClickBlock = ^{
            CJStrongSelf()
            [self dismissViewControllerAnimated:NO completion:nil];
            if (self->_selectOperationBlock) {
                self->_selectOperationBlock(i);
            }
        };
    }
    
    BaseButton *cancelBtn = [BaseButton CreateBaseButtonTitle:@"取消" Target:self Action:@selector(cancelClick) Font:DEFAULT_FONT_M(15) BackgroundColor:KBGColor Color:KBlack333TextColor Frame:CGRectMake(0, 0, 0, 0) Alignment:NSTextAlignmentCenter Tag:23];
    [self.bgView addSubview:cancelBtn];
    cancelBtn.clipsToBounds = YES;
    cancelBtn.layer.cornerRadius = 22;
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-26);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(174);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
    }];
}

- (void)cancelClick{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end


@interface genderView ()

@end

@implementation genderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    
//    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//    bgView.backgroundColor = KBGLightColor;
//    bgView.layer.cornerRadius = 25;
//    bgView.clipsToBounds = YES;
//    [self addSubview:bgView];
//    self.BGView = bgView;
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    imgV.layer.cornerRadius = 25;
    imgV.clipsToBounds = YES;
    [self addSubview:imgV];
    self.icon = imgV;
    
    UILabel *title = [UILabel creatLabelWithTitle:@"nan" textColor:KBlack333TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(17)];
    title.frame = CGRectMake(0, 55, 50, 25);
    [self addSubview:title];
    self.titleL = title;
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)]];
}

- (void)tapClick{
    if (_viewClickBlock) {
        _viewClickBlock();
    }
}

@end

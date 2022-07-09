//
//  BaseAlertViewController.m
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import "BaseAlertViewController.h"

@interface BaseAlertViewController ()

@end

@implementation BaseAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGBA(0,0,0,0.55);
    
    self.view.userInteractionEnabled = YES;
    UIView *tapView = [[UIView alloc]initWithFrame:self.view.frame];
    tapView.userInteractionEnabled = YES;
    tapView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:tapView];
    [tapView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)]];
    
    UIView *tmpBGView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tmpBGView];
    _bgView = tmpBGView;
    _bgView.backgroundColor = KWhiteBGColor;
    _bgView.layer.cornerRadius = 8;
    _bgView.clipsToBounds = YES;
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.height.equalTo(@(234));
        make.left.mas_equalTo(self.view).offset(24);
        make.right.mas_equalTo(self.view).offset(-24);
    }];
}

- (void)tapClick{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.2, @1.1, @1.0];
    animation.duration = 0.01;
    animation.calculationMode = kCAAnimationCubic;
    //把动画添加上去就OK了
    //[_bgView.layer addAnimation:animation forKey:nil];
}

@end


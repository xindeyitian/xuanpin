//
//  VideoViewController.m
//  SmallB
//
//  Created by zhang on 2022/7/16.
//

#import "VideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MainTabarViewController.h"
#import <AVKit/AVKit.h>

@interface VideoViewController ()
{
    NSInteger secondsCountDown;
    NSTimer *countDownTimer;
}
@property (nonatomic , strong)AVPlayer *player;
@property (nonatomic , strong)MPMoviePlayerController *moviePlayer;
@property (nonatomic , strong)MPMoviePlayerViewController *mpmoviePlayer;
@property (nonatomic , strong)AVPlayerViewController *playerVc;
@property (nonatomic , strong)UILabel *timeL;

@end

@implementation VideoViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *image = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"launch_image")];
    [self.view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.height.mas_equalTo(414);
        make.width.mas_equalTo(375);
    }];
    
    UIImageView *bottom = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"launch_bottom")];
    [self.view addSubview:bottom];
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(- TabbarSafeBottomMargin - 20);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(124);
    }];

    [self.player play];

    //[self.moviePlayer play];
    //[self mpmoviePlayer];
    //[self.playerVc.player play];
    [self start];
    
    UILabel *title = [UILabel creatLabelWithTitle:@"跳过 7s" textColor:KWhiteTextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(15)];
    title.backgroundColor = kRGBA(0, 0, 0, 0.4);
    title.clipsToBounds = YES;
    title.layer.cornerRadius = 15;
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(KNavBarHeight - 37);
        make.right.mas_equalTo(self.view).offset(-12);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(30);
    }];
    self.timeL = title;
    [self.view bringSubviewToFront:self.timeL];
    
    image.userInteractionEnabled = YES;
    title.userInteractionEnabled = YES;
    [title addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endOperation)]];
}

-(void)timeFireMethod{
    secondsCountDown--;
    self.timeL.text = [NSString stringWithFormat:@"跳过 %ds",secondsCountDown];
    if(secondsCountDown==0){
      [countDownTimer invalidate];
        [self endOperation];
    }
}
- (void)start{
    secondsCountDown = 7;//60秒倒计时
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];

    //    __block int timeout = 7;
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
//    dispatch_source_set_event_handler(_timer, ^{
//        if(timeout<=0){
//            dispatch_source_cancel(_timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//               [self endOperation];
//            });
//        }else{
//            int seconds = timeout;
//            NSString *starTime = [NSString stringWithFormat:@"%.1d", seconds];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.timeL.text = [NSString stringWithFormat:@"跳过%@s",starTime];
//            });
//            timeout--;
//        }
//    });
//    dispatch_resume(_timer);
}

- (AVPlayer *)player{
    if (!_player) {
        _player = [AVPlayer playerWithURL:self.theurl];
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        layer.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.view.layer addSublayer:layer];
    }
    return _player;
}

- (MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:self.theurl];
        _moviePlayer.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}

- (MPMoviePlayerViewController *)mpmoviePlayer{
    if (!_mpmoviePlayer) {
        _mpmoviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:self.theurl];
        _mpmoviePlayer.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [self.view addSubview:_mpmoviePlayer.view];
    }
    return _mpmoviePlayer;
}

- (AVPlayerViewController *)playerVc{
    if (!_playerVc) {
        AVPlayer *player = [AVPlayer playerWithURL:self.theurl];
        _playerVc = [[AVPlayerViewController alloc] init];
        _playerVc.player = player;
        _playerVc.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [self.view addSubview:_playerVc.view];
    }
    return _playerVc;
}

- (void)endOperation{
    
    [countDownTimer invalidate];
    NSString *token = [AppTool getLocalToken];
    NSString *login = [[NSUserDefaults standardUserDefaults] objectForKey:@"login"];
    if(token.length && ![login isEqualToString:@"1"]){
        MainTabarViewController * tab = [[MainTabarViewController alloc]init];
        [UIApplication sharedApplication].delegate.window.rootViewController = tab;
    }else{
        //跳转到登录界面
        [UIApplication sharedApplication].delegate.window.rootViewController  = [[LoginViewController alloc]init];
    }
}

@end

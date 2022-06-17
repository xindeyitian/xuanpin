//
//  ScanViewController.m
//  SmallB
//
//  Created by zhang on 2022/6/16.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic , strong)AVCaptureSession *session;
@property (nonatomic , strong)AVCaptureVideoPreviewLayer *layer;
@property (nonatomic , strong)UILabel *titleL;

@end

@implementation ScanViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self start];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"扫描二维码";
    
    UILabel *title = [UILabel creatLabelWithTitle:@"" textColor:KBlack666TextColor textAlignment:NSTextAlignmentCenter font:DEFAULT_FONT_M(17)];
    [self.view addSubview:title];
    title.numberOfLines = 0;
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(100);
        make.right.mas_equalTo(self.view).offset(-12);
        make.left.mas_equalTo(self.view).offset(12);
        make.height.mas_equalTo(100);
    }];
    self.titleL = title;
}

- (void)start{
    AVCaptureSession *session = [[AVCaptureSession alloc]init];
    self.session = session;
    //AVMediaTypeVideo:摄像头, AVMediaTypeAudio:话筒, AVMediaTypeMuxed:弹幕
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//        if (error) {
//          //防止模拟器崩溃
//          NSLog(@"没有摄像头设备");
//          return;
//        }
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    [session addInput:input];
    
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [session addOutput:output];
    //设置输出类型,必须在output 加入到会话之后来设置
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    AVCaptureVideoPreviewLayer *layer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:session];
    layer.frame = self.view.bounds;
    [self.view.layer addSublayer:layer];
    self.layer = layer;
    
    [session startRunning];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
  if (metadataObjects.count>0)
   {
      //1.获取到扫描的内容
      AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
      NSLog(@"扫描的内容==%@",object.stringValue);
      //2.停止会话
      [self.session stopRunning];
      //3.移除预览图层
      [self.layer removeFromSuperlayer];
       
       //self.titleL.text = object.stringValue;
       
       /**
        分享商品
        https://h5.tuanhuoit.com/goodsShow.html?id=商品&uid=用户ID
        分享个人名片，邀请注册
        https://h5.tuanhuoit.com/invite.html?uid=用户ID
        */
       if ([object.stringValue containsString:@"https://h5.tuanhuoit.com/goodsShow.html"]) {
           NSArray *array = [object.stringValue componentsSeparatedByString:@"?id="];
           if (array.count) {
               NSString *last = [array lastObject];
               if ([last containsString:@"&uid="]) {
                   NSArray *resultAry = [last componentsSeparatedByString:@"&uid="];
                   if (resultAry.count) {
                       [AppTool GoToProductDetailWithID:resultAry.firstObject];
                   }
               }
           }
       }
       if ([object.stringValue containsString:@"https://h5.tuanhuoit.com/invite.html"]) {
           
       }
    }
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    SetIOS13;
    [navigationController setNavigationBarHidden:NO animated:YES];
}

@end

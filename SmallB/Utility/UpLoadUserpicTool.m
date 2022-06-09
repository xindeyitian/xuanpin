//
//  UpLoadUserpicTool.m
//  JiaXiHeZi
//
//  Created by 郑信鸿 on 16/6/17.
//  Copyright © 2016年 郑信鸿. All rights reserved.
//

#import "UpLoadUserpicTool.h"
#import "AlertMananger.h"


@interface UpLoadUserpicTool ()<UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (nonatomic, strong)UIViewController *viewController;

@property (nonatomic, copy)FinishSelectImageBlcok imageBlock;
@property (nonatomic,copy)UIImage *image;
@end


@implementation UpLoadUserpicTool

+ (UpLoadUserpicTool *)shareManager
{
    static UpLoadUserpicTool *managerInstance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        managerInstance = [[self alloc] init];
    });
    return managerInstance;
}


- (void)selectUserpicSourceWithViewController:(UIViewController *)viewController SourceType:(OpenSourceType)sourceType FinishSelectImageBlcok:(FinishSelectImageBlcok)finishSelectImageBlock{
    
    if (viewController) {
        self.viewController = viewController;
    }
    if (finishSelectImageBlock) {
        self.imageBlock = finishSelectImageBlock;
    }
    AlertMananger *alert;
    switch (sourceType) {
        case SourceTypeAll:{
            alert = [[AlertMananger shareManager] creatAlertWithTitle:@"选择图片来源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet cancelTitle:@"取消" otherTitle:@"拍照", @"相册", nil];
            break;
        }
        case SourceTypeCamera:{
            alert = [[AlertMananger shareManager] creatAlertWithTitle:@"选择图片来源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet cancelTitle:@"取消" otherTitle:@"拍照", nil];
            break;
        }
        case SourceTypePhotoLibrary:{
            alert = [[AlertMananger shareManager] creatAlertWithTitle:@"选择图片来源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet cancelTitle:@"取消" otherTitle:@"相册", nil];
            break;
        }
        default:
            break;
    }
    [alert showWithViewController:viewController IndexBlock:^(NSInteger index) {
        
        if (sourceType == SourceTypeAll || sourceType == SourceTypeCamera) {
            if (index == 1) {
                
                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])return;///<检测该设备是否支持拍摄
                
                UIImagePickerController* picker = [[UIImagePickerController alloc]init];///<图片选择控制器创建
                
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;///<设置数据来源为拍照
                picker.allowsEditing = NO;
                picker.delegate = self;///<代理设置
                
                [self.viewController presentViewController:picker animated:YES completion:nil];///<推出视图控制器
                
            }else if (index == 2){
                
                UIImagePickerController* picker = [[UIImagePickerController alloc]init];///<图片选择控制器创建
                
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;///<设置数据来源为相册
                //允许选择照片之后可编辑
                picker.allowsEditing = NO;
                picker.delegate = self;///<代理设置
                
                [viewController presentViewController:picker animated:YES completion:nil];///<推出视图控制器
                
            }
        } else {
            if (index == 1){
                
                UIImagePickerController* picker = [[UIImagePickerController alloc]init];///<图片选择控制器创建
                
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;///<设置数据来源为相册
                //允许选择照片之后可编辑
                picker.allowsEditing = NO;
                picker.delegate = self;///<代理设置
                
                [viewController presentViewController:picker animated:YES completion:nil];///<推出视图控制器
                
            }
        }
        
        
    }];
  
  
}



#pragma mark - 相册/相机回调  显示所有的照片，或者拍照选取的照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = nil;
    //获取编辑之后的图片
    
//    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    image = info[UIImagePickerControllerOriginalImage];
    
    if (self.imageBlock != nil) {
        
        self.imageBlock(image);
        
    }
    
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    
}


//  取消选择 返回当前试图
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

//将图片上传到服务器
//- (void)upService
//{
//    UIImage* chosenImage = [self imageWithImageSimple:self.image scaledToSize:CGSizeMake(60, 60)];
//    NSData * originData = UIImageJPEGRepresentation(chosenImage, 0.5);
//    NSString *base64Icon = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

//    [MBProgressHUD showActivityMessageInWindow:@"上传中..."];
//
//    [dataCenter upHeaderWithHeadImage:base64Icon Completion:^{
//        if (self.imageBlock) {
//
//            self.imageBlock(chosenImage);
//
//        }
//         [MBProgressHUD showSuccessMessage:@"上传成功"];
//
//    } Error:^(NSError *error) {
//
//        [MBProgressHUD showErrorMessage:error.localizedDescription];
//    }];

//}
//压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}
@end

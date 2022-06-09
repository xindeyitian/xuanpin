//
//  THUserManager.m
//  LLWFan
//
//  Created by MAC on 2022/3/21.
//

#import "THUserManager.h"

@interface THUserManager()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic)  UIImage  * inserImage;                   ///插入的image
@property (strong, nonatomic)  UIImagePickerController *insertPicker; ///插入的vc

@end

@implementation THUserManager

static THUserManager *userManger;
+ (instancetype)shareTHUserManager
{

   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       
       userManger = [[THUserManager alloc]init];
       
       //当前版本号  版本检测 版本更新之后 清除领域 和 地址的 数据
       NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
       float appVersion = [[infoDictionary objectForKey:@"CFBundleShortVersionString"] floatValue];
       float appVersionLocation =    [UserDefaults floatForKey:@"CFBundleShortVersionString"];
       if (appVersion !=  appVersionLocation) {
           //从新设置版本
           [UserDefaults setFloat:appVersion forKey:@"CFBundleShortVersionString"];
           //清除领域的模型
           [UserDefaults setObject:nil forKey:@"CreateFieldModelArray"];
       }
   });
   
   return userManger;
}
-(void)archiverUserModel:(THUserModel *)userModel{
   
   NSError *error = nil;
   if (@available(iOS 11.0, *)) {
       NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userModel requiringSecureCoding:NO error:&error];
       if (data == nil || error) {
           NSLog(@"归档失败:%@", error);
           return;
       }
       //更新一下 用户模型
       [UserDefaults setObject:data forKey:@"THUserModel"];
       if (data == nil || error) {
           NSLog(@"归档失败:%@", error);
           return;
       }
   } else {
       NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userModel];
       if (data == nil || error) {
           NSLog(@"归档失败:%@", error);
           return;
       }
       //更新一下 用户模型
       [UserDefaults setObject:data forKey:@"THUserModel"];
       if (data == nil || error) {
           NSLog(@"归档失败:%@", error);
           return;
       }
   }
   //保存一下 前一个用户登录的手机号
   [UserDefaults setObject:userModel.userDetailsKey forKey:@"THUserModelPreviousPhoneNumber"];
   [UserDefaults synchronize];
   
   THUserModel *model = [self unarchiverUserModel:[UserDefaults objectForKey:@"THUserModel"]];
   NSLog(@"_+_+_+_+_%@%@",model.userAccount,model.userDetailsKey);
   
}
-(THUserModel *)unarchiverUserModel:(NSData *)userModelData{
   
   NSError *error = nil;
   if (userModelData) {
       
       if (@available(iOS 11.0, *)) {
           THUserModel *model = [NSKeyedUnarchiver unarchivedObjectOfClass:[THUserModel class] fromData:userModelData error:&error];
           if (model == nil || error) {
               NSLog(@"解归档失败:%@", error);
               return nil;
           }
           return model;
       } else {
           THUserModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:userModelData];
           if (model == nil || error) {
               NSLog(@"解归档失败:%@", error);
               return nil;
           }
           return model;
       }
   }
   return nil;
}
-(void)setUserModel:(THUserModel *)userModel{

   _userModel = userModel;

   //更新一下 用户模型
   [THUserManagerShareTHUserManager archiverUserModel:userModel];
   //保存一下 前一个用户登录的手机号
   [UserDefaults setObject:userModel.userAccount forKey:@"THUserModelPreviousPhoneNumber"];
   [UserDefaults synchronize];
}

/**
清除用户模型的数据 但是保留用户模型的手机号码
*/
+ (void)clearUserModel{

   //清除一下用户模型
   [UserDefaults setObject:nil forKey:@"THUserModel"];
   [UserDefaults synchronize];
   THUserManagerShareTHUserManager.userModel = nil;
}


@end

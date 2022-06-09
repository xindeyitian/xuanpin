//
//  NSNumber+SCCommon.m
//  LDSpecialCarService
//
//  Created by Mac on 2017/2/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "NSNumber+SCCommon.h"

@implementation NSNumber (SCCommon)

- (NSString *)timeString
{
    NSInteger time = self.integerValue;
    
    NSInteger hour = time/3600;
    
    NSInteger hleft = time%3600;
    
    NSInteger minute = hleft/60;
    
    NSInteger second = hleft%60;
    
    NSString *timeSring = nil;
    
    if (hour) {
       
        timeSring = [NSString stringWithFormat:@"%ld时%ld分%ld秒",(long)hour,(long)minute,(long)second];
        
    }else if (minute){
        
        if (second) {
          
            timeSring = [NSString stringWithFormat:@"%ld分%ld秒",(long)minute,(long)second];
            
        }else{
        
            timeSring = [NSString stringWithFormat:@"%ld分",(long)minute];
        }
    
    }else{
    
        timeSring = [NSString stringWithFormat:@"%ld秒",(long)second];
    
    }

    return timeSring;
}

- (NSString *)durationString
{
    NSInteger time = self.integerValue;
    
    NSInteger hour = time/3600;
    
    NSInteger hleft = time%3600;
    
    NSInteger minute = hleft/60;
    
    NSInteger second = hleft%60;
    
    NSString *timeSring = nil;
    
    if (hour) {
        
        timeSring = [NSString stringWithFormat:@"%ld小时%ld分钟",(long)hour,(long)minute];
        
    }else if (minute){

            timeSring = [NSString stringWithFormat:@"%ld分钟",(long)minute];
        
    }else{
    
            timeSring = [NSString stringWithFormat:@"%ld秒",(long)second];
        
    }
    
    return timeSring;
    
}

- (NSString *)distanceKilometreString
{
    float distance = self.floatValue;
    
    NSString *string = [NSString stringWithFormat:@"%0.1f公里",distance/1000.0];
    
    return string;
}
- (NSString *)distanceString
{
    NSInteger distance = self.integerValue;
    
    NSInteger kilometre = distance/1000;
    
    NSInteger meter = distance%1000;
    
    NSString *string = nil;
    
    if (kilometre) {
        
        string = [NSString stringWithFormat:@"%0.2f公里",distance/1000.0];
        
    }else{
        
        string = [NSString stringWithFormat:@"%ld米",(long)meter];
        
    }

    return string;
}
@end

//
//  LSTPopViewqqView.m
//  LSTPopView_Example
//
//  Created by LoSenTrad on 2020/4/24.
//  Copyright © 2020 490790096@qq.com. All rights reserved.
//

#import "LSTPopViewqqtopView.h"

@interface LSTPopViewqqtopView()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end

@implementation LSTPopViewqqtopView

- (void)setNoticeTitle:(NSString *)noticeTitle{
    
    _noticeTitle = noticeTitle;
    self.title.text = noticeTitle;
}
- (void)setType:(noticeType)type{
    
    _type = type;
    if (type == warning) {
        
        [self.img setImage:IMAGE_NAMED(@"worning")];
    }else if (type == success){
        [self.img setImage:IMAGE_NAMED(@"success")];
    }else{
        [self.img setImage:IMAGE_NAMED(@"notice")];
    }
}
@end

//
//  ProductDetailCommentModel.m
//  SmallB
//
//  Created by zhang on 2022/4/24.
//

#import "ProductDetailCommentModel.h"

@implementation ProductDetailCommentModel

- (float)biaoQianBGHeight{
    if (self.biaoQianAry.count == 0) {
        return .0f;
    }
    return 30;
}

- (float)contentBGHeight{
    float contentHeight = [self.contentStr sizeWithLabelWidth:ScreenWidth - 24 -24 font:DEFAULT_FONT_R(13)].height+1;
    return contentHeight;
}

- (float)imageBGHeight{
    float imageHeight = .0f;
    if (self.imageAry.count == 1) {
        imageHeight = 200;
        self.oneImageHeight = imageHeight;
        self.num = 1;
    }
    if (self.imageAry.count == 2) {
        imageHeight = (ScreenWidth - 24 - 12 * 2 - 8)/2.0;
        self.oneImageHeight = imageHeight;
        self.num = 2;
    }
    if (self.imageAry.count > 2) {
        float oneHeight = (ScreenWidth - 24 - 12 * 2 - 8 * 2)/3.0;
        imageHeight = (oneHeight + 12)*(self.imageAry.count%3 == 0?self.imageAry.count/3 : self.imageAry.count/3+1);
        self.oneImageHeight = oneHeight;
        self.num = 3;
    }
    return imageHeight;
}

- (float)rowHeight{

    float height = 47;
    if (self.biaoQianAry.count) {
        height += (8+self.biaoQianBGHeight);
    }
    if (self.imageAry.count) {
        height += (8 + self.imageBGHeight);
    }
    height += (8 + self.contentBGHeight);
    height += (28+12);
    return height;
    return 47 + (8+self.biaoQianBGHeight) + (8 + self.contentBGHeight) +(8 + self.imageBGHeight) + 28+12;
}

@end

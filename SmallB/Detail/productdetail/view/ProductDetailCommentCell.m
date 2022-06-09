//
//  ProductDetailCommentCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/8.
//

#import "ProductDetailCommentCell.h"
#import "ProductDetailCommentViewController.h"

@interface ProductDetailCommentCell()

@property (strong, nonatomic) MyLinearLayout *rootLy, *commentBaseLy;
@property (strong, nonatomic) UILabel        *pingjiaNum;

@end

@implementation ProductDetailCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)moreCommentClicked:(UIButton *)sender{
   
    
}
- (void)initCustomView{
    
    //root 布局
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.rootLy.padding = UIEdgeInsetsMake(0, 0, 12, 0);
    [self.contentView addSubview:self.rootLy];
    //内容布局
    MyLinearLayout *contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    contentLy.myHorzMargin = 12;
    contentLy.myHeight = MyLayoutSize.wrap;
    contentLy.layer.cornerRadius = 8;
    contentLy.layer.masksToBounds = YES;
    contentLy.backgroundColor = UIColor.whiteColor;
    contentLy.padding = UIEdgeInsetsMake(12, 12, 16, 12);
    contentLy.gravity = MyGravity_Horz_Center;
    [self.rootLy addSubview:contentLy];
    
    MyLinearLayout *titleLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    titleLy.myHorzMargin = 0;
    titleLy.myHeight = 25;
    titleLy.gravity = MyGravity_Vert_Center;
    [contentLy addSubview:titleLy];
    
    UILabel *pingjia = [[UILabel alloc] initWithFrame:CGRectZero];
    pingjia.text = @"评价";
    pingjia.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    pingjia.textColor = [UIColor colorWithHexString:@"333333"];
    pingjia.myWidth = 35;
    pingjia.myHeight = 25;
    [titleLy addSubview:pingjia];
    
    self.pingjiaNum = [[UILabel alloc] initWithFrame:CGRectZero];
    self.pingjiaNum.text = @"(36万+)";
    self.pingjiaNum.font = [UIFont systemFontOfSize:12];
    self.pingjiaNum.textColor = [UIColor colorWithHexString:@"#666666"];
    self.pingjiaNum.myWidth = MyLayoutSize.wrap;
    self.pingjiaNum.myHeight = 20;
    [titleLy addSubview:self.pingjiaNum];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 25;
    [titleLy addSubview:nilView];
    
    UILabel *degreeOfPraise = [[UILabel alloc] initWithFrame:CGRectZero];
    degreeOfPraise.font = [UIFont systemFontOfSize:12];
    degreeOfPraise.textColor = [UIColor colorWithHexString:@"333333"];
    degreeOfPraise.text = @"好评度99%";
    degreeOfPraise.myWidth = MyLayoutSize.wrap;
    degreeOfPraise.myHeight = 25;
    [titleLy addSubview:degreeOfPraise];
    
    UIImageView *rightGray = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-gray")];
    rightGray.myWidth = rightGray.myHeight = MyLayoutSize.wrap;
    [titleLy addSubview:rightGray];
    
    self.commentBaseLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.commentBaseLy.myHorzMargin = 0;
    self.commentBaseLy.myHeight = MyLayoutSize.wrap;
    self.commentBaseLy.subviewVSpace = 12;
    [contentLy addSubview:self.commentBaseLy];
    
    [self initCommentItem];
    
    UIButton *moreComment = [BaseButton CreateBaseButtonTitle:@"查看更多评价" Target:self Action:@selector(moreCommentClicked:) Font:[UIFont systemFontOfSize:12] BackgroundColor:UIColor.whiteColor Color:UIColor.blackColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    moreComment.myWidth = 125;
    moreComment.myHeight = 40;
    moreComment.myTop = 12;
    moreComment.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
    moreComment.layer.borderWidth = 1;
    moreComment.layer.cornerRadius = 20;
    moreComment.layer.masksToBounds = YES;
    [contentLy addSubview:moreComment];
}
- (void)initCommentItem{
    
    MyLinearLayout *commentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    commentLy.myHorzMargin = 0;
    commentLy.myHeight = MyLayoutSize.wrap;
    commentLy.padding = UIEdgeInsetsMake(8, 0, 8, 0);
    commentLy.subviewVSpace = 8;
    [self.commentBaseLy addSubview:commentLy];
    
    MyLinearLayout *userInfoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    userInfoLy.myHorzMargin = 0;
    userInfoLy.myHeight = 35;
    userInfoLy.gravity = MyGravity_Vert_Center;
    [commentLy addSubview:userInfoLy];
    
    UIImageView *userImg = [[UIImageView alloc] init];
    userImg.myWidth = userImg.myHeight = 35;
    userImg.layer.cornerRadius = 17.5;
    userImg.layer.masksToBounds = YES;
    [userInfoLy addSubview:userImg];
    
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectZero];
    userName.myWidth = MyLayoutSize.wrap;
    userName.myHeight = 25;
    userName.font = [UIFont systemFontOfSize:13];
    userName.textColor = [UIColor colorWithHexString:@"333333"];
    userName.myLeft = 10;
    userName.text = @"一个苹果";
    [userInfoLy addSubview:userName];
    
    MyFlowLayout *targetLy = [MyFlowLayout flowLayoutWithOrientation:MyOrientation_Vert arrangedCount:0];
    targetLy.myHorzMargin = 0;
    targetLy.myHeight = MyLayoutSize.wrap;
    targetLy.subviewHSpace = 12;
    targetLy.subviewVSpace = 12;
    targetLy.myTop = 8;
    [commentLy addSubview:targetLy];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *target = [[UILabel alloc] initWithFrame:CGRectZero];
        target.myWidth = 90;
        target.myHeight = 25;
        target.layer.cornerRadius = 12.5;
        target.layer.masksToBounds = YES;
        target.text = @"商品很好用";
        target.font = [UIFont systemFontOfSize:13];
        target.backgroundColor = [UIColor colorWithHexString:@"#FF7332" alpha:0.75];
        target.textColor = UIColor.whiteColor;
        target.textAlignment = NSTextAlignmentCenter;
        [targetLy addSubview:target];
    }
    
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectZero];
    content.myHorzMargin = 0;
    content.myHeight = MyLayoutSize.wrap;
    content.font = [UIFont systemFontOfSize:13];
    content.textColor = [UIColor colorWithHexString:@"333333"];
    content.numberOfLines = 0;
    content.text = @"这款笔记本很好用，重量稍微比我想象的重一点点，不过还是很满意的，非常满意。";
//    [content changeLineSpace:8];
    [commentLy addSubview:content];
    
    MyFlowLayout *imgLy = [MyFlowLayout flowLayoutWithOrientation:MyOrientation_Vert arrangedCount:3];
    imgLy.myHorzMargin = 0;
    imgLy.myHeight = MyLayoutSize.wrap;
    imgLy.subviewHSpace = imgLy.subviewVSpace = 8;
    [commentLy addSubview:imgLy];
    
    for (int i = 0; i < 9; i++) {
        
        UIImageView *img = [[UIImageView alloc] init];
        img.myWidth = img.myHeight = (ScreenWidth - 48 - 16) / 3;
        img.layer.cornerRadius = 8;
        img.layer.masksToBounds = YES;
        [imgLy addSubview:img];
    }
    
    UILabel *skuLable = [[UILabel alloc] initWithFrame:CGRectZero];
    skuLable.textColor = [UIColor colorWithHexString:@"#999999"];
    skuLable.font = [UIFont systemFontOfSize:12];
    skuLable.text = @"19款13.3英寸 i5 8+128G灰，普通款，1件";
    skuLable.myHorzMargin = 0;
    skuLable.myHeight = MyLayoutSize.wrap;
    skuLable.numberOfLines = 0;
    [commentLy addSubview:skuLable];
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end

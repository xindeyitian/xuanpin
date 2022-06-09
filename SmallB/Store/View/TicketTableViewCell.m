//
//  TicketTableViewCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/12.
//

#import "TicketTableViewCell.h"

@interface TicketTableViewCell()

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) UILabel        *ticketType, *ticketNum, *ticketRange, *ticketTitle, *ticketTime;
@property (strong, nonatomic) UIButton       *rightBtn;

@end

@implementation TicketTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
        self.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth - 24;
    self.rootLy.myHeight = 113;
    self.rootLy.gravity = MyGravity_Horz_Center;
    self.rootLy.padding = UIEdgeInsetsMake(13, 0, 0, 0);
    [self.contentView addSubview:self.rootLy];
    
    MyLinearLayout *ticketLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    ticketLy.myHorzMargin = 0;
    ticketLy.myHeight = 100;
    ticketLy.backgroundImage = IMAGE_NAMED(@"ticket");
    [self.rootLy addSubview:ticketLy];
    
    MyLinearLayout *ticketInfoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    ticketInfoLy.myWidth = ticketInfoLy.myHeight = 90;
    ticketInfoLy.layer.cornerRadius = 8;
    ticketInfoLy.backgroundColor = [UIColor colorWithHexString:@"#FA172D" alpha:0.1];
    ticketInfoLy.gravity = MyGravity_Horz_Center;
    ticketInfoLy.myLeft = ticketInfoLy.myTop = 5;
    [ticketLy addSubview:ticketInfoLy];
    
    self.ticketNum = [[UILabel alloc] initWithFrame:CGRectZero];
    self.ticketNum.font = DIN_Medium_FONT_R(25);
    self.ticketNum.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.ticketNum.text = @"¥3.887";
    self.ticketNum.myWidth = self.ticketNum.myHeight = MyLayoutSize.wrap;
    self.ticketNum.myTop = 16;
    [ticketInfoLy addSubview:self.ticketNum];
    
    self.ticketRange = [[UILabel alloc] initWithFrame:CGRectZero];
    self.ticketRange.font = [UIFont systemFontOfSize:12];
    self.ticketRange.textColor = UIColor.blackColor;
    self.ticketRange.text = @"满10元可用";
    self.ticketRange.myWidth = self.ticketRange.myHeight = MyLayoutSize.wrap;
    self.ticketRange.myTop = 15;
    [ticketInfoLy addSubview:self.ticketRange];
    
    self.ticketType = [[UILabel alloc] initWithFrame:CGRectZero];
    self.ticketType.myWidth = 42;
    self.ticketType.myHeight = 18;
    self.ticketType.backgroundColor = UIColor.redColor;
    self.ticketType.font = [UIFont systemFontOfSize:12];
    self.ticketType.textColor = UIColor.whiteColor;
    self.ticketType.textAlignment = NSTextAlignmentCenter;
    self.ticketType.text = @"店铺券";
    self.ticketType.myLeft = -96;
    [ticketLy addSubview:self.ticketType];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.ticketType.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:self.ticketType.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(2, 2)];
    [path appendPath:path1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CAShapeLayer *layer = [[CAShapeLayer alloc]init];
        layer.frame = self.ticketType.bounds;
        layer.path = path.CGPath;
        self.ticketType.layer.mask = layer;
    });
    
    MyLinearLayout *infoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    infoLy.weight = 1;
    infoLy.myLeft = 55;
    infoLy.myHeight = 100;
    infoLy.padding = UIEdgeInsetsMake(0, 8, 0, 8);
    [ticketLy addSubview:infoLy];
    
    self.ticketTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    self.ticketTitle.font = [UIFont systemFontOfSize:15];
    self.ticketTitle.textColor = UIColor.blackColor;
    self.ticketTitle.text = @"仅可购买金字火腿产品";
    self.ticketTitle.myHorzMargin = 0;
    self.ticketTitle.myHeight = 23;
    self.ticketTitle.myTop = 20;
    [infoLy addSubview:self.ticketTitle];
    
    self.ticketRange = [[UILabel alloc] initWithFrame:CGRectZero];
    self.ticketRange.font = [UIFont systemFontOfSize:12];
    self.ticketRange.textColor = [UIColor colorWithHexString:@"#999999"];
    self.ticketRange.text = @"有效期:2019.08.01-2020.09.01";
    self.ticketRange.myTop = 18;
    self.ticketRange.myHorzMargin = 0;
    self.ticketRange.myHeight = 20;
    [infoLy addSubview:self.ticketRange];
    
    UIButton *rightBtn = [BaseButton CreateBaseButtonTitle:@"立 即 领 取" Target:self Action:nil Font:[UIFont systemFontOfSize:13 weight:UIFontWeightMedium] BackgroundColor:UIColor.whiteColor Color:UIColor.redColor Frame:CGRectZero Alignment:NSTextAlignmentNatural Tag:0];
    rightBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    rightBtn.titleLabel.numberOfLines = 0;
    rightBtn.myWidth = 20;
    rightBtn.myHeight = 100;
    rightBtn.myRight = 10;
    [ticketLy addSubview:rightBtn];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end

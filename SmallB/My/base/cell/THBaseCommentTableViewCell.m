//
//  THBaseCommentTableViewCell.m
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import "THBaseCommentTableViewCell.h"

@interface THBaseCommentTableViewCell ()

@end

@implementation THBaseCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    self.contentView.backgroundColor = KBGColor;
    
    self.bgView = [[UIView alloc]init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 12, 0, 12));
    }];
    
    self.separatorLineView = [[UIView alloc]init];
    self.separatorLineView.backgroundColor = KBlackLineColor;
    [self.bgView addSubview:self.separatorLineView];
    [self.separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(12);
        make.right.mas_equalTo(self.bgView).offset(-12);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(self.bgView).offset(-1);
    }];
    [self k_creatSubViews];
}

- (void)k_creatSubViews {
    
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self pcj_updateRoundCorners];
}

#pragma mark ================ Target-Actions ================

#pragma mark ================ Interfaces ================
- (void)defualtCornerInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    self.separatorLineView.hidden = NO;
    if (self.isAutoCorner) {
        // 自动圆角
        NSInteger rows = [tableView numberOfRowsInSection:indexPath.section];
        if (indexPath.row == 0) {
            if (rows == 1) {
                // 只有1行
                self.roundCorners = UIRectCornerAllCorners;
                self.separatorLineView.hidden = YES;
            }else {
                self.roundCorners = UIRectCornerTopRight | UIRectCornerTopLeft;
            }
        }else if (indexPath.row == rows - 1) {
            self.separatorLineView.hidden = YES;
            self.roundCorners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
        }else {
            self.roundCorners = 0;
        }
    }
    
    [self setNeedsDisplay];
}

#pragma mark ================ Privates ================
- (void)pcj_updateRoundCorners
{
    if (_roundCorners == 0 || (self.cornerRadii && self.cornerRadii.floatValue <= 0)) {
        _bgView.layer.mask = nil;//无圆角
    }else {
        CGFloat cornerRadii = (self.cornerRadii ? self.cornerRadii.floatValue : 10.0f);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:_roundCorners cornerRadii:CGSizeMake(cornerRadii, cornerRadii)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bgView.bounds;
        maskLayer.path = maskPath.CGPath;
        _bgView.layer.mask = maskLayer;
    }
}

#pragma mark ================ Getters-Setters ================
- (void)setBgViewContentInset:(UIEdgeInsets)bgViewContentInset
{
    _bgViewContentInset = bgViewContentInset;
    
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(self.bgViewContentInset.top);
        make.left.equalTo(self.contentView).offset(self.bgViewContentInset.left);
        make.right.equalTo(self.contentView).offset(-self.bgViewContentInset.right);
        make.bottom.equalTo(self).offset(-self.bgViewContentInset.bottom);
    }];
}

@end

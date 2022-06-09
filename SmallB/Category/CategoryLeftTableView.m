//
//  CategoryLeftTableView.m
//  SmallB
//
//  Created by zhang on 2022/4/18.
//

#import "CategoryLeftTableView.h"
#import "CategoryLeftTableCell.h"

@interface CategoryLeftTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation CategoryLeftTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.rowHeight = 50;
        self.selectedRow = 0;
        self.separatorStyle =  UITableViewCellSeparatorStyleNone;
        [self registerClass:CategoryLeftTableCell.class forCellReuseIdentifier:[CategoryLeftTableCell description]];
    }
    return self;
}

#pragma mark -------UITabelViewdataSource-------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataAry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryLeftTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[CategoryLeftTableCell description]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.selectedRow == indexPath.row){
        cell.backgroundColor = KWhiteBGColor;
        cell.titleLabel.textColor = KMaintextColor;
        cell.titleLabel.font = DEFAULT_FONT_M(15);
    }else {
        cell.backgroundColor = kRGB(245, 245, 245);
        cell.titleLabel.textColor = KBlack666TextColor;
        cell.titleLabel.font = DEFAULT_FONT_R(13);
    }
    if (self.dataAry.count) {
        GoodsCategoryListVosModel *model = self.dataAry[indexPath.row];
        cell.titleLabel.text = model.categoryName;
    }
    return cell;
}

-(void)setDataAry:(NSMutableArray *)dataAry{
    _dataAry = dataAry;
    [self reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedRow = indexPath.row;
    if (self.CellSelectedBlock) {
        self.CellSelectedBlock(indexPath);
    }
    [tableView reloadData];
}

@end


//
//  GMProductAreaTableView.m
//  GoodWine
//
//  Created by LMK on 2019/11/29.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMProductAreaTableView.h"
#import "GMProductListTableViewCell.h"

static NSString *productAreaTableCellID = @"productAreaTableCellID";

@interface GMProductAreaTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray <HomePageTypeItem *>*dataArray;

@end

@implementation GMProductAreaTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = COLOR_TABLE_BG_RAY;
        [self registerClass:[GMProductListTableViewCell class] forCellReuseIdentifier:productAreaTableCellID];
    }
    return self;
}

- (void)reloadProductAreaTableViewWithDataArray:(NSMutableArray<HomePageTypeItem *> *)datatArray {
    self.dataArray = datatArray;
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    }else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

#pragma mark --tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GMProductListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:productAreaTableCellID forIndexPath:indexPath];
    [cell updateProductListCellWithModel:self.dataArray[indexPath.row]];
    cell.detailLabel.hidden = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.productAreaDelegate && [self.productAreaDelegate respondsToSelector:@selector(productAreaTableViewDidSelectItemModel:)]) {
        [self.productAreaDelegate productAreaTableViewDidSelectItemModel:self.dataArray[indexPath.row]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

@end

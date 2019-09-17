//
//  GMBrandAreaTableView.m
//  GoodWine
//
//  Created by LMK on 2019/8/27.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMBrandAreaTableView.h"
#import "GMBrandTableViewCell.h"

static NSString *brandAreaTableCellID = @"brandAreaTableCellID";

@interface GMBrandAreaTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger lastIndex;

@end

@implementation GMBrandAreaTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = COLOR_TABLE_BG_RAY;
        self.lastIndex = 0;
        [self registerClass:[GMBrandTableViewCell class] forCellReuseIdentifier:brandAreaTableCellID];
    }
    return self;
}

- (void)reloadTableViewWithDataArray:(NSArray <BrandAreaInfoModel *> *)array {
    self.dataArray = array;
    
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
    
    GMBrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:brandAreaTableCellID forIndexPath:indexPath];
    BrandAreaInfoModel *model = self.dataArray[indexPath.row];
    [cell updateCellWithLabelText:model.name];
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    } else {
        cell.backgroundColor = COLOR_GRAY_244;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row != self.lastIndex) {
        GMBrandTableViewCell *lastCell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.lastIndex inSection:0]];
        lastCell.backgroundColor = COLOR_GRAY_244;
        
        GMBrandTableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        
        self.lastIndex = indexPath.row;
        
        if (self.brandTBDelegate && [self.brandTBDelegate respondsToSelector:@selector(brandAreaTableViewDidSelectRowAtIndex:)]) {
            [self.brandTBDelegate brandAreaTableViewDidSelectRowAtIndex:indexPath.row];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}


@end

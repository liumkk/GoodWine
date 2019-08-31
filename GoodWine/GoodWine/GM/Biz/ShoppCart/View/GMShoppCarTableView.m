//
//  GMShoppCarTableView.m
//  GoodWine
//
//  Created by LMK on 2019/8/7.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMShoppCarTableView.h"
#import "GMShoppCarTableViewCell.h"

static NSString *shoppCarTableCellID = @"shoppCarTableCellID";

@interface GMShoppCarTableView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray <ShoppCarInfoModel *> *dataArray;

@end

@implementation GMShoppCarTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = COLOR_GRAY_244;
        
        [self registerClass:[GMShoppCarTableViewCell class] forCellReuseIdentifier:shoppCarTableCellID];
    }
    return self;
}

- (void)reloadTableViewWithDataArray:(NSArray <ShoppCarInfoModel *>*)dataArray {
    self.dataArray = dataArray;
    
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
    
    GMShoppCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shoppCarTableCellID forIndexPath:indexPath];
    [cell updateShoppCarTableCellWithModel:self.dataArray[indexPath.row] needLine:indexPath.row != 0];
    cell.selectBtn.tag = indexPath.row + 1;
    [cell.selectBtn addTarget:self action:@selector(cellSelectBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    cell.jiaBtn.tag = indexPath.row + 1;
    [cell.jiaBtn addTarget:self action:@selector(addNumAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.jianBtn.tag = indexPath.row + 1;
    [cell.jianBtn addTarget:self action:@selector(jianNumAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)cellSelectBtnAction:(UIButton *)btn {
    if (self.shoppCarCellDelegate && [self.shoppCarCellDelegate respondsToSelector:@selector(shoppCarTableCellSelectBtn:)]) {
        [self.shoppCarCellDelegate shoppCarTableCellSelectBtn:btn];
    }
}

- (void)addNumAction:(UIButton *)btn {
    if (self.shoppCarCellDelegate && [self.shoppCarCellDelegate respondsToSelector:@selector(addNumAtIndex:isAdd:)]) {
        [self.shoppCarCellDelegate addNumAtIndex:btn.tag - 1 isAdd:YES];
    }
}

- (void)jianNumAction:(UIButton *)btn {
    if (self.shoppCarCellDelegate && [self.shoppCarCellDelegate respondsToSelector:@selector(addNumAtIndex:isAdd:)]) {
        [self.shoppCarCellDelegate addNumAtIndex:btn.tag - 1 isAdd:NO];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.shoppCarCellDelegate && [self.shoppCarCellDelegate respondsToSelector:@selector(shoppCarTableViewDeleteRowAtIndex:)]) {
        [self.shoppCarCellDelegate shoppCarTableViewDeleteRowAtIndex:indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [GMShoppCarTableViewCell heightForCell];
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

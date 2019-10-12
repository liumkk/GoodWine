//
//  GMOrderListTableView.m
//  GoodWine
//
//  Created by LMK on 2019/9/9.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderListTableView.h"
#import "GMOrderAddressTableViewCell.h"
#import "GMOrderListTableViewCell.h"
#import "GMOrderProductTableViewCell.h"
#import "GMSettingTableViewCell.h"
#import "GMOrderSnTableViewCell.h"

static NSString *orderCellID = @"orderCellID";
static NSString *orderListAddressCellID = @"orderListAddressCellID";
static NSString *orderListCellID = @"orderListCellID";

@interface GMOrderListTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray <GMOrderDetailInfoModel *> *modelArray;

@end

@implementation GMOrderListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = COLOR_TABLE_BG_RAY;
        
        [self registerClass:[GMOrderSnTableViewCell class] forCellReuseIdentifier:orderCellID];
        [self registerClass:[GMOrderAddressTableViewCell class] forCellReuseIdentifier:orderListAddressCellID];
        [self registerClass:[GMOrderProductTableViewCell class] forCellReuseIdentifier:orderListCellID];
    }
    return self;
}

- (void)reloadTableViewWithDataArray:(NSArray <GMOrderDetailInfoModel *> *)array {
    self.modelArray = array;
    
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    }else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

#pragma mark --tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.modelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GMOrderDetailInfoModel *model = self.modelArray[section];
    return model.orderArray.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        GMOrderSnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCellID forIndexPath:indexPath];
        GMOrderDetailInfoModel *model = self.modelArray[indexPath.section];
//        [cell updateCellImageName:@"goodWine" title:model.orderSn content:[model.status statusFormatterWithType:model.commentType] needLine:NO];
//        cell.contentLabel.textColor = COLOR_THEME_COLOR;
        cell.statusBtn.tag = indexPath.section;
        [cell.statusBtn addTarget:self action:@selector(statusAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell updateCellWithModel:model];
        return cell;
    } else if (indexPath.row == 1) {
        GMOrderAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderListAddressCellID forIndexPath:indexPath];
        [cell updateCellWithOrderDetailModel:self.modelArray[indexPath.section]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    } else {
        GMOrderProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderListCellID forIndexPath:indexPath];
        GMOrderDetailInfoModel *model = self.modelArray[indexPath.section];
        [cell updateOrderProductTableCellWithOrderItem:model.orderArray[indexPath.row-2]];
        return cell;
    }
    return nil;
    
}

- (void)statusAction:(UIButton *)btn {
    if (self.orderListDelegate && [self.orderListDelegate respondsToSelector:@selector(orderListTableViewStatusAtIndex:)]) {
        [self.orderListDelegate orderListTableViewStatusAtIndex:btn.tag];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.orderListDelegate && [self.orderListDelegate respondsToSelector:@selector(orderListTableViewDeleteRowAtIndexPath:)]) {
        [self.orderListDelegate orderListTableViewDeleteRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 40.f;
    } else if (indexPath.row == 1) {
        return 60.f;
    } else {
        return 90.f;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10.f;
}


@end

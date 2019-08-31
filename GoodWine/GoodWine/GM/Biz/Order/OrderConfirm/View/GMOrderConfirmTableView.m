//
//  GMOrderConfirmTableView.m
//  GoodWine
//
//  Created by LMK on 2019/8/14.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderConfirmTableView.h"
#import "GMOrderAddressTableViewCell.h"
#import "GMOrderProductTableViewCell.h"

static NSString *orderAddressCellID = @"orderAddressCellID";
static NSString *orderProductCellID = @"orderProductCellID";
static NSString *orderDetailCellID = @"orderDetailCellID";

@interface GMOrderConfirmTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *contentArray;
@property (nonatomic, strong) NSArray *amountTitleArray;
@property (nonatomic, strong) NSArray *amountArray;

@property (nonatomic, strong) NSArray <ShoppCarInfoModel *> *dataArray;
@property (nonatomic, strong) GMAddressInfoModel*addressModel;
@property (nonatomic, strong) CalcAmountInfoModel *amountModel;

@end

@implementation GMOrderConfirmTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.titleArray = @[@"支付方式", @"发票", @"请选择优惠券", @"配送方式", @"请选择配送时间"];
        self.contentArray = @[@"线上支付", @"普通发票", @"点击选择优惠券", @"商家配送", @"立即配送"];
        self.amountTitleArray = @[@"商品总价",@"配送费",@"已优惠"];
        
        [self registerClass:[GMOrderAddressTableViewCell class] forCellReuseIdentifier:orderAddressCellID];
        [self registerClass:[GMOrderProductTableViewCell class] forCellReuseIdentifier:orderProductCellID];
        [self registerClass:[GMKeyValueInfoCell class] forCellReuseIdentifier:orderDetailCellID];
    }
    return self;
}

- (void)reloadTableViewWithAddressModel:(GMAddressInfoModel *)model {
    self.addressModel = model;
    
    if ([[NSThread currentThread] isMainThread]) {
       [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

- (void)reloadTableViewWithDataArray:(NSArray <ShoppCarInfoModel *> *)dataArray model:(CalcAmountInfoModel *)model{
    self.dataArray = dataArray;
    self.amountModel = model;
    self.amountArray = @[[model.totalAmount formatterYuan],[model.freightAmount formatterYuan],@"￥0.00"];
    
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadSections:[[NSIndexSet alloc]initWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        [self reloadSections:[[NSIndexSet alloc]initWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
    }else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

#pragma mark --tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
       return self.dataArray.count;
    }else if (section == 2) {
        return self.titleArray.count;
    } else {
        return self.amountTitleArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        GMOrderAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderAddressCellID forIndexPath:indexPath];
        [cell updateCellWithModel:self.addressModel];
        return cell;
    } else if(indexPath.section == 1) {
        GMOrderProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderProductCellID forIndexPath:indexPath];
        [cell updateOrderProductTableCellWithModel:self.dataArray[indexPath.row]];
        return cell;
    }else if(indexPath.section == 2) {
        GMKeyValueInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:orderDetailCellID forIndexPath:indexPath];
        if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        [cell updateCellContentWithCellType:GMKVInfoCellTypeDefaultLabel leftText:self.titleArray[indexPath.row] rightText:self.contentArray[indexPath.row] needLine:indexPath.row != 0];
        return cell;
    } else {
        GMKeyValueInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:orderDetailCellID forIndexPath:indexPath];
        [cell updateCellContentWithCellType:GMKVInfoCellTypeDefaultLabel leftText:self.amountTitleArray[indexPath.row] rightText:self.amountArray[indexPath.row] needLine:indexPath.row != 0];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.orderConfirmDelegate && [self.orderConfirmDelegate respondsToSelector:@selector(orderConfirmTableView:didSelectRowAtIndexPath:)]) {
        [self.orderConfirmDelegate orderConfirmTableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 80.f;
    } else if (indexPath.section == 1) {
        return [GMOrderProductTableViewCell heightForCell];
    } else {
        return 60.f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 3) {
        return 10.f;
    } else {
        return CGFLOAT_MIN;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

@end

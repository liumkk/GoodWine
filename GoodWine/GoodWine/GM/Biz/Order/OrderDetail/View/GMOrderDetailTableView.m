//
//  GMOrderDetailTableView.m
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderDetailTableView.h"
#import "GMOrderAddressTableViewCell.h"
#import "GMOrderProductTableViewCell.h"

static NSString *orderAddressCellID = @"orderAddressCellID";
static NSString *orderProductCellID = @"orderProductCellID";
static NSString *orderDetailCellID = @"orderDetailCellID";

@interface GMOrderDetailTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *contentArray;
@property (nonatomic, strong) NSArray *amountTitleArray;
@property (nonatomic, strong) NSArray *amountArray;

@property (nonatomic, strong) GMOrderDetailInfoModel *orderInfoModel;

@end

@implementation GMOrderDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = COLOR_TABLE_BG_RAY;
        self.amountTitleArray = @[@"商品总价",@"配送费",@"已优惠"];
        
        [self registerClass:[GMOrderAddressTableViewCell class] forCellReuseIdentifier:orderAddressCellID];
        [self registerClass:[GMOrderProductTableViewCell class] forCellReuseIdentifier:orderProductCellID];
        [self registerClass:[GMKeyValueInfoCell class] forCellReuseIdentifier:orderDetailCellID];
    }
    return self;
}

- (void)reloadTableViewWithModel:(GMOrderDetailInfoModel *)model myModel:(GMMyOrderDetailModel *)myOrder {
    self.orderInfoModel = model;
    NSString *time = myOrder.expectedTime;
    if (IsStrEmpty(time)) {
        time = @"立即配送";
    }
    self.titleArray = @[@"支付方式", @"订单编号", @"优惠券", @"配送方式", @"配送时间"];
    self.contentArray = @[@"线上支付", model.orderSn, @"", @"商家配送", time];
    self.amountArray = @[[model.totalAmount formatterYuan],@"￥0.00",[model.couponAmount formatterYuan]];
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
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
        return self.orderInfoModel.orderArray.count;
    }else if (section == 2) {
        return self.titleArray.count;
    } else {
        return self.amountTitleArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        GMOrderAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderAddressCellID forIndexPath:indexPath];
        [cell updateCellWithOrderDetailModel:self.orderInfoModel];
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    } else if(indexPath.section == 1) {
        GMOrderProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderProductCellID forIndexPath:indexPath];
        [cell updateOrderProductTableCellWithOrderItem:self.orderInfoModel.orderArray[indexPath.row]];
        return cell;
    }else if(indexPath.section == 2) {
        GMKeyValueInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:orderDetailCellID forIndexPath:indexPath];
        if (indexPath.row == 1) {
            cell.rightLabel.textColor = COLOR_THEME_COLOR;
        }
        [cell updateCellContentWithCellType:GMKVInfoCellTypeDefaultLabel leftText:self.titleArray[indexPath.row] rightText:self.contentArray[indexPath.row] needLine:indexPath.row != 0];
        return cell;
    } else {
        GMKeyValueInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:orderDetailCellID forIndexPath:indexPath];
        [cell updateCellContentWithCellType:GMKVInfoCellTypeDefaultLabel leftText:self.amountTitleArray[indexPath.row] rightText:self.amountArray[indexPath.row] needLine:indexPath.row != 0];
        if (indexPath.row != 0) {
            cell.rightLabel.textColor = COLOR_THEME_COLOR;
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (self.orderConfirmDelegate && [self.orderConfirmDelegate respondsToSelector:@selector(orderConfirmTableView:didSelectRowAtIndexPath:)]) {
//        [self.orderConfirmDelegate orderConfirmTableView:tableView didSelectRowAtIndexPath:indexPath];
//    }
    
}

- (void)payBtnAction:(UIButton *)btn {
    if (self.orderDetailDelegate && [self.orderDetailDelegate respondsToSelector:@selector(payOrder)]) {
        [self.orderDetailDelegate payOrder];
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
    if (section == 0) {
        return self.detailHeaderView;
    } else {
        return [UIView new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 150.f;
    } else if (section == 1 || section == 3) {
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

- (GMOrderDetailHeaderView *)detailHeaderView {
    if (! _detailHeaderView) {
        _detailHeaderView = [[GMOrderDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 0)];
        [_detailHeaderView.payBtn addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _detailHeaderView;
}

@end

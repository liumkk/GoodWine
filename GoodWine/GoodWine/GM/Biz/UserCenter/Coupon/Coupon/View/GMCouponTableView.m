//
//  GMCouponTableView.m
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMCouponTableView.h"
#import "GMCouponTableViewCell.h"

static NSString *couponListCellID = @"couponListCellID";

@interface GMCouponTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray <CouponInfoModel *> *dataArray;

@end

@implementation GMCouponTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = COLOR_TABLE_BG_RAY;
        [self registerClass:[GMCouponTableViewCell class] forCellReuseIdentifier:couponListCellID];
    }
    return self;
}

- (void)reloadTableViewWithDataArray:(NSArray <CouponInfoModel*> *)array {
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
    
    GMCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:couponListCellID forIndexPath:indexPath];
    [cell updateCouponCellWithModel:self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.couponDelegate && [self.couponDelegate respondsToSelector:@selector(couponTableViewDidSelectRowAtIndex:)]) {
        [self.couponDelegate couponTableViewDidSelectRowAtIndex:indexPath.row];
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}


@end

//
//  GMMyCouponTableView.m
//  GoodWine
//
//  Created by LMK on 2019/9/16.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMMyCouponTableView.h"
#import "GMMyCouponTableViewCell.h"

static NSString *myCouponCellID = @"myCouponCellID";

@interface GMMyCouponTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray <MyCouponInfoModel *> *dataArray;

@end

@implementation GMMyCouponTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = COLOR_TABLE_BG_RAY;
        [self registerClass:[GMMyCouponTableViewCell class] forCellReuseIdentifier:myCouponCellID];
    }
    return self;
}

- (void)reloadTableViewWithDataArray:(NSArray <MyCouponInfoModel*> *)array {
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
    
    GMMyCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCouponCellID forIndexPath:indexPath];
    [cell updateMyCouponCellWithModel:self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.myCouponDelegate && [self.myCouponDelegate respondsToSelector:@selector(myCouponTableViewDidSelectRowAtIndex:)]) {
        [self.myCouponDelegate myCouponTableViewDidSelectRowAtIndex:indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 5.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

@end

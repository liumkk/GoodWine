//
//  GMAddressManageTableView.m
//  GoodWine
//
//  Created by LMK on 2019/8/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMAddressManageTableView.h"
#import "GMAddressManageTableViewCell.h"

static NSString *addressCellID = @"addressCellID";

@interface GMAddressManageTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<GMAddressInfoModel *> *dataArray;
@property (nonatomic, strong) GMTableViewFooterView *footerView;


@end

@implementation GMAddressManageTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
//        self.estimatedRowHeight = 100.f;
//        self.rowHeight = UITableViewAutomaticDimension;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        [self registerClass:[GMAddressManageTableViewCell class] forCellReuseIdentifier:addressCellID];
    }
    return self;
}

- (void)reloadTableViewWithDataArray:(NSArray<GMAddressInfoModel *> *)dataArray {
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
    
    GMAddressManageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCellID forIndexPath:indexPath];
    [cell updateAddressCellWithModel:self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self deselectRowAtIndexPath:indexPath animated:YES];
    
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100.f;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.f;;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 80.f;
}

- (void)addBtnAction:(UIButton *)btn {
    if (self.addressDelegate && [self.addressDelegate respondsToSelector:@selector(addAddress)]) {
        [self.addressDelegate addAddress];
    }
}

- (GMTableViewFooterView *)footerView {
    if (! _footerView) {
        _footerView = [[GMTableViewFooterView alloc] initWithFrame:CGRectZero title:@"添加地址"];
        [_footerView.confirmBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}

@end

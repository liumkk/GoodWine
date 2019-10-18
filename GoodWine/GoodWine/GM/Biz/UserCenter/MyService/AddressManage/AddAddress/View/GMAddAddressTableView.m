//
//  GMAddAddressTableView.m
//  GoodWine
//
//  Created by LMK on 2019/8/5.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMAddAddressTableView.h"

static NSString *addAddressTableCell = @"addAddressTableCell";

@interface GMAddAddressTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *sourceArray;
@property (nonatomic, strong) GMTableViewFooterView *footerView;

@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *addressTF;
@property (nonatomic, strong) UITextField *detailAddressTF;

@end

@implementation GMAddAddressTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = COLOR_TABLE_BG_RAY;
//        self.tableHeaderView = [UIView new];
        [self registerClass:[GMKeyValueInfoCell class] forCellReuseIdentifier:addAddressTableCell];
    }
    return self;
}

- (void)reloadTableViewWithSource {
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    }else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

#pragma mark --tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GMKeyValueInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:addAddressTableCell forIndexPath:indexPath];
    [cell updateCellContentWithCellType:GMKVInfoCellTypeOnlyTextField leftText:@"" rightText:self.sourceArray[indexPath.row] needLine:indexPath.row != 0];
    if (indexPath.row == 0) {
        self.nameTF = (UITextField *)cell.currentControl;
    } else if (indexPath.row == 1) {
        self.phoneTF = (UITextField *)cell.currentControl;
        self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    } else if (indexPath.row == 2) {
        self.addressTF = (UITextField *)cell.currentControl;
    } else if (indexPath.row == 3) {
        self.detailAddressTF = (UITextField *)cell.currentControl;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self deselectRowAtIndexPath:indexPath animated:YES];
    
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 80.f;
}

- (void)confirmBtnAction:(UIButton *)btn {
    if (self.addAddressDelegate && [self.addAddressDelegate respondsToSelector:@selector(addAddressTableViewConfirmBtnName:phoneNum:address:detailAddess:)]) {
        [self.addAddressDelegate addAddressTableViewConfirmBtnName:self.nameTF.text phoneNum:self.phoneTF.text address:self.addressTF.text detailAddess:self.detailAddressTF.text];
    }
}

- (NSArray *)sourceArray {
    return @[@"请输入收货人姓名",@"请输入收货人号码",@"请输入地址(精确到市、县)",@"请输入详细地址(精确到门牌号)"];
}

- (GMTableViewFooterView *)footerView {
    if (! _footerView) {
        _footerView = [[GMTableViewFooterView alloc] initWithFrame:CGRectZero title:@"确认添加"];
        _footerView.backgroundColor = COLOR_TABLE_BG_RAY;
        [_footerView.confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}

@end

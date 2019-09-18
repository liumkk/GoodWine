//
//  GMModifyTableView.m
//  GoodWine
//
//  Created by LMK on 2019/9/9.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMModifyTableView.h"
#import "MKTextFieldTableViewCell.h"

static NSString *modifyPasswordTableCellID = @"modifyPasswordTableCellID";

@interface GMModifyTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *verficationTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) GMTableViewFooterView *footerView;

@end
@implementation GMModifyTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = COLOR_TABLE_BG_RAY;
        [self registerClass:[MKTextFieldTableViewCell class] forCellReuseIdentifier:modifyPasswordTableCellID];
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
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:modifyPasswordTableCellID forIndexPath:indexPath];
    if (indexPath.row == 0) {
        [cell updateTextFieldCellType:MKTextFieldCellTypeDefault placeholder:@"请输入手机号"];
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.phoneTF = cell.textField;
    } else if (indexPath.row == 1) {
        [cell updateTextFieldCellType:MKTextFieldCellTypeVerficationCode placeholder:@"请输入短信验证码"];
        self.verficationTF = cell.textField;
    } else {
        [cell updateTextFieldCellType:MKTextFieldCellTypeEye placeholder:@"请设置密码"];
        self.passwordTF = cell.textField;
    }
    return cell;
}

- (void)registerAction:(UIButton *)btn {
//    if (self.forgetPwdTBDelegate && [self.forgetPwdTBDelegate respondsToSelector:@selector(registerTableViewPhoneTF:verficationTF:passwordTF:)]) {
//        [self.forgetPwdTBDelegate registerTableViewPhoneTF:self.phoneTF verficationTF:self.verficationTF passwordTF:self.passwordTF];
//    }
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 80.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.footerView;
}

- (GMTableViewFooterView *)footerView {
    if (! _footerView) {
        _footerView = [[GMTableViewFooterView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 0) title:@"完成"];
        [_footerView.confirmBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}

@end

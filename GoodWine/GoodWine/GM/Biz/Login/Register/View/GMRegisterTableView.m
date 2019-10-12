//
//  GMRegisterTableView.m
//  GoodWine
//
//  Created by LMK on 2019/8/22.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMRegisterTableView.h"
#import "MKTextFieldTableViewCell.h"

static NSString *registerTableCellID = @"registerTableCellID";

@interface GMRegisterTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *verficationTF;
@property (nonatomic, strong) UITextField *passwordTF;

@end

@implementation GMRegisterTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = COLOR_TABLE_BG_RAY;
        [self registerClass:[MKTextFieldTableViewCell class] forCellReuseIdentifier:registerTableCellID];
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
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:registerTableCellID forIndexPath:indexPath];
    if (indexPath.row == 0) {
        [cell updateTextFieldCellType:MKTextFieldCellTypeDefault placeholder:@"请输入用户名"];
        self.nameTF = cell.textField;
    } else if (indexPath.row == 1) {
        [cell updateTextFieldCellType:MKTextFieldCellTypeDefault placeholder:@"请输入手机号"];
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.phoneTF = cell.textField;
    } else if (indexPath.row == 2) {
        [cell updateTextFieldCellType:MKTextFieldCellTypeVerficationCode placeholder:@"请输入短信验证码"];
        [cell.verificationView.verifyButton addTarget:self action:@selector(sendVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
        self.verificationView = cell.verificationView;
        self.verficationTF = cell.textField;
    } else {
        [cell updateTextFieldCellType:MKTextFieldCellTypeEye placeholder:@"请设置密码"];
        self.passwordTF = cell.textField;
    }
    return cell;
}

- (void)sendVerificationCode:(UIButton *)btn {
    if (self.registerTBDelegate && [self.registerTBDelegate respondsToSelector:@selector(sendVerificationCodeWithPhone:)]) {
        [self.registerTBDelegate sendVerificationCodeWithPhone:self.phoneTF.text];
    }
}

- (void)registerAction:(UIButton *)btn {
    if (self.registerTBDelegate && [self.registerTBDelegate respondsToSelector:@selector(registerTableViewNameTF:phoneTF:verficationTF:passwordTF:)]) {
        [self.registerTBDelegate registerTableViewNameTF:self.nameTF phoneTF:self.phoneTF verficationTF:self.verficationTF passwordTF:self.passwordTF];
    }
}

- (void)protocolAction:(UIButton *)btn {
    if (self.registerTBDelegate && [self.registerTBDelegate respondsToSelector:@selector(pushProtocol)]) {
        [self.registerTBDelegate pushProtocol];
    }
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
    
    return 100.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.protocolView;
}

- (GMRegisterFooterView *)protocolView {
    if (! _protocolView) {
        _protocolView = [[GMRegisterFooterView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 30.f)];
        [_protocolView.confirmBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
        [_protocolView.protocolBtn addTarget:self action:@selector(protocolAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _protocolView;
}

@end

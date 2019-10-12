//
//  GMSettingTableView.m
//  GoodWine
//
//  Created by LMK on 2019/9/9.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMSettingTableView.h"
#import "GMSettingTableViewCell.h"

static NSString *settingTableCellID = @"settingTableCellID";
static NSString *settTableCellID = @"settTableCellID";

@interface GMSettingTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) GMTableViewFooterView *footerView;

@end

@implementation GMSettingTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = COLOR_TABLE_BG_RAY;
        [self registerClass:[GMKeyValueInfoCell class] forCellReuseIdentifier:settingTableCellID];
        [self registerClass:[GMSettingTableViewCell class] forCellReuseIdentifier:settTableCellID];
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

- (NSString * )getCacheSize {
    NSInteger cacheSize = [SDImageCache sharedImageCache].getSize;
    
    NSString *totalSizeString = nil;
    if (cacheSize > 1000 * 1000) {
        totalSizeString = [NSString stringWithFormat:@"%.1fM",cacheSize / 1000.0f /1000.0f];
        
    } else if (cacheSize > 1000) {
        totalSizeString = [NSString stringWithFormat:@"%.1fKB",cacheSize / 1000.0f ];
        
    } else {
        totalSizeString = [NSString stringWithFormat:@"%.1fB",cacheSize / 1.0f];
    }
    return totalSizeString;
}

#pragma mark --tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
//        GMKeyValueInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:settingTableCellID forIndexPath:indexPath];
//        [cell updateCellContentWithCellType:GMKVInfoCellTypeLeftImageView leftText:@"修改密码" rightText:@"goodWine" needLine:NO];
//        return cell;
        GMSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settTableCellID forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell updateCellImageName:@"goodWine" title:@"修改密码" content:@"" needLine:YES];
        return cell;
    } else {
        GMSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settTableCellID forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell updateCellImageName:@"goodWine" title:@"清除缓存" content:[self getCacheSize] needLine:YES];
        return cell;
    }
    
    return nil;
}

- (void)confirmAction:(UIButton *)btn {
    if (self.settingDelegate && [self.settingDelegate respondsToSelector:@selector(LogoutAction)]) {
        [self.settingDelegate LogoutAction];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.settingDelegate && [self.settingDelegate respondsToSelector:@selector(settingTableViewDidSelectRowAtIndexPath:)]) {
        [self.settingDelegate settingTableViewDidSelectRowAtIndexPath:indexPath];
    }
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
    
    return 60.f;
}

- (GMTableViewFooterView *)footerView {
    if (! _footerView) {
        _footerView = [[GMTableViewFooterView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 0) title:@"退出登录"];
        [_footerView.confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}

@end

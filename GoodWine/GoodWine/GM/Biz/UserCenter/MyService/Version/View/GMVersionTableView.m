//
//  GMVersionTableView.m
//  GoodWine
//
//  Created by LMK on 2019/8/2.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMVersionTableView.h"
#import "GMVersionHeaderView.h"

static NSString *versionCellID = @"versionCellID";

@interface GMVersionTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) GMVersionHeaderView *headerView;
@property (nonatomic, strong) NSArray *dataArray;


@end

@implementation GMVersionTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = COLOR_TABLE_BG_RAY;
        
        [self registerClass:[GMKeyValueInfoCell class] forCellReuseIdentifier:versionCellID];
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
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GMKeyValueInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:versionCellID forIndexPath:indexPath];
    [cell updateCellContentWithCellType:GMKVInfoCellTypeDefaultLabel leftText:self.dataArray[indexPath.row][LeftTitle] rightText:self.dataArray[indexPath.row][RightTitle] needLine:indexPath.row != 0];
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.versionTBDelegate && [self.versionTBDelegate respondsToSelector:@selector(versionTableViewDidSelectRowAtIndex:)]) {
        [self.versionTBDelegate versionTableViewDidSelectRowAtIndex:indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 180.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (GMVersionHeaderView *)headerView {
    if (! _headerView) {
        _headerView = [[GMVersionHeaderView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 180.f)];
    }
    return _headerView;
}

- (NSArray *)dataArray {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return @[@{LeftTitle : @"当前版本", RightTitle : version},
             @{LeftTitle : @"版本更新", RightTitle : @""},
             @{LeftTitle : @"软件官网", RightTitle : @""}];
}

@end

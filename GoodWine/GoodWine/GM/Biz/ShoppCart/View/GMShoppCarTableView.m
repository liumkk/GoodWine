//
//  GMShoppCarTableView.m
//  GoodWine
//
//  Created by LMK on 2019/8/7.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMShoppCarTableView.h"
#import "GMShoppCarTableViewCell.h"

static NSString *shoppCarTableCellID = @"shoppCarTableCellID";

@interface GMShoppCarTableView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation GMShoppCarTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = COLOR_GRAY_244;
        
        [self registerClass:[GMShoppCarTableViewCell class] forCellReuseIdentifier:shoppCarTableCellID];
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
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GMShoppCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shoppCarTableCellID forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self deselectRowAtIndexPath:indexPath animated:YES];
    
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

//
//  GMServiceTableView.m
//  GoodWine
//
//  Created by LMK on 2019/8/2.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMServiceTableView.h"

static NSString *serviceCellID = @"serviceCellID";

@interface GMServiceTableView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation GMServiceTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = COLOR_TABLE_BG_RAY;
        
        [self registerClass:[GMKeyValueInfoCell class] forCellReuseIdentifier:serviceCellID];
    }
    return self;
}

#pragma mark --tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GMKeyValueInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:serviceCellID forIndexPath:indexPath];
    if (indexPath.row == 0) {
        [cell updateCellContentWithCellType:GMKVInfoCellTypeLeftImageView leftText:@"联系美酒快线平台" rightText:@"goodWine" needLine:indexPath.row != 0];
    } else {
        [cell updateCellContentWithCellType:GMKVInfoCellTypeLeftImageView leftText:@"联系商家" rightText:@"goodWine" needLine:indexPath.row != 0];
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}


@end

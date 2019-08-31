//
//  GMProductEvaluateTableView.m
//  GoodWine
//
//  Created by LMK on 2019/8/19.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMProductEvaluateTableView.h"
#import "GMProductEvaluateTableViewCell.h"

static NSString *productEvaluateCellID = @"productEvaluateCellID";

@interface GMProductEvaluateTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray <ProductEvaluateInfoModel *> *dataArray;


@end

@implementation GMProductEvaluateTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerClass:[GMProductEvaluateTableViewCell class] forCellReuseIdentifier:productEvaluateCellID];
    }
    return self;
}

- (void)reloadTableViewWithDataArray:(NSArray <ProductEvaluateInfoModel *> *)dataArray {
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
    
    GMProductEvaluateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:productEvaluateCellID forIndexPath:indexPath];
    [cell updateEvaluateTableCellWithModel:self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductEvaluateInfoModel *model = self.dataArray[indexPath.row];
    if (!model.contentHeight) {
        model.contentHeight = [model.content heightStringWithFont:evaluateContentCellFont width:Width_Screen-26.f] + 70.f;
    }
    return model.contentHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}


@end

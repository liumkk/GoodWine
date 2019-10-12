//
//  GMProductDetailTableView.m
//  GoodWine
//
//  Created by LMK on 2019/8/16.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMProductDetailTableView.h"
#import "GMProductDetailCell.h"
#import "GMProductEvaluateTableViewCell.h"
#import "GMMoreEvaluateFooterView.h"
#import "GMPicTableViewCell.h"

static  NSString *productCellID = @"productCellID";
static  NSString *productCouponCellID = @"productCouponCellID";
static  NSString *productEvaluateCellID = @"productEvaluateCellID";
static  NSString *productPicCellID = @"productPicCellID";

@interface GMProductDetailTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) GMProductDetailModel *productDetailModel;
@property (nonatomic, strong) NSArray <ProductEvaluateInfoModel*>*evaluateArray;
@property (nonatomic, strong) GMHeaderTitleView *headerView;
@property (nonatomic, strong) GMMoreEvaluateFooterView *evaluateFooterView;
@property (nonatomic, strong) NSArray *albumPics;


@end

@implementation GMProductDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = COLOR_TABLE_BG_RAY;
        [self registerClass:[GMProductDetailCell class] forCellReuseIdentifier:productCellID];
        [self registerClass:[GMKeyValueInfoCell class] forCellReuseIdentifier:productCouponCellID];
        [self registerClass:[GMProductEvaluateTableViewCell class] forCellReuseIdentifier:productEvaluateCellID];
        [self registerClass:[GMPicTableViewCell class] forCellReuseIdentifier:productPicCellID];
    }
    return self;
}

- (void)reloadTableViewWithModel:(GMProductDetailModel *)model evaluateArray:(NSArray <ProductEvaluateInfoModel *>*)evaluateArray {
    self.productDetailModel = model;
    self.albumPics = [self.productDetailModel.albumPics componentsSeparatedByString:@","];
    self.evaluateArray = evaluateArray;
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    }else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

#pragma mark --tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    } else if (section == 2) {
        if (self.evaluateArray.count > 2) {
            return 2;
        } else {
            return self.evaluateArray.count;
        }
    } else {
        return self.albumPics.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        GMProductDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:productCellID];
        [cell updateProductDetailCellWithModel:self.productDetailModel];
        return cell;
    } else if (indexPath.section == 1) {
        GMKeyValueInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:productCouponCellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell updateCellContentWithCellType:GMKVInfoCellTypeDefaultLabel leftText:@"优惠券" rightText:@"进入领券中心" needLine:NO];
        return cell;
    } else if (indexPath.section == 2) {
        GMProductEvaluateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:productEvaluateCellID];
        [cell updateEvaluateTableCellWithModel:self.evaluateArray[indexPath.row]];
        return cell;
    } else {
        GMPicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:productPicCellID];
        [cell updateCellWithImageName:self.albumPics[indexPath.row]];
        return cell;
    }
    
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.productDetailDelegate && [self.productDetailDelegate respondsToSelector:@selector(productDetailScrollViewDidScroll:)]) {
        [self.productDetailDelegate productDetailScrollViewDidScroll:scrollView];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.productDetailDelegate && [self.productDetailDelegate respondsToSelector:@selector(productDetailTableViewDidSelectRowAtIndexPath:)]) {
        [self.productDetailDelegate productDetailTableViewDidSelectRowAtIndexPath:indexPath];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return Width_Screen +80.f;
    } else if (indexPath.section == 1) {
        return 50.f;
    } else if (indexPath.section == 2) {
        ProductEvaluateInfoModel *model = self.evaluateArray[indexPath.row];
        if (!model.contentHeight) {
            model.contentHeight = [model.content heightStringWithFont:evaluateContentCellFont width:Width_Screen-26.f] + 70.f;
        }
        return model.contentHeight;
    } else {
        return 270.f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return self.headerView;
    } else {
        return [UIView new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 2) {
        return 40.f;
    } else {
        return CGFLOAT_MIN;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 2){
        return self.evaluateFooterView;
    } else {
        return [UIView new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 2){
        return 35.f;
    } else {
        return 10.f;
    }
}

- (void)showAllEvaluate:(UIButton *)btn {
    if (self.productDetailDelegate && [self.productDetailDelegate respondsToSelector:@selector(showAllEvaluate)]) {
        [self.productDetailDelegate showAllEvaluate];
    }
}

- (GMHeaderTitleView *)headerView {
    if (! _headerView) {
        _headerView = [[GMHeaderTitleView alloc] initWithFrame:CGRectZero];
        [_headerView updateTitleText:@"评价" titleColor:COLOR_TEXT_BLACK];
    }
    return _headerView;
}

- (GMMoreEvaluateFooterView *)evaluateFooterView {
    if (! _evaluateFooterView) {
        _evaluateFooterView = [[GMMoreEvaluateFooterView alloc] initWithFrame:CGRectMake(0, 5, Width_Screen, 35.f) title:@"查看全部评价"];
        [_evaluateFooterView.confirmBtn addTarget:self action:@selector(showAllEvaluate:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _evaluateFooterView;
}
@end

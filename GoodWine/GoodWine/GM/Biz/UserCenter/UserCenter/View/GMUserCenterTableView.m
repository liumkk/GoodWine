//
//  GMUserCenterTableView.m
//  GoodWine
//
//  Created by LMK on 2019/5/29.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMUserCenterTableView.h"
#import "GMUserInfoCell.h"
#import "GMUserCenterFooterView.h"
#import "GMCollectionView.h"

#define FooterViewHeight        50.f

static NSString *userCenterTableCell = @"userCenterTableCell";

@interface GMUserCenterTableView () <UITableViewDelegate, UITableViewDataSource, GMCollectionViewDelegate>

@property (nonatomic, strong) GMUserCenterFooterView *footerView;
@property (nonatomic, strong) GMCollectionView *collectionView;



@end

@implementation GMUserCenterTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        [self registerClass:[GMUserInfoCell class] forCellReuseIdentifier:userCenterTableCell];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"userCollect"];
    }
    return self;
}

- (void)reloadTableViewWithSource {
    
}

#pragma mark --tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        GMUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:userCenterTableCell forIndexPath:indexPath];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCollect" forIndexPath:indexPath];
        [cell.contentView addSubview:self.collectionView];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return [GMUserInfoCell heightForCell];
    } else {
        return 180.f;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return self.footerView;
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if (section == 0) {
        return FooterViewHeight;
    }
    return CGFLOAT_MIN;
}

- (void)userCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.userTableViewDelegate && [self.userTableViewDelegate respondsToSelector:@selector(userCollectionViewDidSelectRowAtIndex:)]) {
        [self.userTableViewDelegate userCollectionViewDidSelectRowAtIndex:indexPath.item];
    }
}

- (GMUserCenterFooterView *)footerView {
    if (! _footerView) {
        _footerView = [[GMUserCenterFooterView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, FooterViewHeight)];
    }
    return _footerView;
}

- (GMCollectionView *)collectionView {
    if (! _collectionView) {
        _collectionView = [[GMCollectionView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 180.f)];
        _collectionView.collectionDelegate = self;
    }
    return _collectionView;
}

@end

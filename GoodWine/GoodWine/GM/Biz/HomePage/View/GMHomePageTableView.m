//
//  GMHomePageTableView.m
//  GoodWine
//
//  Created by LMK on 2019/5/28.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMHomePageTableView.h"
#import "GMMenuTableViewCell.h"
#import "GMWineListTableViewCell.h"

static NSString *homePageIdentifier = @"homePageIdentifier";
static NSString *menuCellIdentifier = @"menuCellIdentifier";
static NSString *wineListCellIdentifier = @"wineListCellIdentifier";

@interface GMHomePageTableView () <SDCycleScrollViewDelegate>


@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;


@end

@implementation GMHomePageTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
//        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = COLOR_TABLE_BG_COLOR;
        self.estimatedRowHeight = 40;
        self.rowHeight = UITableViewAutomaticDimension;

        
        [self registerClass:[GMKeyValueInfoCell class] forCellReuseIdentifier:homePageIdentifier];
        [self registerClass:[GMMenuTableViewCell class] forCellReuseIdentifier:menuCellIdentifier];
        [self registerClass:[GMWineListTableViewCell class] forCellReuseIdentifier:wineListCellIdentifier];
    }
    return self;
}

- (void)reloadTableViewWithSource {
    
}

#pragma mark --tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else if (section == 1){
        return 3;
    } else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier forIndexPath:indexPath];
        
        return cell;
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:wineListCellIdentifier forIndexPath:indexPath];
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:wineListCellIdentifier forIndexPath:indexPath];
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return [GMMenuTableViewCell heightForCell];
    } else {
        return UITableViewAutomaticDimension;
    }
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.cycleScrollView;
    } else {
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 180.f;
    } else {
        return 30.f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    } else if (section == 1) {
        return @"热门酒水";
    } else {
        return @"门店推荐";
    }
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"didselectItem--%ld",(long)index);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     
}

- (SDCycleScrollView *)cycleScrollView {
    if (! _cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Width_Screen, 150.f) imageNamesGroup:@[@"test",@"test",@"test",@"test",@"test"]];
        _cycleScrollView.delegate = self;
        _cycleScrollView.currentPageDotColor = [UIColor blueColor];
        _cycleScrollView.pageDotColor = [UIColor grayColor];
        [self addSubview:_cycleScrollView];
    }
    return _cycleScrollView;
}

@end

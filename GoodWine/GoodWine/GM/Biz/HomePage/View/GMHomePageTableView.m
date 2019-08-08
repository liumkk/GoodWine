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
@property (nonatomic, strong) NSArray <HomePageTypeItem *> *hotProductArray;
@property (nonatomic, strong) NSArray <HomePageTypeItem *> *storeProductArray;

@end

@implementation GMHomePageTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
//        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = COLOR_TABLE_BG_COLOR;
        self.estimatedRowHeight = 44;
        self.rowHeight = UITableViewAutomaticDimension;

        
        [self registerClass:[GMKeyValueInfoCell class] forCellReuseIdentifier:homePageIdentifier];
        [self registerClass:[GMMenuTableViewCell class] forCellReuseIdentifier:menuCellIdentifier];
        [self registerClass:[GMWineListTableViewCell class] forCellReuseIdentifier:wineListCellIdentifier];
    }
    return self;
}

- (void)updateBannerImageWithHomePageInfoModel:(HomePageInfoModel *)infoModel {
    [self.cycleScrollView clearCache];
    NSMutableArray *bannerArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < infoModel.advertiseArray.count; i ++) {
        HomePageInfoDetailItem *detailItem = infoModel.advertiseArray[i];
        [bannerArray addObject:detailItem.picUrl];
    }
    [self.cycleScrollView setImageURLStringsGroup:bannerArray];
    [self.cycleScrollView setAutoScroll:YES];
}

- (void)reloadHomePageTableViewWithHomePageInfoModel:(HomePageInfoModel *)infoModel {
    self.hotProductArray = infoModel.hotProductArray;
    self.storeProductArray = infoModel.storeProductArray;
    
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    }else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

#pragma mark --tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        GMMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 1) {
        GMWineListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:wineListCellIdentifier forIndexPath:indexPath];
        [cell updateWineListCellWithArray:self.hotProductArray];
        return cell;
    } else {
        GMWineListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:wineListCellIdentifier forIndexPath:indexPath];
        [cell updateWineListCellWithArray:self.storeProductArray];
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
    } else if (indexPath.section == 1){
        return (self.hotProductArray.count/2 + self.hotProductArray.count %2)* 255.f;
    } else {
        return (self.storeProductArray.count/2 + self.storeProductArray.count %2) *255.f;
    }
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
//        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Width_Screen, 150.f) imageNamesGroup:@[@"test",@"test",@"test",@"test",@"test"]];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Width_Screen, 150.f) delegate:self placeholderImage:[UIImage imageNamed:@"test"]];
//        _cycleScrollView.imageURLStringsGroup = nil;
        _cycleScrollView.currentPageDotColor = [UIColor blueColor];
        _cycleScrollView.pageDotColor = [UIColor grayColor];
        _cycleScrollView.autoScroll = YES;
        [self addSubview:_cycleScrollView];
    }
    return _cycleScrollView;
}

@end

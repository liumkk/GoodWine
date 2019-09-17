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

@interface GMHomePageTableView () <SDCycleScrollViewDelegate,GMWineListTableViewCellDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSArray <HomePageTypeItem *> *hotProductArray;
@property (nonatomic, strong) NSArray <HomePageTypeItem *> *freshProductArray;
@property (nonatomic, strong) NSArray <HomePageTypeItem *> *storeProductArray;

@end

@implementation GMHomePageTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.estimatedRowHeight = 44;
        self.rowHeight = UITableViewAutomaticDimension;
        self.backgroundColor = COLOR_TABLE_BG_RAY;
        
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
    self.freshProductArray = infoModel.freshProductArray;
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
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        GMMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier forIndexPath:indexPath];
        [cell.whiteSpiritArea addTarget:self action:@selector(wineArea:) forControlEvents:UIControlEventTouchUpInside];
        [cell.redWineArea addTarget:self action:@selector(wineArea:) forControlEvents:UIControlEventTouchUpInside];
        [cell.otherArea addTarget:self action:@selector(wineArea:) forControlEvents:UIControlEventTouchUpInside];
        [cell.couponArea addTarget:self action:@selector(wineArea:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else if (indexPath.section == 1) {
        GMWineListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:wineListCellIdentifier forIndexPath:indexPath];
        cell.wineListTVCellDelegate = self;
        [cell updateWineListCellWithArray:self.freshProductArray];
        return cell;
    } else if (indexPath.section == 2) {
        GMWineListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:wineListCellIdentifier forIndexPath:indexPath];
        cell.wineListTVCellDelegate = self;
        [cell updateWineListCellWithArray:self.hotProductArray];
        return cell;
    } else {
        GMWineListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:wineListCellIdentifier forIndexPath:indexPath];
        cell.wineListTVCellDelegate = self;
        [cell updateWineListCellWithArray:self.storeProductArray];
        return cell;
    }
    return nil;
}

-(void)collectionViewDidSelectItemWithModel:(HomePageTypeItem *)model {
    if (self.homePageTVDelegate && [self.homePageTVDelegate respondsToSelector:@selector(collectionViewDidSelectItemWithModel:)]) {
        [self.homePageTVDelegate collectionViewDidSelectItemWithModel:model];
    }
}

- (void)wineArea:(UIButton *)btn {
    if (self.homePageTVDelegate && [self.homePageTVDelegate respondsToSelector:@selector(clickWineAreaWithAreaType:)]) {
        [self.homePageTVDelegate clickWineAreaWithAreaType:btn.tag];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return [GMMenuTableViewCell heightForCell];
    } else if (indexPath.section == 1){
        return (self.freshProductArray.count/2 + self.freshProductArray.count %2)* 255.f;
    } else if (indexPath.section == 2){
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
    } else if (section == 1) {
        return self.freshProductArray.count == 0 ? CGFLOAT_MIN : 30.f;
    } else if (section == 2) {
        return self.hotProductArray.count == 0 ? CGFLOAT_MIN : 30.f;
    } else if (section == 3) {
        return self.storeProductArray.count == 0 ? CGFLOAT_MIN : 30.f;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    } else if (section == 1) {
        return @"新品酒水";
    } else if (section == 2) {
        return @"热门酒水";
    } else {
        return @"门店推荐";
    }
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    MKNSLog(@"didselectItem--%ld",(long)index);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     
}

- (SDCycleScrollView *)cycleScrollView {
    if (! _cycleScrollView) {
//        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Width_Screen, 150.f) imageNamesGroup:@[@"test",@"test",@"test",@"test",@"test"]];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Width_Screen, 150.f) delegate:self placeholderImage:[UIImage imageNamed:@"goodWine"]];
//        _cycleScrollView.imageURLStringsGroup = nil;
        _cycleScrollView.currentPageDotColor = [UIColor blueColor];
        _cycleScrollView.pageDotColor = [UIColor grayColor];
//        _cycleScrollView.autoScroll = YES;
        [self addSubview:_cycleScrollView];
    }
    return _cycleScrollView;
}

@end

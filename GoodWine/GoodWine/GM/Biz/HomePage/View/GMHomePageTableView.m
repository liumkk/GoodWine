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
#import "GMProductListTableViewCell.h"

static NSString *menuCellIdentifier = @"menuCellIdentifier";
//static NSString *wineListCellIdentifier = @"wineListCellIdentifier";
static NSString *productListCellID = @"productListCellID";

@interface GMHomePageTableView () <SDCycleScrollViewDelegate,GMWineListTableViewCellDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSArray <HomePageTypeItem *> *hotProductArray;
@property (nonatomic, strong) NSArray <HomePageTypeItem *> *freshProductArray;
@property (nonatomic, strong) NSArray <HomePageTypeItem *> *storeProductArray;
@property (nonatomic, strong) NSArray *advertiseArray;

@property (nonatomic, copy) NSMutableArray *modelArray;
@end

@implementation GMHomePageTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.estimatedRowHeight = 44;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.rowHeight = UITableViewAutomaticDimension;
        self.backgroundColor = COLOR_GRAY_244;
        
        [self registerClass:[GMMenuTableViewCell class] forCellReuseIdentifier:menuCellIdentifier];
//        [self registerClass:[GMWineListTableViewCell class] forCellReuseIdentifier:wineListCellIdentifier];
        [self registerClass:[GMProductListTableViewCell class] forCellReuseIdentifier:productListCellID];
    }
    return self;
}

- (void)updateBannerImageWithHomePageInfoModel:(HomePageInfoModel *)infoModel {
    [self.cycleScrollView clearCache];
    self.advertiseArray = infoModel.advertiseArray;
    NSMutableArray *bannerArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < infoModel.advertiseArray.count; i ++) {
        HomePageInfoDetailItem *detailItem = self.advertiseArray[i];
        [bannerArray addObject:detailItem.picUrl];
    }
    [self.cycleScrollView setImageURLStringsGroup:bannerArray];
    [self.cycleScrollView setAutoScroll:YES];
}

- (void)reloadHomePageTableViewWithHomePageInfoModel:(HomePageInfoModel *)infoModel {
    self.freshProductArray = infoModel.freshProductArray;
    self.hotProductArray = infoModel.hotProductArray;
    self.storeProductArray = infoModel.storeProductArray;
    self.modelArray = [[NSMutableArray alloc] initWithObjects:self.freshProductArray,self.hotProductArray,self.storeProductArray, nil];
    
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
    if (section == 0) {
        return 1;
    } else {
        NSArray *arr = self.modelArray[section - 1];
        return arr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        GMMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier forIndexPath:indexPath];
        [cell.whiteSpiritArea addTarget:self action:@selector(wineArea:) forControlEvents:UIControlEventTouchUpInside];
        [cell.redWineArea addTarget:self action:@selector(wineArea:) forControlEvents:UIControlEventTouchUpInside];
        [cell.otherArea addTarget:self action:@selector(wineArea:) forControlEvents:UIControlEventTouchUpInside];
        [cell.couponArea addTarget:self action:@selector(wineArea:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else{
//        GMWineListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:wineListCellIdentifier forIndexPath:indexPath];
//        cell.wineListTVCellDelegate = self;
//        [cell updateWineListCellWithArray:self.modelArray[indexPath.section - 1]];
//        return cell;
        GMProductListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:productListCellID forIndexPath:indexPath];
        [cell updateProductListCellWithModel:self.modelArray[indexPath.section - 1][indexPath.row]];
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
    if (self.homePageTVDelegate && [self.homePageTVDelegate respondsToSelector:@selector(collectionViewDidSelectItemWithModel:)]) {
        [self.homePageTVDelegate collectionViewDidSelectItemWithModel:self.modelArray[indexPath.section - 1][indexPath.row]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return [GMMenuTableViewCell heightForCell];
    } else {
        return 100.f;
    }
//        return (self.freshProductArray.count/2 + self.freshProductArray.count %2)* ItemHeight;
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
        return 176.f *ScreenScale;
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
    HomePageInfoDetailItem *detailItem = self.advertiseArray[index];
    if (self.homePageTVDelegate && [self.homePageTVDelegate respondsToSelector:@selector(clickAdvertiseWithProductId:)]) {
        [self.homePageTVDelegate clickAdvertiseWithProductId:detailItem.productId];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     
}

- (SDCycleScrollView *)cycleScrollView {
    if (! _cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Width_Screen, 0) delegate:self placeholderImage:nil];
//        _cycleScrollView.imageURLStringsGroup = nil;
        _cycleScrollView.currentPageDotColor = [UIColor blueColor];
        _cycleScrollView.pageDotColor = [UIColor grayColor];
//        _cycleScrollView.autoScroll = YES;
        [self addSubview:_cycleScrollView];
    }
    return _cycleScrollView;
}

@end

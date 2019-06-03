//
//  GMHomePageTableView.m
//  GoodWine
//
//  Created by LMK on 2019/5/28.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMHomePageTableView.h"
#import "GMAdScrollView.h"

static NSString *homePageIdentifier = @"homePageIdentifier";

@interface GMHomePageTableView () <SDCycleScrollViewDelegate>

//@property (nonatomic, strong)GMAdScrollView *adScrollView;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;


@end

@implementation GMHomePageTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = COLOR_TABLE_BG_COLOR;
        
        [self registerClass:[GMKeyValueInfoCell class] forCellReuseIdentifier:homePageIdentifier];
    }
    return self;
}

- (void)reloadTableViewWithSource {
    
}

#pragma mark --tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homePageIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.cycleScrollView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 180.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"didselectItem--%ld",(long)index);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     NSLog(@"scrollView");
}

//- (GMAdScrollView *)adScrollView {
//    if (! _adScrollView) {
//        _adScrollView = [[GMAdScrollView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 150.f) pageNum:4];
//        [self addSubview:_adScrollView];
//    }
//    return _adScrollView;
//}

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

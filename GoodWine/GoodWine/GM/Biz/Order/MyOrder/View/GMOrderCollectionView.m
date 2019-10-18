//
//  GMOrderCollectionView.m
//  GoodWine
//
//  Created by LMK on 2019/8/1.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderCollectionView.h"
#import "GMUserSecondCollectionViewCell.h"

static NSString *orderCollectionCell = @"orderCollectionCell";

@interface GMOrderCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation GMOrderCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(Width_Screen/4 - 1.f, 90.f);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 1.f;
    flowLayout.minimumInteritemSpacing = 1.f;
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        
        [self initData];
        
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = COLOR_TABLE_BG_RAY;
        self.showsVerticalScrollIndicator = YES;//关闭滚动条
        self.bounces = YES;//是否有回弹效果
        self.alwaysBounceVertical = YES; //数据少时也可以竖向滑动
        [self registerClass:[GMUserSecondCollectionViewCell class] forCellWithReuseIdentifier:orderCollectionCell];
    }
    return self;
}

- (void)initData {
    self.titleArray = @[@"待付款", @"待发货", @"已发货", @"已完成", @"已关闭", @"全部订单"];
    self.imageArray = @[@"order_dfk", @"order_dfh", @"order_dsh", @"order_ywc", @"order_yqx", @"order_ysx",];
}

#pragma mark - collectionView dataSource Or delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GMUserSecondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:orderCollectionCell
                                                                                     forIndexPath:indexPath];
    [cell updateCellWithImageString:self.imageArray[indexPath.row] titleText:self.titleArray[indexPath.item]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.orderCollectDelegate && [self.orderCollectDelegate respondsToSelector:@selector(orderCollectionViewDidSelectItemAtIndex:)]) {
        [self.orderCollectDelegate orderCollectionViewDidSelectItemAtIndex:indexPath.item];
    }
}

@end
